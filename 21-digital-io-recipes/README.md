# 21 Digital IO Recipes

Run these commands from the `mc-examples` directory. Each command sets the
library root explicitly so `--lib mcode` loads the repository copy of the
standard library.

Set the library root for an interactive shell if you prefer shorter commands:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

Generated HTML is written next to each example source file.

## 301 GPIO LED

`301-gpio-led.mc` describes a GPIO-driven LED indicator.

`PWR` creates the `V3V3` and `GND` rails for the logic domain. `GPIO_LED`
represents a digital output pin from a controller that is not modeled in this
small example. The GPIO signal drives `D_STATUS.ANODE` through the current
limiting resistor `R_LED`, and `D_STATUS.CATHODE` returns to `GND`.

Parse `301-gpio-led.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 21-digital-io-recipes/301-gpio-led.mc
```

Generate HTML for `301-gpio-led.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 21-digital-io-recipes/301-gpio-led.mc -o 21-digital-io-recipes/301-gpio-led.html
```

## 302 Button Input

`302-button-input.mc` describes a normally high push-button input.

`PWR` creates the `V3V3` and `GND` rails. `R_PULLUP` connects from `V3V3` to
the `BUTTON_IN` node, so the input is high when the button is open. `SW_USER`
connects `BUTTON_IN` to `GND` when pressed, pulling the input low.

Parse `302-button-input.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 21-digital-io-recipes/302-button-input.mc
```

Generate HTML for `302-button-input.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 21-digital-io-recipes/302-button-input.mc -o 21-digital-io-recipes/302-button-input.html
```

## 303 NMOS Low-Side Driver

`303-nmos-low-side-driver.mc` describes a simple low-side switch.

`PWR` creates the `V5V` and `GND` rails. `R_LOAD` represents a small load from
`V5V` to the drain of `Q_SWITCH`. The NMOS source is tied to `GND`, so the load
can conduct when the gate is driven high. `GPIO_LOAD` reaches the gate through
`R_GATE`, and `R_PULLDOWN` keeps the gate low when the control signal is not
driven.

Parse `303-nmos-low-side-driver.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 21-digital-io-recipes/303-nmos-low-side-driver.mc
```

Generate HTML for `303-nmos-low-side-driver.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 21-digital-io-recipes/303-nmos-low-side-driver.mc -o 21-digital-io-recipes/303-nmos-low-side-driver.html
```

## 304 Relay Driver With Flyback Diode

`304-relay-driver-with-flyback-diode.mc` describes an NMOS relay coil driver.

`PWR` creates the `V5V` and `GND` rails. The relay coil high side connects to
`V5V`, and the low side is named `COIL_LOW`. `Q_RELAY` switches `COIL_LOW` to
`GND`. `GPIO_RELAY` drives the gate through `R_GATE`, while `R_PULLDOWN` keeps
the gate off by default. `D_FLYBACK` is placed across the coil with its cathode
on `V5V` and its anode on `COIL_LOW`, giving coil current a safe path when the
MOSFET turns off.

Parse `304-relay-driver-with-flyback-diode.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 21-digital-io-recipes/304-relay-driver-with-flyback-diode.mc
```

Generate HTML for `304-relay-driver-with-flyback-diode.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 21-digital-io-recipes/304-relay-driver-with-flyback-diode.mc -o 21-digital-io-recipes/304-relay-driver-with-flyback-diode.html
```

## 305 RGB LED PWM

`305-rgb-led-pwm.mc` describes a common-cathode RGB LED driven by three PWM
signals.

`PWR` creates the `V3V3` and `GND` rails for the logic domain. `PWM_RED`,
`PWM_GREEN`, and `PWM_BLUE` are controller output nodes. Each PWM node drives
one LED anode through its own current limiting resistor, and
`D_RGB.COMMON_CATHODE` returns to `GND`.

Parse `305-rgb-led-pwm.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 21-digital-io-recipes/305-rgb-led-pwm.mc
```

Generate HTML for `305-rgb-led-pwm.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 21-digital-io-recipes/305-rgb-led-pwm.mc -o 21-digital-io-recipes/305-rgb-led-pwm.html
```
