# 04 Functions And Reuse

This chapter adds connection methods to component definitions. A method keeps a
small wiring pattern beside the component that owns it, and callers provide the
external nodes that should be connected.

## 041 LED Indicator Function

`041-led-indicator-function.mc` defines a two-pin `STATUS_LED` and gives it a
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
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/041-led-indicator-function.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/041-led-indicator-function.mc --lib mcode --viz -o 04-functions-and-reuse/041-led-indicator-function.html
```

## 042 Pull-Up Helper Function

`042-pullup-helper-function.mc` models a dual pull-up resistor network. Each
method configures one resistor channel and connects one normally-high button
input. Inside a component method, a bare pin name such as `INPUT_A` refers to
that pin on the current component instance:

```mc
func PullupA(input, source, switch_pin)
{
    input -> INPUT_A
    SOURCE_A -> source
    input -> switch_pin
    return this
}
```

- `input -> INPUT_A` connects the caller's input node to the first resistor
  channel. `SOURCE_A -> source` connects the other end to the supply rail.
- Reusing `input` in `input -> switch_pin` creates the branch to the button, so
  the resistor pin and switch common pin share one input node.
- `return this` returns the current `DUAL_PULLUP_RESISTOR` instance. Unlike an
  ordinary connection node, that returned instance still has component methods.

The call consumes that return value immediately:

```mc
RN_PULLUPS.PullupA(BUTTON_A, V3V3, SW_A.COM).PullupB(BUTTON_B, V3V3, SW_B.COM)
```

Read the expression from left to right. `PullupA(...)` runs on `RN_PULLUPS` and
returns that same instance; the following `.PullupB(...)` is then called on the
returned instance. `PullupB` omits `return` because no call follows it. The
resulting circuit has two independent normally-high button inputs, while both
pull-up channels share `V3V3`.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/042-pullup-helper-function.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/042-pullup-helper-function.mc --lib mcode --viz -o 04-functions-and-reuse/042-pullup-helper-function.html
```

## 043 Inline Construction Function

`043-inline-construction-function.mc` uses a single-channel `Pullup` method and
creates its helper component inside the call:

```mc
R_PULLUP::PULLUP_RESISTOR().Pullup(BUTTON_IN, V3V3)
```

`R_PULLUP::PULLUP_RESISTOR()` means "make an instance named `R_PULLUP` of type
`PULLUP_RESISTOR` here." The `::` in this expression separates an instance name
from a component type. That is different from the interface binding use of `::`
in chapter 03, where `UART0::UART.TTL(DCE)` bound pins to an interface.

This example returns to one pull-up resistor and one button so the inline
construction syntax remains the only new idea. Its method omits `return`
because the call result is not used.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/043-inline-construction-function.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/043-inline-construction-function.mc --lib mcode --viz -o 04-functions-and-reuse/043-inline-construction-function.html
```

## 044 Decoupling Library Method

`044-decoupling-library-method.mc` reuses the `Cap` method already defined by
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
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/044-decoupling-library-method.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 04-functions-and-reuse/044-decoupling-library-method.mc --lib mcode --viz -o 04-functions-and-reuse/044-decoupling-library-method.html
```
