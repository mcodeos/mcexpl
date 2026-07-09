# 00 Getting Started

Run these commands from the `mc-examples` directory. Each command sets the
library root explicitly so `--lib mcode` loads the repository copy of the
standard library.

Set the library root for an interactive shell if you prefer shorter commands:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

Generated HTML is written next to each example source file.

## Language Focus

New in this chapter:

- The shape of a minimal `.mc` file.
- `module main`.
- Component instances.
- Basic units such as `V`, `mA`, `R`, and `nF`.
- Simple named nets and `->` connections.
- Short comments that describe circuit intent.

Reused from previous chapters:

- Nothing yet. This is the first tutorial chapter.

Not covered yet:

- Branching circuits.
- Custom `component` definitions.
- `pins` blocks, functions, conditions, and cross-file `use`.

Parse `001-power-net.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 00-getting-started/001-power-net.mc
```

Generate HTML for `001-power-net.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/001-power-net.mc -o 00-getting-started/001-power-net.html
```

Parse `002-resistor-led.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 00-getting-started/002-resistor-led.mc
```

Generate HTML for `002-resistor-led.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/002-resistor-led.mc -o 00-getting-started/002-resistor-led.html
```

Parse `003-decoupling-capacitor.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 00-getting-started/003-decoupling-capacitor.mc
```

Generate HTML for `003-decoupling-capacitor.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/003-decoupling-capacitor.mc -o 00-getting-started/003-decoupling-capacitor.html
```

Parse `004-button-pullup.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 00-getting-started/004-button-pullup.mc
```

Generate HTML for `004-button-pullup.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/004-button-pullup.mc -o 00-getting-started/004-button-pullup.html
```
