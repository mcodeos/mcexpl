# 02 Circuits With Branches

This chapter builds protection and power circuits in which several paths share
one node. The first three examples use repeated node names; the last introduces
compact branch-group syntax.

## 201 Zener Clamp Branch

`201-zener-clamp.mc` places a series resistor between `VIN` and `VCLAMP`, then
adds a Zener path from `VCLAMP` to `GND`. `DIO.ZEN` is the Zener type in the
`DIO` namespace. Its arguments add tolerance (`%`) and power (`W`) units. The
cathode faces the protected node and the anode faces ground, so the diode is
reverse-biased during normal operation.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 02-circuits-with-branches/201-zener-clamp.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 02-circuits-with-branches/201-zener-clamp.mc -o 02-circuits-with-branches/201-zener-clamp.html
```

## 202 TVS Input Protection Branch

`202-tvs-input-protection.mc` uses the same branch pattern with a `DIO.TVS`
transient suppressor. A small resistor separates `INPUT_RAW` from
`INPUT_PROTECTED`; the reverse-biased TVS provides a path toward ground during
a voltage spike. Its voltage and wattage arguments describe the protection
device rather than adding new connection syntax.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 02-circuits-with-branches/202-tvs-input-protection.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 02-circuits-with-branches/202-tvs-input-protection.mc -o 02-circuits-with-branches/202-tvs-input-protection.html
```

## 203 Input RC ESD

`203-input-rc-esd.mc` joins four things at `ADC_IN`: the series resistor output,
the continuing ADC signal, a filter capacitor, and an ESD protection input.
`CAP.CER` selects the ceramic-capacitor subtype, and quoted values such as
`"X7R"` are string arguments. `D_ESD.INPUT` connects to the protected signal
while `D_ESD.GND` connects to ground. Repeating `ADC_IN` and `GND` across the
statements creates shared nodes, not separate nets with similar labels.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 02-circuits-with-branches/203-input-rc-esd.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 02-circuits-with-branches/203-input-rc-esd.mc -o 02-circuits-with-branches/203-input-rc-esd.html
```

## 204 Simple Power Branch

`204-simple-power-branch.mc` feeds a bypass capacitor and an LED indicator from
`V3V3`. It introduces an explicit branch group:

```mc
V3V3 -> (
    C_BYPASS -> GND,
    R_LED -> D_STATUS.ANODE
)
D_STATUS.CATHODE -> GND
```

The parentheses group paths that start at the same incoming node. The comma
separates parallel branches; it does not connect the capacitor branch to the
LED branch in sequence. The LED branch then finishes with an explicit cathode
connection so the diode polarity stays readable.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 02-circuits-with-branches/204-simple-power-branch.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 02-circuits-with-branches/204-simple-power-branch.mc -o 02-circuits-with-branches/204-simple-power-branch.html
```
