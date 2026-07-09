# 05 Dynamic Pins And Conditions

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

- Default parameter values.
- `if` and `else if`.
- Conditional attributes.
- `pins +=` for variant-specific pins.

Reused from previous chapters:

- `component` definitions.
- `pins` blocks.
- Pin directions and pin ranges.
- Component instantiation with parameters.

Not covered yet:

- Cross-file `use`.
- Multi-file project organization.

## 501 LED Package Variant

`501-led-package-variant.mc` defines a configurable LED component. The selected
package changes attributes such as `package` and `recommended_current`.

Parse `501-led-package-variant.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 05-dynamic-pins-and-conditions/501-led-package-variant.mc
```

Generate HTML for `501-led-package-variant.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 05-dynamic-pins-and-conditions/501-led-package-variant.mc -o 05-dynamic-pins-and-conditions/501-led-package-variant.html
```

## 502 GPIO Expander Pins

`502-gpio-expander-pins.mc` defines an 8-bit GPIO expander variant and a 16-bit
variant. The larger variant adds a second GPIO pin range with `pins +=`.

Parse `502-gpio-expander-pins.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 05-dynamic-pins-and-conditions/502-gpio-expander-pins.mc
```

Generate HTML for `502-gpio-expander-pins.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 05-dynamic-pins-and-conditions/502-gpio-expander-pins.mc -o 05-dynamic-pins-and-conditions/502-gpio-expander-pins.html
```

## 503 RS485 Termination Option

`503-rs485-termination-option.mc` defines an RS485 endpoint with optional
termination metadata and optional termination pins.

Parse `503-rs485-termination-option.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 05-dynamic-pins-and-conditions/503-rs485-termination-option.mc
```

Generate HTML for `503-rs485-termination-option.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 05-dynamic-pins-and-conditions/503-rs485-termination-option.mc -o 05-dynamic-pins-and-conditions/503-rs485-termination-option.html
```
