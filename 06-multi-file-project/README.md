# 06 Modules And A Multi-File Project

This chapter first turns a small circuit into a reusable module, then moves a
module and component definitions into separate source files. Read `061` before
`062`: module boundaries come before file boundaries.

## 061 Reusable Module

`061-reusable-module.mc` defines a reusable LED circuit instead of a single
physical part:

```mc
module LED_INDICATOR(in signal, ps ground)
{
    RES R_LIMIT(330R, 50V)
    LED D_STATUS(2.0V, 5mA)

    signal -> R_LIMIT -> D_STATUS.ANODE
    D_STATUS.CATHODE -> ground
}
```

- `module LED_INDICATOR(...)` names a reusable circuit block.
- `in signal` declares an input port and `ps ground` declares a power-supply
  port. These are connection points on the module, not physical component pins.
- The resistor, LED, and their internal connections belong to each module
  instance.

`module main` creates `STATUS_GREEN` and `STATUS_RED` using the same module type.
A module instance uses the same `TYPE INSTANCE` declaration shape as a component
instance. Member access such as `STATUS_GREEN.signal` selects one module port:

```mc
LED_INDICATOR STATUS_GREEN
GPIO_GREEN -> STATUS_GREEN.signal
STATUS_GREEN.ground -> GND
```

Each instance owns its own `R_LIMIT` and `D_STATUS`, while both instances connect
to the surrounding design through their ports.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 06-multi-file-project/061-reusable-module.mc --lib mcode --pass1 --pass2 --top main
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 06-multi-file-project/061-reusable-module.mc --lib mcode --viz --top main -o 06-multi-file-project/061-reusable-module.html
```

## 062 Multi-File Sensor Node

The entry file begins with three local imports:

```mc
use ./power.mc
use ./mcu.mc
use ./sensor.mc
```

`use` loads definitions from another MCode file. Each path starts with `./`, so
it is resolved relative to `062-main.mc`, not the shell's current directory.
The imported files have distinct jobs:

- `power.mc` defines a `SENSOR_NODE_POWER` module with `VIN`, `V3V3`, and `GND`
  ports. It contains an LDO and its input and output capacitors.
- `mcu.mc` defines `SENSOR_NODE_MCU` with an I2C `Master` interface.
- `sensor.mc` defines `I2C_TEMP_SENSOR` with an I2C `Slave` interface.

Loading a file does not instantiate its definitions. `module main` creates one
power-module instance and one instance of each imported component. The explicit
paths `U_POWER.VIN`, `U_POWER.V3V3`, and `U_POWER.GND` connect the parent design
to the imported module ports. The MCU and sensor then share `V3V3`, `GND`,
`I2C_SCL`, and `I2C_SDA`; one pull-up resistor is added to each bus line using
the circuit pattern from
`03-define-components-and-interfaces/034-i2c-sensor-component.mc`.

Run MCC only on the entry file; it loads the three dependencies automatically.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 06-multi-file-project/062-main.mc --lib mcode --pass1 --pass2 --top main
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 06-multi-file-project/062-main.mc --lib mcode --viz --top main -o 06-multi-file-project/062-main.html
```
