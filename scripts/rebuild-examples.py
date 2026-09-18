#!/usr/bin/env python3
"""Check every source and regenerate each runnable example's ignored HTML."""
import argparse
import json
import os
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--mcc', required=True, type=Path)
args = parser.parse_args()
mcc = args.mcc.resolve()
env = dict(os.environ, MCC_SYSTEM_ROOT=str(ROOT.parent), NO_COLOR='1')
report_dir = ROOT / 'target' / 'validation'
report_dir.mkdir(parents=True, exist_ok=True)
results = []
for source in sorted(ROOT.glob('[0-9]*-*/**/*.mc')):
    relative = source.relative_to(ROOT)
    is_entry = bool(re.search(r'^module\s+main\b', source.read_text(), re.M))
    base = [str(mcc), '--local', 'parse', str(relative), '--lib', 'mcode']
    if is_entry:
        base += ['--top', 'main']
    output = source.with_suffix('.html')
    command = base + ['--pass1', '--pass2', '--dlog']
    if is_entry:
        output.unlink(missing_ok=True)
        command += ['--viz', '-o', str(output)]
    checked = subprocess.run(command, cwd=ROOT, env=env, capture_output=True,
                             text=True, timeout=120)
    log = checked.stdout + checked.stderr
    errors = re.findall(r'^.*(?:error\[|Error:|panicked at|[\u2717] ERROR).*$', log, re.M)
    warnings = re.findall(r'^.*(?:warning\[|[\u2717] WARN).*$', log, re.M)
    rendered = None
    if is_entry:
        rendered = output.is_file() and '<svg' in output.read_text()
        if not rendered:
            errors.append('Visualization failed or did not produce SVG HTML.')
    log_path = report_dir / (str(relative).replace('/', '__') + '.log')
    log_path.write_text(log)
    result = dict(source=str(relative), entry=is_entry, returncode=checked.returncode,
                  errors=errors, warnings=warnings, rendered=rendered)
    results.append(result)
    print(f"{'FAIL' if errors or warnings or checked.returncode else 'PASS'} {relative}: "
          f"{len(errors)} errors, {len(warnings)} warnings, HTML={rendered}", flush=True)
(report_dir / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
failed = sum(bool(row['errors'] or row['warnings']) or row['returncode'] != 0 for row in results)
print(f"Checked {len(results)} sources; {failed} failed; "
      f"{sum(row['rendered'] is True for row in results)} HTML files generated.")
raise SystemExit(bool(failed))
