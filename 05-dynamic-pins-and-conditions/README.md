# 05 Dynamic Pins And Conditions

This chapter defines component variants from constructor parameters. Conditions
can select descriptive attributes or append physical pins that exist only on a
larger variant.

## 051 LED Package Variant

`051-led-package-variant.mc` selects package metadata from a constructor
parameter:

```mc
component CONFIG_LED(package_style::STRING)
{
    if (package_style == "0603")
    {
        package = "0603"
    }
    else if (package_style == "1206")
    {
        package = "1206"
    }
}
```

- `package_style::STRING` declares a required string parameter. Each instance
  passes the package style that its conditions should evaluate.
- `if (...)` evaluates a condition; `==` compares values rather than assigning
  one.
- `else if` provides another condition when the first one is false.
- Attribute assignments inside a selected block apply only for that variant.

`D_SMALL` passes `"0603"`, while `D_LARGE` passes `"1206"`, so the two instances
select different branches. Both LEDs are connected
from `V3V3` through their own current-limiting resistors to `GND`, so they are
complete comparable instances rather than floating type demonstrations. Their
electrical topology is the same; the selected package metadata is different.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 05-dynamic-pins-and-conditions/051-led-package-variant.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 05-dynamic-pins-and-conditions/051-led-package-variant.mc --lib mcode --viz -o 05-dynamic-pins-and-conditions/051-led-package-variant.html
```

## 052 GPIO Expander Pins

`052-gpio-expander-pins.mc` always declares eight GPIO signals plus power and
ground. When `partno` equals `"GPIO16"`, this block appends eight more pins:

```mc
pins += [
    io [11:18] = GPIO[8:15]
]
```

`+=` extends the existing `pins` list instead of replacing it. Square-bracketed
`[11:18]` is a physical-pin range, while `GPIO[8:15]` expands indexed signal
names from `GPIO8` through `GPIO15`. Here, `partno::STRING = "GPIO8"` introduces
a default parameter value. `U_SMALL` omits the argument and resolves
to 10 pins total; `U_LARGE` passes `"GPIO16"` and resolves to 18. Both variants
have `VCC`, `GND`, and `GPIO0` connected, so the shared base pins can be compared
while the larger instance visibly exposes eight additional terminals.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 05-dynamic-pins-and-conditions/052-gpio-expander-pins.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 05-dynamic-pins-and-conditions/052-gpio-expander-pins.mc --lib mcode --viz -o 05-dynamic-pins-and-conditions/052-gpio-expander-pins.html
```

## 053 RS485 Termination Pins

`053-rs485-termination-pins.mc` applies the same conditional-pin pattern to
an RS485 endpoint. `U_NODE` exposes `A`, `B`, and `GND`. The
`"RS485_TERM120"` variant `U_END` also exposes `TERM0` and `TERM1`. Both variants
connect to `BUS_A`, `BUS_B`, and `GND`, while `R_TERM` places the actual 120 ohm
termination between the two bus nodes at `U_END`. This separates two ideas: the
condition changes the endpoint's available terminals, and the resistor creates
the electrical termination.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 05-dynamic-pins-and-conditions/053-rs485-termination-pins.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 05-dynamic-pins-and-conditions/053-rs485-termination-pins.mc --lib mcode --viz -o 05-dynamic-pins-and-conditions/053-rs485-termination-pins.html
```
