# 03 Define Components And Interfaces

This chapter moves from library parts to small custom component definitions.
It gives physical pins readable names and binds related pins to standard UART,
I2C, and SPI interfaces.

## 301 MCU UART Header Component

`301-mcu-uart-header.mc` defines an MCU-like part and connects its UART to a
three-pin header. The definition introduces several pieces of syntax:

```mc
component MCU_UART
{
    name = "MCU with UART"
    pins = [
        io 1:3 = UART0::UART.TTL(DCE)
        ps 4 = VCC
        ps 5 = GND
    ]
}
```

- `component MCU_UART` creates a reusable component type rather than a runnable
  module.
- `name =` assigns a display attribute. Quotation marks delimit a string.
- `pins = [...]` declares physical pins; square brackets contain the entries.
- `io` marks signal pins and `ps` marks power-supply pins.
- `1:3` is the inclusive physical-pin range from 1 through 3.
- `UART0::UART.TTL(DCE)` binds that range to a `UART.TTL` interface. `UART0` is
  the local interface name, `::` performs the binding, and `DCE` selects the
  role whose members are `TX`, `RX`, and `GND`.

`MCU_UART U_MCU` instantiates the new type. Paths such as
`U_MCU.UART0.TX` select the instance, its bound interface, and then one interface
member. Power pin `VCC`, ordinary ground pin `GND`, and UART ground are all
connected explicitly because they are distinct physical pins.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 03-define-components-and-interfaces/301-mcu-uart-header.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 03-define-components-and-interfaces/301-mcu-uart-header.mc -o 03-define-components-and-interfaces/301-mcu-uart-header.html
```

## 302 I2C Sensor Component

`302-i2c-sensor-component.mc` defines an I2C controller and sensor. The same
`I2C` interface is bound with `Master` and `Slave` roles. Both expose `SCL` and
`SDA`, so matching members join the shared `I2C_SCL` and `I2C_SDA` nets. I2C
uses open-drain signaling, which is why each line also has a pull-up resistor to
`V3V3`. The file contains two component definitions before its single
`module main`; definitions alone do not create physical instances.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 03-define-components-and-interfaces/302-i2c-sensor-component.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 03-define-components-and-interfaces/302-i2c-sensor-component.mc -o 03-define-components-and-interfaces/302-i2c-sensor-component.html
```

## 303 SPI Flash Component

`303-spi-flash-component.mc` binds four pins to `SPI(Master)` and
`SPI(Slave)`. `CS`, `SCLK`, and `MOSI` are written from the MCU toward the flash;
`MISO` is written from the flash toward the MCU. The arrows make the intended
signal direction readable, while matching interface members determine the
physical endpoints. This example adds SPI member vocabulary, not a new binding
construct.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 03-define-components-and-interfaces/303-spi-flash-component.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 03-define-components-and-interfaces/303-spi-flash-component.mc -o 03-define-components-and-interfaces/303-spi-flash-component.html
```
