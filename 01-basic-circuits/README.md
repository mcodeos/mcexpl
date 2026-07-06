# 01 Basic Circuits

Run these commands from the `mc-examples` directory. Each command sets the
library root explicitly so `--lib mcode` loads the repository copy of the
standard library.

Set the library root for an interactive shell if you prefer shorter commands:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

Generated HTML is written next to each example source file.

## 101 Voltage Divider

`101-voltage-divider.mc` describes a basic two-resistor voltage divider.

The circuit uses a 5 V source and two equal 10 kOhm resistors. The source pins
are first connected to named `V5V` and `GND` nets. `R_TOP` connects from `V5V`
to the output node, and `R_BOTTOM` connects from the output node to `GND`.
Because the two resistor values are equal, the unloaded `VOUT` node represents
about half of the input voltage, or about 2.5 V.

This is a common beginner circuit for creating a scaled analog voltage for a
high-impedance input such as an ADC pin. `VOUT` is a named node between the two
resistors, which makes the divided voltage easy to identify in parser output and
generated schematics.

Parse `101-voltage-divider.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 01-basic-circuits/101-voltage-divider.mc
```

Generate HTML for `101-voltage-divider.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 01-basic-circuits/101-voltage-divider.mc -o 01-basic-circuits/101-voltage-divider.html
```

## 102 RC Low-Pass Filter

`102-rc-low-pass-filter.mc` describes a first-order RC low-pass filter.

The circuit leaves `VIN` as an external signal node. `R_FILTER` is placed in
series between `VIN` and `VOUT`, and `C_FILTER` connects from `VOUT` to `GND`.
This keeps the example focused on the filter network instead of modeling a
specific signal source.

At steady DC, `VOUT` follows `VIN` because the capacitor is open-circuit for DC.
For changing signals, the capacitor gives high-frequency content a path to
ground, so the output keeps slower signal changes and attenuates faster noise.
With 1 kOhm and 100 nF, the cutoff frequency is about 1.6 kHz.

Parse `102-rc-low-pass-filter.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 01-basic-circuits/102-rc-low-pass-filter.mc
```

Generate HTML for `102-rc-low-pass-filter.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 01-basic-circuits/102-rc-low-pass-filter.mc -o 01-basic-circuits/102-rc-low-pass-filter.html
```

## 103 Diode Rectifier

`103-diode-rectifier.mc` describes a simple half-wave rectifier path.

`D_RECT` is oriented from `VIN` to `VRECT`: its anode is connected to `VIN`,
and its cathode is connected to the rectified output node. `R_LOAD` connects
from `VRECT` to `GND`, giving the rectified node a load path.

Parse `103-diode-rectifier.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 01-basic-circuits/103-diode-rectifier.mc
```

Generate HTML for `103-diode-rectifier.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 01-basic-circuits/103-diode-rectifier.mc -o 01-basic-circuits/103-diode-rectifier.html
```

## 104 Zener Clamp

`104-zener-clamp.mc` describes a resistor-fed Zener clamp.

`R_SERIES` limits current from `VIN` into `VCLAMP`. `Z_CLAMP` is connected in
reverse bias, with its cathode on `VCLAMP` and its anode on `GND`, so the node
is clamped near the Zener voltage when it rises too high.

Parse `104-zener-clamp.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 01-basic-circuits/104-zener-clamp.mc
```

Generate HTML for `104-zener-clamp.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 01-basic-circuits/104-zener-clamp.mc -o 01-basic-circuits/104-zener-clamp.html
```

## 105 TVS Input Protection

`105-tvs-input-protection.mc` describes a protected external input.

`R_INPUT` is a small series resistor between `INPUT_EXT` and
`INPUT_PROTECTED`. `D_PROTECT` connects from the protected input node to
`GND`, with its cathode on the signal and its anode on ground, modeling a
unidirectional TVS clamp for positive transients.

Parse `105-tvs-input-protection.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 01-basic-circuits/105-tvs-input-protection.mc
```

Generate HTML for `105-tvs-input-protection.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 01-basic-circuits/105-tvs-input-protection.mc -o 01-basic-circuits/105-tvs-input-protection.html
```
