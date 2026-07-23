# 90 Language Reference

This directory is a compact syntax reference by runnable example. Use the
tutorial path first when learning MCode in order; use this directory when you
want to look up one syntax form quickly.

Run commands from the `mc-examples` directory:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

## Reference Examples

### 901 Component Definition

`901-component-definition.mc` covers `component`, simple attributes, `pins`, and
named physical pins. Tutorial first use: `03-define-components-and-interfaces`.

Syntax synopsis:

```mc
component TYPE_NAME
{
    name = "Display Name"
    pins = [
        1 = PIN_NAME
    ]
}
```

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 90-language-reference/901-component-definition.mc --lib mcode --pass1 --pass2
```

### 902 Attributes, Spec, And Typed Parameters

`902-attributes-spec-typed-parameters.mc` covers typed constructor parameters
and `spec = [...]` attributes. Tutorial first use: `05-dynamic-pins-and-conditions`
for typed string parameters; this reference also shows unit-typed parameters.

Syntax synopsis:

```mc
component TYPE_NAME(value::UV.OHM)
{
    spec = [
        resistance = value
    ]
}
```

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 90-language-reference/902-attributes-spec-typed-parameters.mc --lib mcode --pass1 --pass2
```

### 903 Pins, Ranges, And Indexed Names

`903-pins-ranges-indexed-names.mc` covers pin directions, physical pin ranges,
and indexed pin names. Tutorial first use: `03-define-components-and-interfaces`
for directions and ranges; `05-dynamic-pins-and-conditions` for indexed pin
expansion.

Syntax synopsis:

```mc
pins = [
    io [1:4] = GPIO[0:3]
    ps 5 = VCC
]
```

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 90-language-reference/903-pins-ranges-indexed-names.mc --lib mcode --pass1 --pass2
```

### 904 Module Ports

`904-module-ports.mc` covers module parameters with direction markers, module
instances, and explicit module-port connections. Tutorial first use:
`06-multi-file-project/061-reusable-module.mc`.

Syntax synopsis:

```mc
module BLOCK(in signal, ps ground)
{
}
module main
{
    BLOCK INSTANCE
    INPUT -> INSTANCE.signal
    INSTANCE.ground -> GND
}
```

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 90-language-reference/904-module-ports.mc --lib mcode --pass1 --pass2 --top main
```

### 905 Interface Binding And Roles

`905-interface-binding-roles.mc` covers binding a physical pin range to a named
interface and role. Tutorial first use: `03-define-components-and-interfaces`.

Syntax synopsis:

```mc
pins = [
    io 1:2 = UART0::UART.TTL(DCE)
]
```

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 90-language-reference/905-interface-binding-roles.mc --lib mcode --pass1 --pass2
```

### 906 Functions And Method Calls

`906-functions-method-calls.mc` covers `func`, parameters, `this`, `return`, and
method calls. Tutorial first use: `04-functions-and-reuse`.

Syntax synopsis:

```mc
func ConnectAnode(signal)
{
    signal -> ANODE
    return this
}
func ConnectCathode(ground)
{
    CATHODE -> ground
}
INSTANCE.ConnectAnode(A).ConnectCathode(GND)
```

Bare component pin names select pins on the current instance. `return this`
returns that instance, so `.ConnectCathode(...)` runs on the value returned by
`ConnectAnode(...)`. Tutorial example 042 uses the same method-chain pattern.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 90-language-reference/906-functions-method-calls.mc --lib mcode --pass1 --pass2
```

### 907 Conditions And Dynamic Pins

`907-conditions-and-dynamic-pins.mc` covers default parameters, `if`, `else`,
conditional attributes, and `pins +=`. Tutorial first use:
`05-dynamic-pins-and-conditions`.

Syntax synopsis:

```mc
component TYPE_NAME(partno::STRING = "BASE")
{
    if (partno == "WIDE")
    {
        pins += [
            io [4:5] = IO[2:3]
        ]
    }

    if (partno == "WIDE")
    {
        package = "5-pin"
    }
    else
    {
        package = "3-pin"
    }
}
```

The runnable example connects `U_WIDE.IO2`, proving that a name appended by
`pins +=` can be accessed on the selected variant. `U_BASE` has no `IO2` member.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 90-language-reference/907-conditions-and-dynamic-pins.mc --lib mcode --pass1 --pass2
```

### 908 Inline Construction And Library Methods

`908-inline-construction-library-method.mc` covers `NAME::TYPE(args)` inline
construction and method calls provided by the `mcode` library. Tutorial first
use: `04-functions-and-reuse`.

Syntax synopsis:

```mc
R_PULLUP::RES(10000R, 50V).Pullup(BUTTON_IN, V3V3)
```

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 90-language-reference/908-inline-construction-library-method.mc --lib mcode --pass1 --pass2
```

### 909 Cross-File Use

`909-cross-file-use/` covers local `use` with a runnable entry file. Tutorial
first use: `06-multi-file-project`.

Syntax synopsis:

```mc
use ./led_block.mc
```

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 90-language-reference/909-cross-file-use/main.mc --lib mcode --pass1 --pass2
```
