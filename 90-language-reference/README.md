# 90 Language Reference

This directory contains focused syntax examples. These examples are not the
main beginner tutorial path; they are a quick reference for language features
that appear across many MCode circuits.

Run commands from the `mc-examples` directory:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

## Examples

- `901-component-definition.mc`: Define a custom component.
- `902-module-composition.mc`: Compose reusable modules.
- `903-interface-binding.mc`: Bind pins to an interface.
- `904-arrays-and-ranges.mc`: Use arrays and ranges for repeated items.
- `905-cross-file-use/`: Split an example across multiple files with `use`.

## Validation

Parse one focused example:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 90-language-reference/901-component-definition.mc
```

Parse the cross-file example:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 90-language-reference/905-cross-file-use/main.mc
```
