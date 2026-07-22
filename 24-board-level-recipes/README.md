# 24 Board-Level Recipes

These recipes combine smaller cookbook patterns into complete, readable board
sketches. They are still conceptual examples: each selected MCU, regulator,
connector, and protection part needs datasheet-specific values in a real board.

Run commands from the `mc-examples` directory. Each command sets the library root
explicitly so `--lib mcode` loads the repository copy of the standard library.

Set the library root for an interactive shell if you prefer shorter commands:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

Generated HTML is written next to each example source file.

## 241 Minimal MCU Board

`241-minimal-mcu-board.mc` describes a generic 3.3 V MCU board core. Its purpose
is to show how a local MCU component, a supply rail, decoupling capacitors,
reset support, and a small debug-style header fit together.

Functional blocks:

- `PWR` creates the local 3.3 V source and ground reference.
- `GENERIC_MCU` is a small local component with explicit `VCC`, `GND`,
  `RESET_N`, `DBG_IO`, and `DBG_CLK` pins.
- `C_MCU` is a 100 nF local decoupling capacitor and `C_BULK` is a 4.7 uF
  nearby bulk capacitor.
- `R_RESET` pulls the active-low reset net up to `V3V3`.
- `J_DEBUG` exposes `V3V3`, `GND`, `RESET_N`, `DBG_IO`, and `DBG_CLK` on a
  five-pin header.

Power flows from `PWR.1` to `V3V3`, then to `U_MCU.VCC`, both capacitors, the
reset pull-up, and header pin 1. `PWR.2` creates `GND`, shared by the MCU,
capacitors, and header pin 2. `RESET_N`, `DBG_IO`, and `DBG_CLK` are named board
nets. `RESET_N` is pulled high by `R_RESET`, connected to `U_MCU.RESET_N`, and
also exposed on the header; the two debug nets run from the MCU to the header
without claiming a specific debug protocol.

This recipe composes patterns from earlier chapters rather than introducing a
new board abstraction. The local component shape follows
`03-define-components-and-interfaces/031-named-pins-component.mc`; the pull-up
pattern follows `21-digital-io-recipes/212-button-input.mc`; the decoupling
pattern follows `00-getting-started/003-decoupling-capacitor.mc` and
`04-functions-and-reuse/044-decoupling-library-method.mc`; the header style
follows `22-interface-recipes/221-uart-debug-header.mc`.

Important omissions: this is not a specific commercial MCU reference design. It
does not model oscillator requirements, boot straps, reset timing, regulator
sequencing, programming protocol details, ESD protection, or all power pins that
a real MCU package may need. The capacitor and resistor values are illustrative
only.

Parse `241-minimal-mcu-board.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 24-board-level-recipes/241-minimal-mcu-board.mc --lib mcode --pass1 --pass2
```

Generate HTML for `241-minimal-mcu-board.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 24-board-level-recipes/241-minimal-mcu-board.mc --lib mcode --viz -o 24-board-level-recipes/241-minimal-mcu-board.html
```

## 242 USB-Powered MCU Board

`242-usb-powered-mcu-board.mc` describes a power-only USB-powered MCU board. The
USB connector is used for VBUS and ground; the example does not connect USB
data pins and does not describe USB enumeration.

Functional blocks:

- `J_USB` is a USB Micro-B connector used as a 5 V input.
- `F_USB` is a resettable PTC fuse in series with VBUS.
- `D_VBUS` clamps the protected 5 V rail to ground with its cathode on
  `VBUS_5V` and anode on `GND`.
- `U_LDO` converts the protected 5 V rail to `V3V3`.
- `C_VBUS`, `C_LDO_IN`, and `C_LDO_OUT` are input and regulator capacitors.
- `GENERIC_MCU`, `C_MCU`, and `R_RESET` form the same small MCU core pattern as
  the minimal board.

The power path is:

```mc
J_USB.1 -> USB_VBUS_IN
USB_VBUS_IN -> F_USB -> VBUS_5V
VBUS_5V -> U_LDO.INPUT
U_LDO.OUTPUT -> V3V3
V3V3 -> U_MCU.VCC
```

`J_USB.5`, `U_LDO.GND`, the capacitors, the TVS anode, and `U_MCU.GND` all share
the same `GND` net. `RESET_N` is pulled up to `V3V3` and then connected to the
MCU reset pin.

This recipe combines the USB power-input pattern from
`20-power-recipes/202-usb-5v-input.mc`, the LDO pattern from
`20-power-recipes/203-ldo-5v-to-3v3.mc`, and the MCU support pattern from
`241-minimal-mcu-board.mc`. The polarity-sensitive TVS connection follows the
same orientation used in `02-circuits-with-branches/022-tvs-input-protection.mc`.

