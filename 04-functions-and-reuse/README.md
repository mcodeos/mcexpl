# 04 Functions And Reuse

This chapter adds connection methods to component definitions. A method keeps a
small wiring pattern beside the component that owns it, and callers provide the
external nodes that should be connected.

## 401 LED Indicator Function

`401-led-indicator-function.mc` defines a two-pin `STATUS_LED` and gives it a
current-limited `Indicator` method:

```mc
func Indicator(signal, resistor, ground)
{
    signal -> resistor -> this -> ground
}
```

- `func` declares a function inside the component.
- `signal`, `resistor`, and `ground` are parameters. Their values are supplied
  by the call in `module main`.
- `this` means the current `STATUS_LED` instance. In this two-pin component, the
  connection enters one terminal and leaves the other.
- `D_STATUS.Indicator(GPIO_STATUS, R_LIMIT, GND)` calls the method on the
  `D_STATUS` instance. The dot selects the method, and the call parentheses pass
  the signal node, a real resistor instance, and ground.

The resolved circuit is `GPIO_STATUS`, `R_LIMIT`, `D_STATUS`, then `GND`. Passing
the resistor as a parameter keeps the first method call small without teaching an
unsafe bare-LED pattern. This example intentionally avoids return values, typed
parameters, and inline construction.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/401-led-indicator-function.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/401-led-indicator-function.mc --lib mcode --viz -o 04-functions-and-reuse/401-led-indicator-function.html
```

## 402 Pull-Up Helper Function

`402-pullup-helper-function.mc` defines `PULLUP_RESISTOR.Pullup(input, source)`.
Its connection runs from the input node through `this` resistor to the source
rail:

```mc
func Pullup(input, source)
{
    input -> this -> source
    return input
}
```

`return input` exposes the named input parameter as the method's result. The
example does not chain that result into another expression; it keeps the next
statement explicit:

```mc
R_PULLUP.Pullup(BUTTON_IN, V3V3)
BUTTON_IN -> SW_USER.COM
```

Repeating `BUTTON_IN` makes the shared input node visible: the pull-up resistor
and the switch common pin meet at the same electrical node.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/402-pullup-helper-function.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/402-pullup-helper-function.mc --lib mcode --viz -o 04-functions-and-reuse/402-pullup-helper-function.html
```

## 403 Inline Construction Function

`403-inline-construction-function.mc` keeps the same pull-up method but creates
the helper component inside the call:

```mc
R_PULLUP::PULLUP_RESISTOR().Pullup(BUTTON_IN, V3V3)
```

`R_PULLUP::PULLUP_RESISTOR()` means "make an instance named `R_PULLUP` of type
`PULLUP_RESISTOR` here." The `::` in this expression separates an instance name
from a component type. That is different from the interface binding use of `::`
in chapter 03, where `UART0::UART.TTL(DCE)` bound pins to an interface.

The circuit is still the same normally-high button input from `402`; only the
instance construction style changes.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/403-inline-construction-function.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/403-inline-construction-function.mc --lib mcode --viz -o 04-functions-and-reuse/403-inline-construction-function.html
```

## 404 Decoupling Library Method

`404-decoupling-library-method.mc` reuses the `Cap` method already defined by
the `mcode` library's `CAP` component. These two calls create distinct ceramic
capacitors while applying the same rail-to-ground connection pattern:

```mc
C_5V::CAP.CER(100nF, 10V).Cap(V5V, GND)
C_3V3::CAP.CER(100nF, 10V).Cap(V3V3, GND)
```

`CAP.CER(100nF, 10V)` is the ceramic-capacitor library type with capacitance and
voltage arguments. `C_5V` belongs only to the 5 V rail and `C_3V3` belongs only
to the 3.3 V rail; both share `GND`. This demonstrates that user code calls
library methods with the same dot-call syntax as locally defined methods.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/404-decoupling-library-method.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/404-decoupling-library-method.mc --lib mcode --viz -o 04-functions-and-reuse/404-decoupling-library-method.html
```
