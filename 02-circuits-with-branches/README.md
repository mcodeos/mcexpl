# 02 Circuits With Branches

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

- Multiple devices sharing one named node.
- Protection and filter branches from a signal node to `GND`.
- Simple rail branching from one supply node to more than one load.

Reused from previous chapters:

- `module main`.
- Component instances with parameters.
- Units such as `V`, `R`, `nF`, and `mA`.
- Named nets and `->` connections.

Not covered yet:

- Custom `component` definitions.
- `pins` blocks and interface binding.
- Local functions and cross-file `use`.

## 201 Zener Clamp Branch

`201-zener-clamp.mc` describes a resistor-fed Zener clamp. `R_SERIES` creates
the protected `VCLAMP` node, and `Z_CLAMP` forms a branch from that node to
`GND`.

Parse `201-zener-clamp.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 02-circuits-with-branches/201-zener-clamp.mc
```

Generate HTML for `201-zener-clamp.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 02-circuits-with-branches/201-zener-clamp.mc -o 02-circuits-with-branches/201-zener-clamp.html
```

## 202 TVS Input Protection Branch

`202-tvs-input-protection.mc` describes an external input with a small series
resistor and a TVS branch from the protected node to `GND`.

Parse `202-tvs-input-protection.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 02-circuits-with-branches/202-tvs-input-protection.mc
```

Generate HTML for `202-tvs-input-protection.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 02-circuits-with-branches/202-tvs-input-protection.mc -o 02-circuits-with-branches/202-tvs-input-protection.html
```

## 203 Input RC ESD

`203-input-rc-esd.mc` describes a protected analog input. The `ADC_IN` node is
shared by the series resistor output, a small filter capacitor, and an ESD
diode.

Parse `203-input-rc-esd.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 02-circuits-with-branches/203-input-rc-esd.mc
```

Generate HTML for `203-input-rc-esd.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 02-circuits-with-branches/203-input-rc-esd.mc -o 02-circuits-with-branches/203-input-rc-esd.html
```

## 204 Simple Power Branch

`204-simple-power-branch.mc` describes a `V3V3` rail feeding both a bypass
capacitor branch and an LED indicator branch.

Parse `204-simple-power-branch.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 02-circuits-with-branches/204-simple-power-branch.mc
```

Generate HTML for `204-simple-power-branch.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 02-circuits-with-branches/204-simple-power-branch.mc -o 02-circuits-with-branches/204-simple-power-branch.html
```
