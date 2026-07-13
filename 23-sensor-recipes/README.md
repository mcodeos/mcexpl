# 23 Sensor Recipes

Run these commands from the `mc-examples` directory. Each command sets the
library root explicitly so `--lib mcode` loads the repository copy of the
standard library.

Set the library root for an interactive shell if you prefer shorter commands:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

Generated HTML is written next to each example source file.

## Examples

- `231-ntc-temperature-divider.mc`: Use an NTC thermistor in a divider.
- `232-photodiode-input.mc`: Connect a photodiode input stage.
- `233-adc-input-rc-filter.mc`: Add an RC filter before an ADC input.

Parse `231-ntc-temperature-divider.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 23-sensor-recipes/231-ntc-temperature-divider.mc
```

Generate HTML for `231-ntc-temperature-divider.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 23-sensor-recipes/231-ntc-temperature-divider.mc -o 23-sensor-recipes/231-ntc-temperature-divider.html
```
