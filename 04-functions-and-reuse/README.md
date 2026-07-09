# 04 Functions And Reuse

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

- Local `func` definitions.
- Function parameters.
- Function calls from inside `module main`.
- Simple `return` values.

Reused from previous chapters:

- Component instances.
- Named nets.
- Branches from shared nodes.
- Member access.

Not covered yet:

- Conditional logic.
- `pins +=`.
- Cross-file `use`.

## 401 LED Indicator Function

`401-led-indicator-function.mc` wraps an LED indicator connection in a local
function. The module calls that function with a signal node and `GND`.

Parse `401-led-indicator-function.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 04-functions-and-reuse/401-led-indicator-function.mc
```

Generate HTML for `401-led-indicator-function.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 04-functions-and-reuse/401-led-indicator-function.mc -o 04-functions-and-reuse/401-led-indicator-function.html
```

## 402 Pull-Up Helper Function

`402-pullup-helper-function.mc` uses a function to build a pulled-up button
input. The function receives the input node, the rail, and the ground node.

Parse `402-pullup-helper-function.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 04-functions-and-reuse/402-pullup-helper-function.mc
```

Generate HTML for `402-pullup-helper-function.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 04-functions-and-reuse/402-pullup-helper-function.mc -o 04-functions-and-reuse/402-pullup-helper-function.html
```

## 403 Decoupling Helper Function

`403-decoupling-helper-function.mc` uses the same helper function twice, once
for `V5V` and once for `V3V3`.

Parse `403-decoupling-helper-function.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 04-functions-and-reuse/403-decoupling-helper-function.mc
```

Generate HTML for `403-decoupling-helper-function.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 04-functions-and-reuse/403-decoupling-helper-function.mc -o 04-functions-and-reuse/403-decoupling-helper-function.html
```
