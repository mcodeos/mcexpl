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
`03-define-components-and-interfaces/301-named-pins-component.mc`; the pull-up
pattern follows `21-digital-io-recipes/212-button-input.mc`; the decoupling
pattern follows `00-getting-started/003-decoupling-capacitor.mc` and
`04-functions-and-reuse/404-decoupling-library-method.mc`; the header style
follows `22-interface-recipes/221-uart-debug-header.mc`.

Important omissions: this is not a specific commercial MCU reference design. It
does not model oscillator requirements, boot straps, reset timing, regulator
sequencing, programming protocol details, ESD protection, or all power pins that
a real MCU package may need. The capacitor and resistor values are illustrative
only.

Parse `241-minimal-mcu-board.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 24-board-level-recipes/241-minimal-mcu-board.mc
```

Generate HTML for `241-minimal-mcu-board.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 24-board-level-recipes/241-minimal-mcu-board.mc -o 24-board-level-recipes/241-minimal-mcu-board.html
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
same orientation used in `02-circuits-with-branches/202-tvs-input-protection.mc`.

Important omissions: USB data, USB-C configuration resistors, inrush-current
limits, connector shield handling, regulator enable pins, thermal limits, exact
capacitor ESR requirements, MCU boot pins, and real programming/debug signals
are outside this example. The LDO instance records rated values and pins; MCode
does not simulate regulation behavior.

Parse `242-usb-powered-mcu-board.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --pass1 --pass2 24-board-level-recipes/242-usb-powered-mcu-board.mc
```

Generate HTML for `242-usb-powered-mcu-board.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 24-board-level-recipes/242-usb-powered-mcu-board.mc -o 24-board-level-recipes/242-usb-powered-mcu-board.html
```

## Not Implemented In This Task

`243-i2c-sensor-node.mc` and `244-audio-demo-board.mc` remain placeholders in
this task. They should not be treated as completed board-level recipes yet.
