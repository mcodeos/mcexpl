# 23 Sensor Recipes

These recipes show small sensor front-end circuits that can be read as real
topologies. They use the basic connection syntax from the tutorial path without
reteaching it in full.

Run commands from the `mc-examples` directory. Set the library root for an
interactive shell if you prefer shorter commands:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

Generated HTML is written next to each example source file.

## 231 NTC Temperature Divider

`231-ntc-temperature-divider.mc` is useful when a controller wants a simple
analog voltage that changes with the resistance of an NTC thermistor. It is a
conceptual divider, not a complete temperature-measurement design.

Topology:

```mc
V3V3 -> R_FIXED -> TEMP_SENSE
TEMP_SENSE -> RT_NTC -> GND
```

`R_FIXED` is the upper resistor and `RT_NTC` is the lower resistor. `TEMP_SENSE`
is the divider midpoint that an ADC input could measure in a larger design. The
chosen example values are 10 kOhm for both parts. If the thermistor is 10 kOhm
at the measurement temperature, the unloaded midpoint is about half of 3.3 V,
or 1.65 V.

For a typical NTC thermistor, resistance falls as temperature rises. With this
orientation, `TEMP_SENSE = V3V3 * RT_NTC / (R_FIXED + RT_NTC)`, so the output
voltage falls as temperature rises. The MCode library records only the nominal
thermistor resistance here; it does not provide a beta value, reference
temperature, ADC reference accuracy, or calibration curve, so this example does
not claim an exact temperature conversion.

The syntax follows the voltage-divider pattern from
`01-basic-circuits/011-voltage-divider.mc`. `RES.THERM(10000R)` is the actual
thermistor component defined by the current `mcode` library.

Parse `231-ntc-temperature-divider.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 23-sensor-recipes/231-ntc-temperature-divider.mc --lib mcode --pass1 --pass2
```

Generate HTML for `231-ntc-temperature-divider.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 23-sensor-recipes/231-ntc-temperature-divider.mc --lib mcode --viz -o 23-sensor-recipes/231-ntc-temperature-divider.html
```

## 232 Photodiode Input

`232-photodiode-input.mc` is useful as the smallest readable photodiode input
stage supported by the current library. It models a reverse-biased photodiode
and a load resistor that turns sensor current into a voltage.

Topology:

```mc
V3V3 -> D_LIGHT.CATHODE
D_LIGHT.ANODE -> LIGHT_SENSE
LIGHT_SENSE -> R_LOAD -> GND
```

The photodiode cathode is tied to `V3V3`, and the anode is the sensed node. This
reverse-bias orientation follows the `DIO.PHOTO` pin names in the library:
`ANODE` and `CATHODE`. `R_LOAD` connects `LIGHT_SENSE` to ground, so photocurrent
through the diode develops a voltage at `LIGHT_SENSE`. A larger light-generated
current would produce a larger load-resistor voltage until limited by the
supply and the real diode/resistor behavior.

The example values are illustrative: `DIO.PHOTO(0.5A/W, 1nA, 850nm)` records a
responsivity, dark current, and spectral range, while `R_LOAD` is 100 kOhm. For
scale, 1 uA through 100 kOhm would be 0.1 V, but the example does not model a
specific light level or guarantee linearity.

This is not a transimpedance amplifier. A resistor-only photodiode input is
simple, but its bandwidth, noise, voltage swing, and sensitivity depend strongly
on the diode capacitance, resistor value, ADC input loading, and ambient
conditions. Use it as a beginner topology, not as a production optical receiver.

The explicit member paths mirror the polarity-sensitive diode style introduced
in `01-basic-circuits/013-diode-rectifier.mc`. The typed parameters and units
are summarized in `90-language-reference/902-attributes-spec-typed-parameters.mc`.

Parse `232-photodiode-input.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 23-sensor-recipes/232-photodiode-input.mc --lib mcode --pass1 --pass2
```

Generate HTML for `232-photodiode-input.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 23-sensor-recipes/232-photodiode-input.mc --lib mcode --viz -o 23-sensor-recipes/232-photodiode-input.html
```

## 233 ADC Input RC Filter

`233-adc-input-rc-filter.mc` is useful when a sensor signal needs a small
low-pass filter before an ADC input. It shows the topology, not a universal ADC
front-end recommendation.

Topology:

```mc
SENSOR_RAW -> R_FILTER -> ADC_IN
ADC_IN -> C_FILTER -> GND
```

`SENSOR_RAW` is the unfiltered signal from an upstream sensor. `R_FILTER` is in
series with the signal, and `C_FILTER` shunts the filtered node to ground.
`ADC_IN` is the named node that an ADC input would sample in a larger design.
`SENSOR_RAW`, `ADC_IN`, and `GND` are supplied by the larger design; this focused
filter example does not define an ADC or an unrelated voltage source.

The chosen values are 1 kOhm and 10 nF. The nominal cutoff frequency is:

```text
fc = 1 / (2 * pi * R * C)
   = 1 / (2 * pi * 1000 * 10e-9)
   = about 15.9 kHz
```

Real ADC inputs can load this filter. Many ADCs also require a maximum source
impedance or enough acquisition time for the sampling capacitor to settle. Treat
these values as an illustration of the MCode topology, not as a board-wide
recommendation.

The syntax follows `01-basic-circuits/012-rc-low-pass-filter.mc` and the shared
node style from `02-circuits-with-branches/023-input-rc-esd.mc`. `CAP.CER` is
the ceramic capacitor subtype from the current `mcode` library.

Parse `233-adc-input-rc-filter.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 23-sensor-recipes/233-adc-input-rc-filter.mc --lib mcode --pass1 --pass2
```

Generate HTML for `233-adc-input-rc-filter.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 23-sensor-recipes/233-adc-input-rc-filter.mc --lib mcode --viz -o 23-sensor-recipes/233-adc-input-rc-filter.html
```
