# 22 Interface Recipes

Run these commands from the `mc-examples` directory. Each command sets the
library root explicitly so `--lib mcode` loads the repository copy of the
standard library.

Set the library root for an interactive shell if you prefer shorter commands:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

Generated HTML is written next to each example source file.

## 221 UART Debug Header

`221-uart-debug-header.mc` describes a small UART debug connector.

`MCU_UART` is a tiny local component that exposes one `UART.TTL` interface plus
plain `VCC` and `GND` pins. `J_DEBUG` is a three-pin header. The MCU transmit signal
`U_MCU.UART0.TX` goes to header pin 1, the receive signal
`U_MCU.UART0.RX` goes to header pin 2, and `GND` goes to header pin 3. This
matches the common TX, RX, GND debug-header pattern.

Parse `221-uart-debug-header.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 22-interface-recipes/221-uart-debug-header.mc --lib mcode --pass1 --pass2
```

Generate HTML for `221-uart-debug-header.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 22-interface-recipes/221-uart-debug-header.mc --lib mcode --viz -o 22-interface-recipes/221-uart-debug-header.html
```

## 222 I2C Sensor Bus

`222-i2c-sensor-bus.mc` describes a controller connected to one I2C sensor.

`MCU_I2C` exposes an `I2C` master interface, and `SENSOR_I2C` exposes an `I2C`
slave interface. Both devices share `I2C_SCL` and `I2C_SDA`. `R_SCL` and
`R_SDA` pull those two open-drain bus lines up to `V3V3`, which is the normal
I2C idle state.

Parse `222-i2c-sensor-bus.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 22-interface-recipes/222-i2c-sensor-bus.mc --lib mcode --pass1 --pass2
```

Generate HTML for `222-i2c-sensor-bus.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 22-interface-recipes/222-i2c-sensor-bus.mc --lib mcode --viz -o 22-interface-recipes/222-i2c-sensor-bus.html
```

## 223 SPI Flash

`223-spi-flash.mc` describes a basic four-wire SPI flash connection.

`MCU_SPI` exposes an `SPI` master interface, and `FLASH_SPI` exposes an `SPI`
slave interface. The master drives `CS`, `SCLK`, and `MOSI` to the flash. The
flash drives `MISO` back to the master. Both components share `V3V3` and
`GND`.

Parse `223-spi-flash.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 22-interface-recipes/223-spi-flash.mc --lib mcode --pass1 --pass2
```

Generate HTML for `223-spi-flash.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 22-interface-recipes/223-spi-flash.mc --lib mcode --viz -o 22-interface-recipes/223-spi-flash.html
```

## 224 USB Device Port

`224-usb-device-port.mc` describes a USB Micro-B device-side port.

`J_USB` is the physical connector. Pin 1 is `VBUS_5V`, pin 5 is `GND`, pin 2
is the USB data-minus line, and pin 3 is the data-plus line. `USB_DEVICE`
represents the device controller. The `USB_DM` and `USB_DP` lines connect from
the connector to `U_DEV.DATA.DM` and `U_DEV.DATA.DP`, and each line also has an
ESD diode to ground. `C_VBUS` bypasses the USB VBUS rail.

The binding `USB.DATA(Peripheral)` gives the controller the device-side role
defined by the current USB interface library; the opposite role is `Host`.

Parse `224-usb-device-port.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 22-interface-recipes/224-usb-device-port.mc --lib mcode --pass1 --pass2
```

Generate HTML for `224-usb-device-port.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 22-interface-recipes/224-usb-device-port.mc --lib mcode --viz -o 22-interface-recipes/224-usb-device-port.html
```

## 225 RS485 UART Bridge

`225-rs485-uart-bridge.mc` describes a UART-to-RS485 bridge.

`MCU_UART` provides the controller-side TTL UART. `RS485_BRIDGE` represents a
small transceiver with a UART-side `UART.TTL` interface and bus-side `A`, `B`,
and `GND` pins. The MCU TX signal connects to the bridge RX-side input, while
the bridge TX-side output returns to MCU RX.
`RS485_A` and `RS485_B` leave through `J_BUS`, and `R_TERM` provides a simple
120 ohm termination across the differential pair.

Parse `225-rs485-uart-bridge.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 22-interface-recipes/225-rs485-uart-bridge.mc --lib mcode --pass1 --pass2
```

Generate HTML for `225-rs485-uart-bridge.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse 22-interface-recipes/225-rs485-uart-bridge.mc --lib mcode --viz -o 22-interface-recipes/225-rs485-uart-bridge.html
```
