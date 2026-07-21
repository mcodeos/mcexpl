# 01 Basic Circuits

This chapter applies the syntax from Getting Started to three familiar analog
circuits. The emphasis is on reading the topology from named nodes and choosing
explicit pins when component orientation matters.

## 101 Voltage Divider

`101-voltage-divider.mc` connects two equal 10 kOhm resistors between `V5V` and
`GND`. `VOUT` is their shared midpoint, so its unloaded voltage is about 2.5 V.
No new language construct is needed: the example shows how repeated named nodes
make a circuit's important measurement point visible.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 01-basic-circuits/101-voltage-divider.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 01-basic-circuits/101-voltage-divider.mc --lib mcode --viz -o 01-basic-circuits/101-voltage-divider.html
```

## 102 RC Low-Pass Filter

`102-rc-low-pass-filter.mc` treats `VIN` and `GND` as connection points supplied
by a larger design. `R_FILTER` lies between `VIN` and `VOUT`, while `C_FILTER`
shunts `VOUT` to ground. With 1 kOhm and 100 nF, the cutoff frequency is about
1.6 kHz. A named net does not require a local source or pin declaration before
it is used.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 01-basic-circuits/102-rc-low-pass-filter.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 01-basic-circuits/102-rc-low-pass-filter.mc --lib mcode --viz -o 01-basic-circuits/102-rc-low-pass-filter.html
```

## 103 Diode Rectifier

`103-diode-rectifier.mc` explicitly selects diode pins because reversing a
diode changes the circuit. `VIN` connects to `D_RECT.ANODE`, and
`D_RECT.CATHODE` feeds `VRECT`; `R_LOAD` then provides a path to `GND`.
Descriptive member access is the same dot syntax used for switch pins, but here
it makes semiconductor polarity unambiguous.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 01-basic-circuits/103-diode-rectifier.mc --lib mcode --pass1 --pass2
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 01-basic-circuits/103-diode-rectifier.mc --lib mcode --viz -o 01-basic-circuits/103-diode-rectifier.html
```
