# 05 Dynamic Pins And Conditions

This chapter defines component variants from constructor parameters. Conditions
can select descriptive attributes or append physical pins that exist only on a
larger variant.

## 501 LED Package Variant

`501-led-package-variant.mc` selects package metadata from a constructor
parameter:

```mc
component CONFIG_LED(package_style::STRING = "0603")
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

- `package_style::STRING` declares a string parameter. `= "0603"` gives this
  parameter a default value.
- `if (...)` evaluates a condition; `==` compares values rather than assigning
  one.
- `else if` provides another condition when the first one is false.
- Attribute assignments inside a selected block apply only for that variant.

`CONFIG_LED D_STATUS` omits the constructor argument, so the instantiated
example selects the default `0603` branch. The `1206` branch demonstrates the
alternative rule, but this file does not instantiate that alternative.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 05-dynamic-pins-and-conditions/501-led-package-variant.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 05-dynamic-pins-and-conditions/501-led-package-variant.mc -o 05-dynamic-pins-and-conditions/501-led-package-variant.html
```

## 502 GPIO Expander Pins

`502-gpio-expander-pins.mc` always declares eight GPIO signals plus power and
ground. When `partno` equals `"GPIO16"`, this block appends eight more pins:

```mc
pins += [
    io [11:18] = GPIO[8:15]
]
```

`+=` extends the existing `pins` list instead of replacing it. Square-bracketed
`[11:18]` is a physical-pin range, while `GPIO[8:15]` expands indexed signal
names from `GPIO8` through `GPIO15`. `U_SMALL` omits the argument and resolves
to 10 pins total; `U_LARGE` passes `"GPIO16"` and resolves to 18.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 05-dynamic-pins-and-conditions/502-gpio-expander-pins.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 05-dynamic-pins-and-conditions/502-gpio-expander-pins.mc -o 05-dynamic-pins-and-conditions/502-gpio-expander-pins.html
```

## 503 RS485 Termination Pins

`503-rs485-termination-pins.mc` applies the same conditional-pin pattern to
an RS485 endpoint. `U_NODE` exposes `A`, `B`, and `GND`. The
`"RS485_TERM120"` variant `U_END` also exposes `TERM0` and `TERM1`, providing
connection points for a termination network in a larger design. The example
does not contain or claim to enable a 120 ohm resistor by itself.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 05-dynamic-pins-and-conditions/503-rs485-termination-pins.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 05-dynamic-pins-and-conditions/503-rs485-termination-pins.mc -o 05-dynamic-pins-and-conditions/503-rs485-termination-pins.html
```
