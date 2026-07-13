# 24 Board-Level Recipes

Run these commands from the `mc-examples` directory. Each command sets the
library root explicitly so `--lib mcode` loads the repository copy of the
standard library.

Set the library root for an interactive shell if you prefer shorter commands:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

Generated HTML is written next to each example source file.

## Examples

- `241-minimal-mcu-board.mc`: Start a minimal MCU board structure.
- `242-usb-powered-mcu-board.mc`: Combine USB input, regulation, and MCU power.
- `243-i2c-sensor-node.mc`: Compose power, MCU, I2C, and sensor blocks.
- `244-audio-demo-board.mc`: Sketch a small audio-oriented board.

Parse `241-minimal-mcu-board.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 24-board-level-recipes/241-minimal-mcu-board.mc
```

Generate HTML for `241-minimal-mcu-board.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 24-board-level-recipes/241-minimal-mcu-board.mc -o 24-board-level-recipes/241-minimal-mcu-board.html
```
