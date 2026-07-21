# 20 Power Recipes

Run these commands from the `mc-examples` directory. Each command sets the
library root explicitly so `--lib mcode` loads the repository copy of the
standard library.

Set the library root for an interactive shell if you prefer shorter commands:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

Generated HTML is written next to each example source file.

## 201 Battery Input

`201-battery-input.mc` describes a small protected battery input.

`DC.BAT BAT(3.7V, 1000mAh)` gives the battery's nominal voltage first and its
charge capacity second. `mAh` measures electric charge, while `uF` measures
capacitance; the two units are not interchangeable. The library records this
second value as the battery's `capacity` specification.

The battery positive pin is routed through `F_BAT` and then through the
Schottky diode `D_REVERSE`. The diode anode is on the fused battery side, and
the cathode creates the protected `VBAT_PROTECTED` rail. The battery negative
pin is tied to `GND`. `C_BULK` connects from `VBAT_PROTECTED` to `GND` as a
bulk input capacitor.

Parse `201-battery-input.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/201-battery-input.mc --lib mcode --pass1 --pass2
```

Generate HTML for `201-battery-input.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/201-battery-input.mc --lib mcode --viz -o 20-power-recipes/201-battery-input.html
```

## 202 USB 5 V Input

`202-usb-5v-input.mc` describes a USB Micro-B connector used only as a 5 V
power input.

`J_USB.1` is the USB VBUS pin and feeds `VBUS_5V` through the resettable fuse
`F_USB`. `J_USB.5` is tied to `GND`. `D_VBUS` is a TVS clamp with its cathode
on `VBUS_5V` and its anode on `GND`, and `C_VBUS` connects from `VBUS_5V` to
`GND` as an input bypass capacitor.

Parse `202-usb-5v-input.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/202-usb-5v-input.mc --lib mcode --pass1 --pass2
```

Generate HTML for `202-usb-5v-input.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/202-usb-5v-input.mc --lib mcode --viz -o 20-power-recipes/202-usb-5v-input.html
```

## 203 LDO 5 V to 3.3 V

`203-ldo-5v-to-3v3.mc` describes a 5 V source feeding a 3.3 V LDO regulator.

The source positive pin creates the `V5V` rail, and the source ground pin
creates `GND`. `V5V` connects to `U_LDO.INPUT`, `U_LDO.OUTPUT` creates
`V3V3`, and `U_LDO.GND` connects to `GND`. `C_IN` bypasses `V5V` to `GND`,
while `C_OUT` bypasses `V3V3` to `GND`.

Parse `203-ldo-5v-to-3v3.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/203-ldo-5v-to-3v3.mc --lib mcode --pass1 --pass2
```

Generate HTML for `203-ldo-5v-to-3v3.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/203-ldo-5v-to-3v3.mc --lib mcode --viz -o 20-power-recipes/203-ldo-5v-to-3v3.html
```

## 204 Buck Module 12 V to 5 V

`204-buck-12v-to-5v.mc` describes a complete 12 V to 5 V buck module as a
three-terminal regulator block. This is the beginner representation to use when
the selected module or regulator hides its switch node, inductor, and feedback
network inside the part.

The 12 V source creates `V12V` and `GND`. `V12V` feeds
`U_BUCK_MODULE.INPUT`, `U_BUCK_MODULE.OUTPUT` creates `V5V`, and the module
ground returns to `GND`. `C_IN` and `C_OUT` are the external input and output
capacitors. There is deliberately no `SW` or `FB` connection in this file: those
belong to the controller-level topology in `206`.

Parse `204-buck-12v-to-5v.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/204-buck-12v-to-5v.mc --lib mcode --pass1 --pass2
```

Generate HTML for `204-buck-12v-to-5v.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/204-buck-12v-to-5v.mc --lib mcode --viz -o 20-power-recipes/204-buck-12v-to-5v.html
```

## 205 Power Tree 5 V, 3.3 V, 1.8 V

`205-power-tree-5v-3v3-1v8.mc` describes a small multi-rail power tree.

The 5 V source creates `V5V` and `GND`. `V5V` feeds `U_3V3.INPUT`, and
`U_3V3.OUTPUT` creates the `V3V3` rail. `V3V3` then feeds `U_1V8.INPUT`, and
`U_1V8.OUTPUT` creates the `V1V8` rail. Both regulators have their ground pins
tied to `GND`. `C_5V`, `C_3V3`, and `C_1V8` each connect their rail to `GND`
as local bypass capacitors.

Parse `205-power-tree-5v-3v3-1v8.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/205-power-tree-5v-3v3-1v8.mc --lib mcode --pass1 --pass2
```

Generate HTML for `205-power-tree-5v-3v3-1v8.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/205-power-tree-5v-3v3-1v8.mc --lib mcode --viz -o 20-power-recipes/205-power-tree-5v-3v3-1v8.html
```

## 206 Buck Controller Power Stage

`206-buck-controller-power-stage.mc` shows the more detailed alternative for a
controller whose switching node and feedback input are external pins.

`U_CTRL.SW` drives `SW_NODE`. The power inductor connects `SW_NODE` to `V5V`,
and `D_CATCH` is the asynchronous catch diode with its anode at `GND` and cathode
at `SW_NODE`. `C_OUT` filters the output rail. The feedback divider uses 40 kOhm
over 10 kOhm, so a controller with a 1 V feedback target regulates near 5 V:

```text
VOUT = VFB * (1 + R_TOP / R_BOTTOM)
     = 1 V * (1 + 40 kOhm / 10 kOhm)
     = 5 V
```

This example defines a small local `BUCK_CONTROLLER` because the generic
`REG.BUCK` library type exposes both `OUTPUT` and `SW`, which does not clearly
choose between a complete module and a controller. A real design must still use
the selected controller's datasheet to choose the inductor, diode, capacitors,
feedback values, ratings, and compensation.

Parse `206-buck-controller-power-stage.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/206-buck-controller-power-stage.mc --lib mcode --pass1 --pass2
```

Generate HTML for `206-buck-controller-power-stage.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 20-power-recipes/206-buck-controller-power-stage.mc --lib mcode --viz -o 20-power-recipes/206-buck-controller-power-stage.html
```
