// Example: SPI Flash
// Goal: Connect an SPI controller to a flash memory device.
// Library focus: SPI, DC.

component MCU_SPI
{
    name = "MCU with SPI"
    pins = [
        io 1:4 = SPI0::SPI(Master)
        5 = VCC
        6 = GND
    ]
}

component FLASH_SPI
{
    name = "SPI Flash"
    pins = [
        io 1:4 = SPI0::SPI(Slave)
        5 = VCC
        6 = GND
    ]
}

module main
{
    DC.SRC PWR(3.3V, 100mA)
    MCU_SPI U_MCU
    FLASH_SPI U_FLASH

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> U_MCU.VCC
    V3V3 -> U_FLASH.VCC
    U_MCU.GND -> GND
    U_FLASH.GND -> GND

    U_MCU.SPI0.CS -> U_FLASH.SPI0.CS
    U_MCU.SPI0.SCLK -> U_FLASH.SPI0.SCLK
    U_MCU.SPI0.MOSI -> U_FLASH.SPI0.MOSI
    U_FLASH.SPI0.MISO -> U_MCU.SPI0.MISO
}
