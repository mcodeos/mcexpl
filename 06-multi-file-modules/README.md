# 06 Multi-File Modules

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

- Local `use` statements.
- Cross-file component reuse.
- A small project split into multiple `.mc` files.

Reused from previous chapters:

- `component` definitions.
- Interface binding.
- Component instances.
- Shared bus nodes and pull-up resistors.

## 601 Multi-File Sensor Node

`601-main.mc` imports three local files:

- `601-power.mc` defines the power component.
- `601-mcu.mc` defines the MCU component.
- `601-sensor.mc` defines the I2C sensor component.

The main file connects the MCU and sensor to shared I2C nodes and adds pull-up
resistors.

Parse `601-main.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 06-multi-file-modules/601-main.mc
```

Generate HTML for `601-main.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 06-multi-file-modules/601-main.mc -o 06-multi-file-modules/601-main.html
```
