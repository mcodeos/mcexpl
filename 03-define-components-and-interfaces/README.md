# 03 Define Components And Interfaces

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

- `component` definitions.
- Simple attributes such as `name`.
- `pins` blocks.
- Pin directions such as `io` and `ps`.
- Pin ranges such as `1:3`.
- Interface binding such as `UART0::UART.TTL(DCE)`.

Reused from previous chapters:

- `module main`.
- Component instances.
- Named nets.
- Member access such as `U_MCU.UART0.TX`.

Not covered yet:

- Local functions.
- Conditional pins.
- Cross-file `use`.

## 301 MCU UART Header Component

`301-mcu-uart-header.mc` defines a small MCU component with a UART interface
and plain power pins. The module connects the UART signals to a three-pin debug
header.

Parse `301-mcu-uart-header.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 03-define-components-and-interfaces/301-mcu-uart-header.mc
```

Generate HTML for `301-mcu-uart-header.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 03-define-components-and-interfaces/301-mcu-uart-header.mc -o 03-define-components-and-interfaces/301-mcu-uart-header.html
```

## 302 I2C Sensor Component

`302-i2c-sensor-component.mc` defines a controller component and a sensor
component with matching I2C interfaces. Both devices share `I2C_SCL` and
`I2C_SDA`, and pull-up resistors connect those lines to `V3V3`.

Parse `302-i2c-sensor-component.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 03-define-components-and-interfaces/302-i2c-sensor-component.mc
```

Generate HTML for `302-i2c-sensor-component.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 03-define-components-and-interfaces/302-i2c-sensor-component.mc -o 03-define-components-and-interfaces/302-i2c-sensor-component.html
```

## 303 SPI Flash Component

`303-spi-flash-component.mc` defines master and slave components with SPI
interfaces. The example shows direct member-to-member connections for `CS`,
`SCLK`, `MOSI`, and `MISO`.

Parse `303-spi-flash-component.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 03-define-components-and-interfaces/303-spi-flash-component.mc
```

Generate HTML for `303-spi-flash-component.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 03-define-components-and-interfaces/303-spi-flash-component.mc -o 03-define-components-and-interfaces/303-spi-flash-component.html
```