Important omissions: USB data, USB-C configuration resistors, inrush-current
limits, connector shield handling, regulator enable pins, thermal limits, exact
capacitor ESR requirements, MCU boot pins, and real programming/debug signals
are outside this example. The LDO instance records rated values and pins; MCode
does not simulate regulation behavior.

Parse `242-usb-powered-mcu-board.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 24-board-level-recipes/242-usb-powered-mcu-board.mc --lib mcode --pass1 --pass2
```

Generate HTML for `242-usb-powered-mcu-board.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 24-board-level-recipes/242-usb-powered-mcu-board.mc --lib mcode --viz -o 24-board-level-recipes/242-usb-powered-mcu-board.html
```

## 243 I2C Sensor Node

`243-i2c-sensor-node.mc` describes a small 3.3 V controller board with one I2C
sensor. Its purpose is to show how power, ground, a master/slave I2C interface,
two bus pull-ups, local decoupling capacitors, and a simple expansion header fit
together in one readable board-level example.

Functional blocks:

- `PWR` creates the local 3.3 V source and ground reference.
- `SENSOR_NODE_MCU` is a local controller component with `I2C0` bound as an
  `I2C(Master)` interface, plus explicit `VCC` and `GND` pins.
- `BOARD_I2C_SENSOR` is a local sensor component with `I2C0` bound as an
  `I2C(Slave)` interface, plus explicit `VCC` and `GND` pins.
- `R_SCL` and `R_SDA` pull the shared I2C clock and data lines up to `V3V3`.
- `C_MCU` and `C_SENSOR` are local 100 nF decoupling capacitors from `V3V3` to
  `GND`.
- `J_I2C` exposes `V3V3`, `GND`, `I2C_SCL`, and `I2C_SDA` on a four-pin header.

Power flows from `PWR.1` to the named `V3V3` rail, then to `U_MCU.VCC`,
`U_SENSOR.VCC`, both decoupling capacitors, both pull-up resistors, and header
pin 1. `PWR.2` creates `GND`, shared by the MCU, sensor, capacitors, and header
pin 2.

The I2C pins use the same interface-member paths introduced earlier:

```mc
U_MCU.I2C0.SCL -> I2C_SCL
U_SENSOR.I2C0.SCL -> I2C_SCL
U_MCU.I2C0.SDA -> I2C_SDA
U_SENSOR.I2C0.SDA -> I2C_SDA
```

The `I2C0::I2C(Master)` binding on the MCU and the `I2C0::I2C(Slave)` binding
on the sensor come from the standard `I2C` interface definition. Both roles use
the same member names, `SCL` and `SDA`, so the board-level nets connect the
matching clock and data pins together. The pull-ups are separate components
connected from `V3V3` to each line:

```mc
V3V3 -> R_SCL -> I2C_SCL
V3V3 -> R_SDA -> I2C_SDA
```

This recipe is intentionally a single-file board composition. It reuses the I2C
sensor bus pattern from `22-interface-recipes/222-i2c-sensor-bus.mc`, the local
component style from `03-define-components-and-interfaces`, and the board power
and decoupling style from `241-minimal-mcu-board.mc`. The related
`06-multi-file-project` chapter teaches how to split similar pieces across
multiple files; this recipe keeps the pieces together so the complete electrical
topology is visible in one place.

Important omissions: this is not a specific MCU or sensor reference design. It
does not model I2C transactions, addresses, timing, bus capacitance, measured
sensor values, interrupt pins, address-select pins, regulators, USB power,
clocking, reset, or programming connectors. The 4.7 kOhm pull-up values are
illustrative only; real boards choose pull-ups from supply voltage, bus speed,
capacitance, and device requirements.

Parse `243-i2c-sensor-node.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 24-board-level-recipes/243-i2c-sensor-node.mc --lib mcode --pass1 --pass2
```

Generate HTML for `243-i2c-sensor-node.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 24-board-level-recipes/243-i2c-sensor-node.mc --lib mcode --viz -o 24-board-level-recipes/243-i2c-sensor-node.html
```

## 244 Mono Audio Line Output

`244-mono-audio-line-output.mc` describes a small single-supply buffer for an
already biased mono audio signal. It is a line-output stage: its purpose is to
isolate a source from a following high-impedance line input and remove the
buffer's DC output level before the signal reaches the connector. It is not a
speaker power amplifier and is not presented as a headphone driver.

