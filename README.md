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
organized into three parts:

- A tutorial path that introduces MCode language capabilities step by step.
- A recipe cookbook that shows practical circuit patterns by application area.
- A language reference section with focused syntax examples.

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
../mcc/target/debug/mcc parse 00-getting-started/001-power-net.mc --lib mcode --pass1 --pass2
```

Generate an HTML visualization:

```bash
../mcc/target/debug/mcc parse 00-getting-started/001-power-net.mc --lib mcode --viz
```

By default, `--viz` writes `circuit.html` in the current directory. Use `-o` to
choose the output path:

```bash
../mcc/target/debug/mcc parse 00-getting-started/001-power-net.mc --lib mcode --viz -o 00-getting-started/001-power-net.html
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

Each numbered example directory includes or can include a small `README.md` with
copyable parse and visualization commands. You can also use the
`parse <file.mc> --lib mcode --pass1 --pass2` and
`parse <file.mc> --lib mcode --viz -o <output.html>` patterns above.

## Tutorial Path

### 00 Getting Started

Small examples that introduce the minimum syntax needed to read and run MCode.

- `001-power-net.mc`: Declare and connect a basic power net.
- `002-resistor-led.mc`: Build a simple LED indicator with a resistor.
- `003-decoupling-capacitor.mc`: Add a capacitor across a power rail.
- `004-button-pullup.mc`: Model a push button with a pull-up resistor.

### 01 Basic Circuits

Common small circuits made from basic components.

- `011-voltage-divider.mc`: Create a resistor divider and a measured output.
- `012-rc-low-pass-filter.mc`: Combine a resistor and capacitor as a filter.
- `013-diode-rectifier.mc`: Use a diode to pass current in one direction.

### 02 Circuits With Branches

Branch-like circuits where multiple devices share named signal or power nodes.

- `021-zener-clamp.mc`: Add a Zener clamp branch to a protected node.
- `022-tvs-input-protection.mc`: Add a TVS protection branch to an input node.
- `023-input-rc-esd.mc`: Combine a series input resistor, filter capacitor, and
  ESD diode on one node.
- `024-simple-power-branch.mc`: Feed multiple branches from one power rail.

### 03 Define Components And Interfaces

Local component definitions, pins, and interface binding.

- `031-named-pins-component.mc`: Define and instantiate a component with named
  pins.
- `032-pin-directions-and-ranges.mc`: Add pin directions, physical ranges, and
  indexed pin names without interfaces.
- `033-uart-interface-binding.mc`: Bind MCU pins to a UART interface and debug
  header.
- `034-i2c-sensor-component.mc`: Define I2C controller and sensor components.
- `035-spi-flash-component.mc`: Define SPI master and flash components.

### 04 Functions And Reuse

Reusable connection methods on component definitions.

- `041-led-indicator-function.mc`: Give a status LED a reusable connection method.
- `042-pullup-helper-function.mc`: Configure two pull-up channels with a returned
  instance and a chained method call.
- `043-inline-construction-function.mc`: Name a helper instance inside a method
  call.
- `044-decoupling-library-method.mc`: Reuse a library method on two rails.

### 05 Dynamic Pins And Conditions

Configurable components with conditions and dynamic pin additions.

- `051-led-package-variant.mc`: Select attributes from a package parameter.
- `052-gpio-expander-pins.mc`: Add pins for a larger GPIO expander variant.
- `053-rs485-termination-pins.mc`: Add optional termination connection pins.

### 06 Modules And A Multi-File Project

Reusable circuit modules followed by a small project split across local files.

- `061-reusable-module.mc`: Define an LED circuit module and instantiate it twice.
- `062-main.mc`: Import a power module plus MCU and sensor components, then
  connect a small I2C sensor node.

## Recipe Cookbook

### 20 Power Recipes

Power inputs, regulators, and simple power trees.

- `201-battery-input.mc`: Represent a battery-powered input.
- `202-usb-5v-input.mc`: Use USB as a 5 V power source.
- `203-ldo-5v-to-3v3.mc`: Convert 5 V to 3.3 V with an LDO.
- `204-buck-12v-to-5v.mc`: Treat a complete 12 V to 5 V buck module as a
  three-terminal regulator block.
- `205-power-tree-5v-3v3-1v8.mc`: Build a small multi-rail power tree.
- `206-buck-controller-power-stage.mc`: Build an asynchronous buck power stage
  around a controller with external `SW` and `FB` pins.

### 21 Digital IO Recipes

GPIO-driven circuits and switching outputs.

- `211-gpio-led.mc`: Drive an LED from a GPIO signal.
- `212-button-input.mc`: Connect a button to a digital input.
- `213-nmos-low-side-driver.mc`: Use an NMOS as a low-side switch.
- `214-relay-driver-with-flyback-diode.mc`: Drive a relay and add flyback
  protection.
- `215-rgb-led-pwm.mc`: Connect RGB LED channels to PWM-style control signals.

### 22 Interface Recipes

Common board-level communication interfaces.

- `221-uart-debug-header.mc`: Expose UART signals on a debug header.
- `222-i2c-sensor-bus.mc`: Connect an I2C controller to a sensor bus.
- `223-spi-flash.mc`: Connect an SPI controller to a flash device.
- `224-usb-device-port.mc`: Model a USB device connector.
- `225-rs485-uart-bridge.mc`: Bridge UART signals to an RS485 transceiver.

### 23 Sensor Recipes

Simple sensor front-end circuits.

- `231-ntc-temperature-divider.mc`: Use an NTC thermistor in a divider.
- `232-photodiode-input.mc`: Connect a photodiode input stage.
- `233-adc-input-rc-filter.mc`: Add an RC filter before an ADC input.

### 24 Board-Level Recipes

Examples that combine several smaller circuits into board-level modules.

- `241-minimal-mcu-board.mc`: Start a minimal MCU board structure.
- `242-usb-powered-mcu-board.mc`: Combine USB input, regulation, and MCU power.
- `243-i2c-sensor-node.mc`: Compose power, MCU, I2C, and sensor blocks.
- `244-mono-audio-line-output.mc`: Buffer and AC-couple a mono line-level
  output to an RCA connector.

## Language Reference

### 90 Language Reference

Focused examples for language features that are useful across many circuits.

- `901-component-definition.mc`: Define a small custom component.
- `902-attributes-spec-typed-parameters.mc`: Use typed parameters and `spec`.
- `903-pins-ranges-indexed-names.mc`: Use pin directions, ranges, and indexed
  names.
- `904-module-ports.mc`: Declare module ports with direction markers.
- `905-interface-binding-roles.mc`: Bind pins to an interface role.
- `906-functions-method-calls.mc`: Use `func`, `this`, `return`, and method
  calls.
- `907-conditions-and-dynamic-pins.mc`: Use conditions and `pins +=`.
- `908-inline-construction-library-method.mc`: Use named inline construction and
  a library method.
- `909-cross-file-use/`: Split an example across multiple files with `use`.

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
