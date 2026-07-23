# 03 Define Components And Interfaces

This chapter moves from library parts to small custom component definitions.
Read the examples in order: first define named pins, then describe pin direction
and ranges, and only then bind related pins to UART, I2C, and SPI interfaces.

## 031 Named Pins Component

`031-named-pins-component.mc` defines a tiny two-pin sensor and instantiates it
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
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/031-named-pins-component.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/031-named-pins-component.mc --lib mcode --viz -o 03-define-components-and-interfaces/031-named-pins-component.html
```

## 032 Pin Directions And Ranges

`032-pin-directions-and-ranges.mc` adds meaning to the named pins from `031`
without introducing interfaces yet:

```mc
pins = [
    in 1 = ENABLE
    out 2 = READY
    io [3:4] = GPIO[1:2]
    ps 5 = VCC
    ps 6 = GND
]
```

- `in` marks a signal received by the device, while `out` marks a signal driven
  by the device. These keywords document the component pin's electrical role;
  connections still use the same `->` syntax learned earlier.
- `io` marks a bidirectional signal, and `ps` marks a power-supply pin.
- `[3:4]` is an inclusive physical-pin range, so it covers pins 3 and 4.
- `GPIO[1:2]` expands to two indexed names, `GPIO1` and `GPIO2`. The physical
  range and name range contain the same number of entries, so they pair in
  order: pin 3 is `GPIO1`, and pin 4 is `GPIO2`.
- `U_IO.GPIO1` still uses the ordinary `instance.member` access introduced in
  `031`; no nested interface path is involved.

The four signal connections also make the directions readable in context:
`ENABLE` enters the device, `READY` leaves it, and the two GPIO pins may be used
in either direction.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/032-pin-directions-and-ranges.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/032-pin-directions-and-ranges.mc --lib mcode --viz -o 03-define-components-and-interfaces/032-pin-directions-and-ranges.html
```

## 033 UART Interface Binding

`033-uart-interface-binding.mc` groups two related pins into the tutorial's
first interface binding:

```mc
io [1:2] = UART0::UART.TTL(DCE)
```

- `[1:2]` assigns the two physical pins as one group. Pin ranges are no longer new
  here; the new part is the expression on the right.
- `UART0` is the local name chosen for this interface on the component.
- `::` binds that local name to the library interface type `UART.TTL`.
- `(DCE)` selects the DCE role of the interface. That role provides the named
  members `TX` and `RX` in the order required by the two-pin range.
- `U_MCU.UART0.TX` is a nested member path: select instance `U_MCU`, its bound
  interface `UART0`, and finally member `TX`.

The circuit connects MCU `TX` and `RX` plus a separate ground pin to a three-pin
debug header. `UART.TTL` describes the data signals; `GND` remains an ordinary
power pin because it is the shared electrical reference rather than a UART data
member.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/033-uart-interface-binding.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/033-uart-interface-binding.mc --lib mcode --viz -o 03-define-components-and-interfaces/033-uart-interface-binding.html
```

## 034 I2C Sensor Component

`034-i2c-sensor-component.mc` defines one I2C controller component and one I2C
sensor component. The same `I2C` interface is bound with different roles:
`I2C(Master)` for the MCU and `I2C(Slave)` for the sensor.

Both roles expose `SCL` and `SDA`, so matching members join the shared
`I2C_SCL` and `I2C_SDA` nets. I2C uses open-drain signaling, so each line also
has a pull-up resistor to `V3V3`. This example reuses interface binding and
adds the idea that two component definitions can appear before one runnable
`module main`.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/034-i2c-sensor-component.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/034-i2c-sensor-component.mc --lib mcode --viz -o 03-define-components-and-interfaces/034-i2c-sensor-component.html
```

## 035 SPI Flash Component

`035-spi-flash-component.mc` binds four pins to `SPI(Master)` and `SPI(Slave)`.
`CS`, `SCLK`, and `MOSI` are written from the MCU toward the flash; `MISO` is
written from the flash toward the MCU.

The syntax is the same interface-binding pattern from UART and I2C. The new
lesson is mostly interface vocabulary: SPI has four named members instead of
two or three, and direction-sensitive signal names make the connections easier
to review.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/035-spi-flash-component.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 03-define-components-and-interfaces/035-spi-flash-component.mc --lib mcode --viz -o 03-define-components-and-interfaces/035-spi-flash-component.html
```
