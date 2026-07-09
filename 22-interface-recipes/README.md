# 22 Interface Recipes

Run these commands from the `mc-examples` directory. Each command sets the
library root explicitly so `--lib mcode` loads the repository copy of the
standard library.

Set the library root for an interactive shell if you prefer shorter commands:

```bash
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"
```

Generated HTML is written next to each example source file.

## 401 UART Debug Header

`401-uart-debug-header.mc` describes a small UART debug connector.

`MCU_UART` is a tiny local component that exposes one `UART.TTL` interface plus
plain `VCC` and `GND` pins. `J_DEBUG` is a three-pin header. The MCU transmit signal
`U_MCU.UART0.TX` goes to header pin 1, the receive signal
`U_MCU.UART0.RX` goes to header pin 2, and `GND` goes to header pin 3. This
matches the common TX, RX, GND debug-header pattern.

Parse `401-uart-debug-header.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 22-interface-recipes/401-uart-debug-header.mc
```

Generate HTML for `401-uart-debug-header.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 22-interface-recipes/401-uart-debug-header.mc -o 22-interface-recipes/401-uart-debug-header.html
```

## 402 I2C Sensor Bus

`402-i2c-sensor-bus.mc` describes a controller connected to one I2C sensor.

`MCU_I2C` exposes an `I2C` master interface, and `SENSOR_I2C` exposes an `I2C`
slave interface. Both devices share `I2C_SCL` and `I2C_SDA`. `R_SCL` and
`R_SDA` pull those two open-drain bus lines up to `V3V3`, which is the normal
I2C idle state.

Parse `402-i2c-sensor-bus.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 22-interface-recipes/402-i2c-sensor-bus.mc
```

Generate HTML for `402-i2c-sensor-bus.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 22-interface-recipes/402-i2c-sensor-bus.mc -o 22-interface-recipes/402-i2c-sensor-bus.html
```

## 403 SPI Flash

`403-spi-flash.mc` describes a basic four-wire SPI flash connection.

`MCU_SPI` exposes an `SPI` master interface, and `FLASH_SPI` exposes an `SPI`
slave interface. The master drives `CS`, `SCLK`, and `MOSI` to the flash. The
flash drives `MISO` back to the master. Both components share `V3V3` and
`GND`.

Parse `403-spi-flash.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 22-interface-recipes/403-spi-flash.mc
```

Generate HTML for `403-spi-flash.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 22-interface-recipes/403-spi-flash.mc -o 22-interface-recipes/403-spi-flash.html
```

## 404 USB Device Port

`404-usb-device-port.mc` describes a USB Micro-B device-side port.

`J_USB` is the physical connector. Pin 1 is `VBUS_5V`, pin 5 is `GND`, pin 2
is the USB data-minus line, and pin 3 is the data-plus line. `USB_DEVICE`
represents the device controller. The `USB_DM` and `USB_DP` lines connect from
the connector to `U_DEV.DATA.DM` and `U_DEV.DATA.DP`, and each line also has an
ESD diode to ground. `C_VBUS` bypasses the USB VBUS rail.

Parse `404-usb-device-port.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 22-interface-recipes/404-usb-device-port.mc
```

Generate HTML for `404-usb-device-port.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 22-interface-recipes/404-usb-device-port.mc -o 22-interface-recipes/404-usb-device-port.html
```

## 405 RS485 UART Bridge

`405-rs485-uart-bridge.mc` describes a UART-to-RS485 bridge.

`MCU_UART` provides the controller-side TTL UART. `RS485_BRIDGE` represents a
small transceiver with a UART-side `UART.TTL` interface and bus-side `A`, `B`,
and `GND` pins. The MCU TX signal connects to the bridge RX-side input, while
the bridge TX-side output returns to MCU RX.
`RS485_A` and `RS485_B` leave through `J_BUS`, and `R_TERM` provides a simple
120 ohm termination across the differential pair.

Parse `405-rs485-uart-bridge.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode 22-interface-recipes/405-rs485-uart-bridge.mc
```

Generate HTML for `405-rs485-uart-bridge.mc`:

```bash
MCC_SYSTEM_ROOT="$(cd .. && pwd)" ../mcc/target/debug/mcc parse --lib mcode --viz 22-interface-recipes/405-rs485-uart-bridge.mc -o 22-interface-recipes/405-rs485-uart-bridge.html
```
