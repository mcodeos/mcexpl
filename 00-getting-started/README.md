# 00 Getting Started

Run these commands from the `mc-examples` directory.

Set the library root first:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

Parse `001-power-net.mc`:

```bash
../mcc/target/debug/mcc parse --lib mcode 00-getting-started/001-power-net.mc
```

Generate HTML for `001-power-net.mc`:

```bash
../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/001-power-net.mc -o 00-getting-started/001-power-net.html
```

Parse `002-resistor-led.mc`:

```bash
../mcc/target/debug/mcc parse --lib mcode 00-getting-started/002-resistor-led.mc
```

Generate HTML for `002-resistor-led.mc`:

```bash
../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/002-resistor-led.mc -o 00-getting-started/002-resistor-led.html
```
