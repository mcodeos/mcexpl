# 06 Multi-File Project

This chapter splits one I2C sensor node across several source files. Only
`601-main.mc` is runnable; the other files provide component definitions that
the entry file loads.

## 601 Multi-File Sensor Node

The entry file begins with three local imports:

```mc
use ./power.mc
use ./mcu.mc
use ./sensor.mc
```

`use` loads definitions from another MCode file. Each path starts with `./`, so
it is resolved relative to `601-main.mc`, not the shell's current directory.
The imported files have distinct jobs:

- `power.mc` defines `SENSOR_NODE_POWER` with `VIN`, `V3V3`, and `GND` pins.
- `mcu.mc` defines `SENSOR_NODE_MCU` with an I2C `Master` interface.
- `sensor.mc` defines `I2C_TEMP_SENSOR` with an I2C `Slave` interface.

Loading a file does not instantiate its components. `module main` creates one
instance of each imported type, feeds `VIN` into the power block, connects the
shared `V3V3` and `GND` nodes, and joins the MCU and sensor on `I2C_SCL` and
`I2C_SDA`. One pull-up resistor is added to each bus line, using the circuit
pattern from `303`.

This chapter demonstrates a multi-file project made from cross-file component
reuse. It does not introduce reusable module composition.

Run MCC only on the entry file; it loads the three dependencies automatically.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 06-multi-file-project/601-main.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 06-multi-file-project/601-main.mc -o 06-multi-file-project/601-main.html
```
