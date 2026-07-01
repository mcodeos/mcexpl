# MC Examples

MCode is a circuit description language for writing electronic designs as
structured text. MCC parses `.mc` files, resolves components, interfaces,
modules, nets, and connections, and can generate interactive HTML
visualizations of the described circuit. The basic `mcode` library provides
common electronics building blocks such as resistors, capacitors, LEDs, diodes,
regulators, connectors, power rails, and common interfaces.

The current toolchain focuses on parsing, checking, and visualization. Future
work is expected to extend the flow toward richer hardware automation, including
PCB-oriented generation.

This repository contains beginner-friendly MCode examples. The examples are
organized as a learning path: start with small circuits, then move into power
systems, digital IO, common interfaces, sensors, and board-level composition.

The examples are intended for users who want to learn how to describe practical
circuits with MCode and the `mcode` basic library.

## Quick Start

These examples assume the usual local source checkout layout:

```text
workspace/
|-- mcc/           # MCC compiler source
|-- mcode/         # MCode basic library
`-- mc-examples/   # This examples repository
```

If your directories are in different locations, adjust the paths before using the
commands below.

Build MCC:

```bash
cd ../mcc
cargo build
```

Return to the examples directory and point MCC at the directory that contains
`mcode/`:

```bash
cd ../mc-examples
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

`MCC_SYSTEM_ROOT` should be the parent directory of `mcode/`. With the layout
above, MCC loads the basic library from `$MCC_SYSTEM_ROOT/mcode/mcode.mc`.

Parse an example:

```bash
../mcc/target/debug/mcc parse --lib mcode 00-getting-started/001-power-net.mc
```

Generate an HTML visualization:

```bash
../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/001-power-net.mc
```

By default, `--viz` writes `circuit.html` in the current directory. Use `-o` to
choose the output path:

```bash
../mcc/target/debug/mcc parse --lib mcode --viz 00-getting-started/001-power-net.mc -o 00-getting-started/001-power-net.html
```

For these user examples, generated HTML files can be written next to the source
`.mc` files. The repository ignores generated `.html` files.

Command parts:

- `export MCC_SYSTEM_ROOT="$(cd .. && pwd)"` tells MCC where to find local
  system libraries. The path must contain a `mcode/` directory.
- `../mcc/target/debug/mcc` runs the MCC binary built by `cargo build`.
- `parse` parses one MCode file and reports the resolved design structure.
- `--lib mcode` loads the MCode basic library, including common components and
  interfaces such as `RES`, `CAP`, `LED`, `DIO`, `REG`, `GPIO`, `I2C`, `SPI`,
  `UART`, and `DC`.
- `--viz` asks MCC to generate a visual HTML schematic.
- `-o <path>` sets the output file for generated visualization results.
- `00-getting-started/001-power-net.mc` is the input example file.

Each numbered example directory can include a small `README.md` with copyable
parse and visualization commands. You can also use the
`parse --lib mcode <file.mc>` and
`parse --lib mcode --viz <file.mc> -o <output.html>` patterns above.

## Learning Path

### 00 Getting Started

Small examples that introduce the minimum syntax needed to read and write MCode.

- `001-power-net.mc`: Declare and connect a basic power net.
- `002-resistor-led.mc`: Build a simple LED indicator with a resistor.
- `003-decoupling-capacitor.mc`: Add a capacitor across a power rail.
- `004-button-pullup.mc`: Model a push button with a pull-up resistor.

### 01 Basic Circuits

Common analog and protection circuits made from basic components.

- `101-voltage-divider.mc`: Create a resistor divider and a measured output.
- `102-rc-low-pass-filter.mc`: Combine a resistor and capacitor as a filter.
- `103-diode-rectifier.mc`: Use a diode to pass current in one direction.
- `104-zener-clamp.mc`: Clamp a signal with a Zener diode.
- `105-tvs-input-protection.mc`: Protect an input with a TVS diode.

### 02 Power

Power inputs, regulators, and simple power trees.

- `201-battery-input.mc`: Represent a battery-powered input.
- `202-usb-5v-input.mc`: Use USB as a 5 V power source.
- `203-ldo-5v-to-3v3.mc`: Convert 5 V to 3.3 V with an LDO.
- `204-buck-12v-to-5v.mc`: Convert 12 V to 5 V with a buck regulator.
- `205-power-tree-5v-3v3-1v8.mc`: Build a small multi-rail power tree.

### 03 Digital IO

GPIO-driven circuits and switching outputs.

- `301-gpio-led.mc`: Drive an LED from a GPIO signal.
- `302-button-input.mc`: Connect a button to a digital input.
- `303-nmos-low-side-driver.mc`: Use an NMOS as a low-side switch.
- `304-relay-driver-with-flyback-diode.mc`: Drive a relay and add flyback
  protection.
- `305-rgb-led-pwm.mc`: Connect RGB LED channels to PWM-style control signals.

### 04 Interfaces

Common board-level communication interfaces.

- `401-uart-debug-header.mc`: Expose UART signals on a debug header.
- `402-i2c-sensor-bus.mc`: Connect an I2C controller to a sensor bus.
- `403-spi-flash.mc`: Connect an SPI controller to a flash device.
- `404-usb-device-port.mc`: Model a USB device connector.
- `405-rs485-uart-bridge.mc`: Bridge UART signals to an RS485 transceiver.

### 05 Sensors

Simple sensor front-end circuits.

- `501-ntc-temperature-divider.mc`: Use an NTC thermistor in a divider.
- `502-photodiode-input.mc`: Connect a photodiode input stage.
- `503-adc-input-rc-filter.mc`: Add an RC filter before an ADC input.

### 06 Board Level

Examples that combine several smaller circuits into board-level modules.

- `601-minimal-mcu-board.mc`: Start a minimal MCU board structure.
- `602-usb-powered-mcu-board.mc`: Combine USB input, regulation, and MCU power.
- `603-i2c-sensor-node.mc`: Compose power, MCU, I2C, and sensor blocks.
- `604-audio-demo-board.mc`: Sketch a small audio-oriented board.

### 90 Language Patterns

Focused examples for language features that are useful across many circuits.

- `901-component-definition.mc`: Define a small custom component.
- `902-module-composition.mc`: Compose reusable modules.
- `903-interface-binding.mc`: Bind pins to an interface.
- `904-arrays-and-ranges.mc`: Use arrays and ranges for repeated items.
- `905-cross-file-use/`: Split an example across multiple files with `use`.

## Contributing

Issues and pull requests are welcome. If you find an example that does not parse,
is hard to understand, uses a poor circuit pattern, or misses an important
beginner use case, please open an issue and describe the problem.

Community contributions can help improve:

- clearer beginner explanations;
- more practical circuit examples;
- fixes for broken or outdated examples;
- better naming and organization;
- small scripts that make examples easier to run.

Please keep examples focused, readable, and based on the existing MCode and
`mcode` library conventions.