Functional blocks:

- `PWR` creates the illustrative 5 V supply and ground reference.
- `U_BUF` is an `AMP.BUFFER` with `IN`, `OUT`, `DC.Vcc`, and `DC.Vee`
  member paths from the standard library.
- `C_DECOUPLE` is a local 100 nF ceramic supply decoupling capacitor.
- `C_OUT` is a 1 uF film capacitor in series with the output signal.
- `R_OUT_REF` is a 100 kOhm resistor from the connector-side output node to
  ground.
- `J_LINE_OUT` is a two-pin `AUDIO.RCA` connector whose `Center` carries the
  signal and whose `Shield` connects to ground.

The power and ground path is explicit:

```mc
PWR.1 -> V5V
PWR.2 -> GND
V5V -> U_BUF.DC.Vcc
U_BUF.DC.Vee -> GND
V5V -> C_DECOUPLE -> GND
```

The buffer therefore uses the 5 V rail as its positive supply and ground as its
negative supply reference. `C_DECOUPLE` spans those same two rails. Its 100 nF
value is illustrative; a real buffer's datasheet determines the required local
decoupling, bulk capacitance, placement, and grounding.

The complete signal path is:

```mc
AUDIO_IN -> U_BUF.IN
U_BUF.OUT -> C_OUT -> AUDIO_LINE_OUT
AUDIO_LINE_OUT -> J_LINE_OUT.Center
J_LINE_OUT.Shield -> GND
```

`AUDIO_IN` represents an external mono analog signal that is already biased to
stay within the selected buffer's valid single-supply input range. This recipe
does not create that bias or verify the allowed common-mode and signal swing.
The specific source must be checked against the selected buffer datasheet.

`C_OUT` is a DC-blocking output coupling capacitor. It separates any DC level
at `U_BUF.OUT` from `AUDIO_LINE_OUT` while allowing the audio-frequency AC
signal to continue toward the connector. `R_OUT_REF` is deliberately connected
from `AUDIO_LINE_OUT`, on the connector side of `C_OUT`, to `GND`:

```mc
AUDIO_LINE_OUT -> R_OUT_REF -> GND
```

This placement gives the exposed output a defined DC reference and discharge
path without bypassing the coupling capacitor. The capacitor, resistor, and
downstream input impedance form a high-pass response in real hardware, but
MCode does not simulate its cutoff frequency or waveform behavior. The 1 uF
and 100 kOhm values are illustrative.

A line output is intended to feed a high-impedance input on another audio
device. Headphone outputs must supply more current into relatively low
impedances, while speaker outputs require a power amplifier capable of driving
an even more demanding load. `AMP.BUFFER` records illustrative input
impedance, maximum output current, and supply-voltage specifications, but MCode
does not prove gain, clipping level, frequency response, stability, output
impedance, load current, or thermal performance. This recipe must not be used
to claim support for passive speakers, low-impedance headphones, or high-power
loads.

The preferred connector was `AUDIO.TRS_35MM("mono")`. The library definition
declares a conditional mono variant with `Tip` and `Sleeve`, but the current MCC
Pass 2 instantiation retains the default stereo pin set even when the
configuration spec resolves to `"mono"`. The recipe therefore uses the
unconditional two-pin `AUDIO.RCA` definition, whose `Center` and `Shield` pins
resolve correctly. This keeps the example runnable without inventing a codec,
microphone, speaker, power amplifier, or unsupported connector behavior.

Production designs also need a selected buffer part and its reference circuit,
input and output protection, source and load impedance checks, bias generation,
power sequencing, pop/click control, connector ESD protection, grounding and
layout review, tolerance analysis, and verification of capacitor dielectric and
voltage ratings. None of those checks is implied by this conceptual recipe.

Related examples include
`00-getting-started/003-decoupling-capacitor.mc` for supply decoupling,
`01-basic-circuits/012-rc-low-pass-filter.mc` for a series/shunt passive signal
path, `04-functions-and-reuse/044-decoupling-library-method.mc` for library
decoupling helpers, and `90-language-reference/907-conditions-and-dynamic-pins.mc`
for a small example of conditional component pins.

Parse `244-mono-audio-line-output.mc` and print both Pass 1 and Pass 2:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 24-board-level-recipes/244-mono-audio-line-output.mc --lib mcode --pass1 --pass2
```

Generate HTML for `244-mono-audio-line-output.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 24-board-level-recipes/244-mono-audio-line-output.mc --lib mcode --viz -o 24-board-level-recipes/244-mono-audio-line-output.html
```
