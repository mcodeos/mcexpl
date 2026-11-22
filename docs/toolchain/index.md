---
layout: page
title: The MCode toolchain
description: How the language, the compiler, the libraries, and the tools fit together — the map a newcomer needs in their first two weeks.
sidebar: false
outline: false
editLink: false
lastUpdated: false
---

# The MCode toolchain

MCode is a language for describing circuits. This page is the map: what each
piece is, what it does for you, and the order things happen in.

## The layers

```
your circuit (.mc source)
        |
        v
  mcc  -- the compiler: check, build, export, simulate
        |
        +--> mcode   the basic library (passives, sources, standard interfaces)
        +--> mcfam   abstract component families (the shapes: LDO, buck, op-amp, transceiver)
        +--> mcaps   recipes (the behavior: what an LDO must satisfy)
        +--> mcparts real device packs (the parts themselves)
        |
        v
  tools: the command line, the editor extension, the MCode Bench workbench
```

Four open repositories carry the layers: [mcc](https://github.com/mcodeos/mcc)
is the compiler, [mcfam](https://github.com/mcodeos/mcfam) the abstract
families, [mcaps](https://github.com/mcodeos/mcaps) the recipes, and
[mcparts](https://github.com/mcodeos/mcparts) the device packs. The basic
library ships with the compiler.

## What the compiler does for you

| Command | What you get |
|---|---|
| `mcc check` | Syntax and semantic diagnostics — the green/red gate before anything else |
| `mcc build` | A manifest-driven build: loads dependencies, runs both passes, produces the circuit |
| `mcc export netlist` / `bom` / `spice` | The same circuit in the format the next tool wants |
| `mcc run` / `mcc sim` | A readout of what the circuit does — a measurement, never a verdict |
| `mcc lib` | Install and inspect libraries; versions are pinned, not "latest" |
| `mcc matrix` | The submission matrix: every candidate judged against one set of claims |

A design is **checked**, then **built**. A built circuit can be exported,
simulated, and compared against others. Nothing in the chain requires you to
leave the command line — the editor extension and the workbench drive the same
compiler.

## Libraries: four kinds, one rule

| Kind | What it gives you | Example |
|---|---|---|
| Basic library | The parts every design needs | `RES`, `CAP`, `LED`, `DC.SRC`, `GPIO`, `I2C` |
| Abstract family | The *shape* of a part, with no vendor attached | `LDO`, `DCDC`, `XCVR.CAN` |
| Recipe | The *behavior* a part must satisfy | `DEV.PWR.LDO` |
| Device pack | A real, specific part | `sgm2019`, `mcp2551` |

A design declares the family it means; the device pack is what you choose
later. **Pin your versions.** A library is named `name@version`, and a bare
name is refused when several versions are installed — the compiler will not
pick one for you.

## From a line of source to a picture

```bash
mcc check main.mc          # diagnostics first
mcc build main.mc         # the circuit
mcc export bom main.mc    # the parts, with values
```

`mcc check` is the gate: it names what is wrong and where. Run it before you
build, and the build stays boring.

## What is not open

Some capabilities are not open source: the MCode Bench product itself, the
value side of the device data, and the authorization that decides what a given
caller may read. Those are reached through one door — the
[MCode gateway](/gateway/). Nothing on this site links around it, and nothing
here ships a closed binary.

## Where to go next

- [Tutorial](/tutorial/) — the language, one small circuit at a time.
- [Recipes](/recipes/) — application patterns you can adapt.
- [Language reference](/reference/) — the syntax, when you need the exact rule.
- [The MCode gateway](/gateway/) — how closed capabilities are reached.
