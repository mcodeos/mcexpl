# MC Examples Authoring Guide

This directory is a user-facing learning repository for MCode examples. Treat
it as documentation plus runnable examples, not as compiler implementation
work.

## Audience And Goal

- Write for beginners who know basic electronics but are new to MCode.
- The examples should teach MCode through small practical circuits first, then
  through focused language patterns.
- Keep every file, heading, comment, identifier, and generated documentation in
  English.
- Prefer clear, boring examples over clever examples.

## Target Structure

Use a three-part structure:

```text
00-getting-started/
01-basic-circuits/
02-circuits-with-branches/
03-define-components-and-interfaces/
04-functions-and-reuse/
05-dynamic-pins-and-conditions/
06-multi-file-project/

20-power-recipes/
21-digital-io-recipes/
22-interface-recipes/
23-sensor-recipes/
24-board-level-recipes/

90-language-reference/
```

The `00` through `06` directories are the main tutorial path. Each chapter
should introduce a small number of new MCode language capabilities and reuse
previous capabilities without reteaching them.

The `20` through `24` directories are practical circuit recipes. They can be
organized by application domain and may use language features already taught in
the tutorial path.

The `90-language-reference` directory is a compact syntax reference by example.
It should align with the MCD code rules document under `../mcd/doc/` where that
document describes currently supported syntax.

Numbered example filenames use `CCN`, where `CC` is the two-digit directory
number and `N` is the example's order within that directory. For example,
chapter `02` uses `021`, `022`, and so on, while recipe chapter `20` uses `201`,
`202`, and so on. Keep README headings, commands, and cross-references aligned
with the filename whenever an example is added or renamed.

## Tutorial Path

Use this progression for the beginner tutorial:

- `00-getting-started`: file shape, comments, `module main`, simple instances,
  units, named nets, simple `->` connections, and one readable switch-pin path.
- `01-basic-circuits`: common two-pin components, named analog nodes, simple
  parameters, and polarity-sensitive member access such as `D_RECT.ANODE`.
- `02-circuits-with-branches`: branch-like circuits, multiple devices sharing a
  named node, protection networks, and explicit grouping only when it remains
  beginner-readable.
- `03-define-components-and-interfaces`: `component` definitions, attributes,
  simple named pins, pin directions, pin ranges, aliases where useful, and
  interface binding such as `UART0::UART.TTL(DCE)`. Introduce a named-pin
  component before interface binding.
- `04-functions-and-reuse`: component `func` definitions, parameters, `this`,
  returned connection points where supported, named inline construction such as
  `NAME::TYPE()`, and small reusable connection methods such as LED indicators,
  pull-ups, and decoupling helpers. Split these features across examples.
- `05-dynamic-pins-and-conditions`: default parameters, `if` / `else`, conditional
  attributes, and `pins +=` for configurable components.
- `06-multi-file-project`: reusable module ports and instances first, then local
  `use`, cross-file component and module reuse, and a small project split across
  multiple `.mc` files.

Each tutorial chapter README must include:

- A short purpose paragraph.
- An explanation for every example in exact tutorial reading order: `001`,
  `002`, `003`, `004`, `011`, and so on.
- For each example, both the circuit intent and every MCode language feature
  that appears for the first time at that point in the tutorial path.
- Concrete explanations of unfamiliar punctuation and keywords beside the
  first example that uses them.
- Copyable parse and visualization commands.

A chapter-level `Language Focus` or `New in this chapter` summary is optional.
It must not replace the explanations beside each example. Once syntax has been
explained in an earlier example, do not explain it again unless the later
example uses it in a meaningfully different way.

## Recipe Path

Use these recipe groups:

- `20-power-recipes`: battery input, USB 5 V input, LDO conversion, a beginner
  buck module, an advanced buck controller power stage, and a small power tree.
- `21-digital-io-recipes`: GPIO LED, button input, NMOS low-side driver, relay
  driver with flyback diode, and RGB LED PWM.
- `22-interface-recipes`: UART debug header, I2C sensor bus, SPI flash, USB
  device port, and RS485 UART bridge.
- `23-sensor-recipes`: NTC divider, photodiode input, ADC input RC filter, and
  optionally current-sense input.
- `24-board-level-recipes`: minimal MCU board, USB-powered MCU board, I2C sensor
  node, and a mono audio line-output buffer.

When migrating existing examples, keep useful `.mc` content instead of
rewriting it from scratch:

- Move current `02-power` material into `20-power-recipes`.
- Move current `03-digital-io` material into `21-digital-io-recipes`.
- Move current `04-interfaces` material into `22-interface-recipes`.
- Rebuild new tutorial chapters `02` through `06` around language progression,
  not around application categories.

Use recipe filenames that match their directory number:

- `20-power-recipes`: `201` through `206`.
- `21-digital-io-recipes`: `211` through `215`.
- `22-interface-recipes`: `221` through `225`.
- `23-sensor-recipes`: `231` through `233` unless the directory gains more
  examples.
- `24-board-level-recipes`: `241` through `244` unless the directory gains more
  examples.

## Language Reference

Use `90-language-reference` for focused examples that are easy to find and easy
to compare with the syntax rules document. Prefer these topics:

- Component definitions.
- Pins and attributes.
- Module ports.
- Arrays, ranges, and indexed names.
- Functions and reuse.
- Conditional attributes and conditional pins.
- Cross-file `use`.

Reference examples should be small and explicit. They do not need to be realistic
application circuits, but they must parse unless the file is clearly marked as a
non-runnable negative example.

## Example Style

- Keep examples short enough to read in one screen when possible.
- Use stable names such as `V3V3`, `V5V`, `GND`, `VIN`, `VOUT`, `U_MCU`,
  `J_DEBUG`, and `R_PULLUP`.
- Prefer one concept per example in the tutorial path.
- Avoid introducing advanced syntax before its tutorial chapter.
- Comments in `.mc` files should explain intent, not restate the syntax.
- Do not generate or commit HTML, images, PDFs, or other local artifacts.

## Validation

Before finishing changes in this directory:

- Run the smallest relevant validation.
- For changed runnable examples, run `../mcc/target/debug/mcc parse
  <path-to-example.mc> --lib mcode --pass1 --pass2` from `mc-examples` with
  `MCC_SYSTEM_ROOT` set to the parent directory that contains `mcode/`.
- If visualization output is relevant, generate it only as an ignored local
  artifact and do not commit it.
- Report any example that could not be validated.
