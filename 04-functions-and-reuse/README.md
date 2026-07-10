# 04 Functions And Reuse

This chapter adds connection methods to component definitions. A method keeps a
small wiring pattern beside the component that owns it, and callers provide the
external nodes that should be connected.

## 401 LED Indicator Function

`401-led-indicator-function.mc` defines a two-pin `STATUS_LED` and gives it an
`Indicator` method:

```mc
func Indicator(signal, ground)
{
    signal -> RES(330R, 50V) -> this -> ground
    return this
}
```

- `func` declares a function inside the component. `signal` and `ground` are
  parameters whose values are supplied by a call.
- `RES(330R, 50V)` creates an inline resistor for this connection instead of
  declaring it separately in `module main`.
- `this` means the current `STATUS_LED` instance. As with other bare two-pin
  components in a connection chain, the path traverses its two terminals.
- `return this` exposes the owning component as the method's returned
  connection point.

The component parameters `fv::UV.VOLT` and `fi::UV.AMP` are typed values;
`::` associates each parameter name with its required unit type. The `spec =
[...]` attribute records those values. The module constructs the component and
then calls its method:

```mc
STATUS_LED D_STATUS(2.0V, 5mA)
D_STATUS.Indicator(GPIO_STATUS, GND)
```

The dot selects `Indicator` from `D_STATUS`, and the call parentheses pass the
external signal and ground nodes. The resolved circuit is `GPIO_STATUS`,
resistor, status LED, then `GND`.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 04-functions-and-reuse/401-led-indicator-function.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 04-functions-and-reuse/401-led-indicator-function.mc -o 04-functions-and-reuse/401-led-indicator-function.html
```

## 402 Pull-Up Helper Function

`402-pullup-helper-function.mc` defines `PULLUP_RESISTOR.Pullup(input, source)`.
Its connection runs from the input node through `this` resistor to the source
rail, and `return input` declares the input parameter as the returned connection
point. This differs from `return this`, which returned the owning component.

The call uses `R_PULLUP::PULLUP_RESISTOR(...)` to name and construct a component
inside the method-call expression. Here `::` separates the requested instance
name from its component type. The call creates `R_PULLUP` between `BUTTON_IN`
and `V3V3`. The next statement repeats `BUTTON_IN` to connect the same node to
`SW_USER.COM`; the normally open contact goes to ground. Keeping that
continuation explicit also makes the resolved network easy to inspect in Pass 2.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 04-functions-and-reuse/402-pullup-helper-function.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 04-functions-and-reuse/402-pullup-helper-function.mc -o 04-functions-and-reuse/402-pullup-helper-function.html
```

## 403 Decoupling Helper Function

`403-decoupling-helper-function.mc` reuses the `Cap` method already defined by
the `mcode` library's `CAP` component. These two calls create distinct ceramic
capacitors while applying the same rail-to-ground connection pattern:

```mc
C_5V::CAP.CER(100nF, 10V).Cap(V5V, GND)
C_3V3::CAP.CER(100nF, 10V).Cap(V3V3, GND)
```

`C_5V` belongs only to the 5 V rail and `C_3V3` belongs only to the 3.3 V rail;
both share `GND`. This demonstrates that a method can be called repeatedly on
separate instances and that user code calls library methods with the same syntax
as locally defined methods.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 04-functions-and-reuse/403-decoupling-helper-function.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 04-functions-and-reuse/403-decoupling-helper-function.mc -o 04-functions-and-reuse/403-decoupling-helper-function.html
```
