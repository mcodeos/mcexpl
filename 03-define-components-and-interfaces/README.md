# 03 Define Components And Interfaces

This chapter moves from library parts to small custom component definitions.
Read the examples in order: first define named pins without an interface, then
bind related pins to UART, I2C, and SPI interfaces.

## 301 Named Pins Component

`301-named-pins-component.mc` defines a tiny two-pin sensor and instantiates it
in `module main`. This is the first local component definition in the tutorial:

```mc
component TWO_PIN_SENSOR
{
    name = "Two-Pin Sensor"
    pins = [
        1 = VCC
        2 = GND
    ]
}
```

- `component TWO_PIN_SENSOR` creates a reusable component type. It does not
  create a physical part until `TWO_PIN_SENSOR U_SENSOR` appears in
  `module main`.
- `name = "Two-Pin Sensor"` assigns a display attribute. Quotation marks delimit
  a string value.
- `pins = [...]` declares the component's physical pins. Square brackets contain
  the pin entries.
- `1 = VCC` and `2 = GND` give readable member names to physical pins 1 and 2.
  The module can then connect `U_SENSOR.VCC` and `U_SENSOR.GND`.

The circuit is only a sensor powered from a 3.3 V source, but it separates the
component definition from the instance that uses it.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/301-named-pins-component.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/301-named-pins-component.mc --lib mcode --viz -o 03-define-components-and-interfaces/301-named-pins-component.html
```

## 302 UART Interface Binding

`302-uart-interface-binding.mc` adds the first interface binding. The MCU-like
component maps three physical pins to one UART interface:

```mc
pins = [
    io 1:3 = UART0::UART.TTL(DCE)
    ps 4 = VCC
    ps 5 = GND
]
```

- `io` marks signal pins and `ps` marks power-supply pins.
- `1:3` is the inclusive physical-pin range from 1 through 3.
- `UART0::UART.TTL(DCE)` binds those pins to the `UART.TTL` interface. `UART0`
  is the local interface name, `::` performs the binding, and `DCE` selects the
  role whose members are `TX`, `RX`, and `GND`.
- `U_MCU.UART0.TX` selects the instance, then the bound interface, then the
  interface member. This nested dot path is why the debug header can connect to
  UART members by name.

The circuit connects MCU `TX`, `RX`, and UART ground to a three-pin debug
header. Power pin `VCC`, ordinary component `GND`, and UART signal `GND` are
connected explicitly because they are distinct physical pins.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/302-uart-interface-binding.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/302-uart-interface-binding.mc --lib mcode --viz -o 03-define-components-and-interfaces/302-uart-interface-binding.html
```

## 303 I2C Sensor Component

`303-i2c-sensor-component.mc` defines one I2C controller component and one I2C
sensor component. The same `I2C` interface is bound with different roles:
`I2C(Master)` for the MCU and `I2C(Slave)` for the sensor.

Both roles expose `SCL` and `SDA`, so matching members join the shared
`I2C_SCL` and `I2C_SDA` nets. I2C uses open-drain signaling, so each line also
has a pull-up resistor to `V3V3`. This example reuses interface binding and
adds the idea that two component definitions can appear before one runnable
`module main`.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/303-i2c-sensor-component.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/303-i2c-sensor-component.mc --lib mcode --viz -o 03-define-components-and-interfaces/303-i2c-sensor-component.html
```

## 304 SPI Flash Component

`304-spi-flash-component.mc` binds four pins to `SPI(Master)` and `SPI(Slave)`.
`CS`, `SCLK`, and `MOSI` are written from the MCU toward the flash; `MISO` is
written from the flash toward the MCU.

The syntax is the same interface-binding pattern from UART and I2C. The new
lesson is mostly interface vocabulary: SPI has four named members instead of
two or three, and direction-sensitive signal names make the connections easier
to review.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/304-spi-flash-component.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/304-spi-flash-component.mc --lib mcode --viz -o 03-define-components-and-interfaces/304-spi-flash-component.html
```
