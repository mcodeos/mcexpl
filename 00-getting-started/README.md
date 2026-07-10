# 00 Getting Started

This chapter introduces the smallest useful MCode files. Read `001` through
`004` in order: each example adds one small circuit idea and explains new
syntax where it first appears.

Run all commands from the `mc-examples` directory. `MCC_SYSTEM_ROOT` points MCC
to the parent directory that contains the `mcode` library.

## 001 Power Net

`001-power-net.mc` creates a 5 V source and names its positive and ground nets.
It introduces the basic shape of a runnable MCode file:

```mc
module main
{
    DC.SRC PWR(5V, 500mA)
    PWR.1 -> V5V
}
```

- `//` starts a line comment.
- `module main` declares the entry module that MCC runs. `{` and `}` delimit
  its body; indentation is for readability.
- `DC.SRC` is the `SRC` component type in the `DC` namespace. `PWR` is this
  source instance's local name.
- `(5V, 500mA)` supplies positional arguments. `V` and `mA` are physical unit
  suffixes, and the comma separates arguments.
- `PWR.1` selects physical pin 1 of `PWR`. The dot selects a member of an
  instance.
- `->` connects its left and right operands. `V5V` and `GND` give readable names
  to the two electrical nodes.

Pin 1 of `DC.SRC` is positive and pin 2 is ground, so the two connection
statements create the expected supply rails.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 00-getting-started/001-power-net.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/001-power-net.mc -o 00-getting-started/001-power-net.html
```

## 002 Resistor LED

`002-resistor-led.mc` places a resistor and LED in series across the source.
`RES R_LED(330R, 50V)` uses ohms (`R`) and a voltage rating; `LED
D_STATUS(2V, 20mA)` supplies the LED forward voltage and current. A connection
may contain several operands:

```mc
PWR.1 -> R_LED -> D_STATUS -> PWR.2
```

For ordinary two-pin components, a bare instance in a chain enters one pin and
leaves the other. The current path is therefore source positive, resistor, LED,
then source ground. The library pin order also places the LED anode toward the
resistor and its cathode toward ground.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 00-getting-started/002-resistor-led.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/002-resistor-led.mc -o 00-getting-started/002-resistor-led.html
```

## 003 Decoupling Capacitor

`003-decoupling-capacitor.mc` places a 100 nF capacitor directly across a
3.3 V source. `CAP` is a two-pin capacitor and `nF` means nanofarads. Unlike the
series LED path, this chain describes a shunt component from the supply rail to
ground.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 00-getting-started/003-decoupling-capacitor.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/003-decoupling-capacitor.mc -o 00-getting-started/003-decoupling-capacitor.html
```

## 004 Button Pull-Up

`004-button-pullup.mc` models a normally-high button input. The resistor pulls
`BUTTON_IN` toward `V3V3`; pressing the normally open switch connects that node
to `GND`.

```mc
V3V3 -> R_PULLUP -> BUTTON_IN
BUTTON_IN -> SW_USER.COM
SW_USER.NO -> GND
```

This is the first named intermediate signal. Repeating `BUTTON_IN` joins the
resistor and switch statements at one electrical node. `SW_USER.COM` and
`SW_USER.NO` use descriptive pin members: `COM` is the switch common pin and
`NO` is the normally open contact.

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 00-getting-started/004-button-pullup.mc
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/004-button-pullup.mc -o 00-getting-started/004-button-pullup.html
```
