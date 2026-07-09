// Example: MCU UART Header Component
// Goal: Define a small component with a UART interface and connect it to a header.
// Language focus: component, attributes, pins, interface binding.

component MCU_UART
{
    name = "MCU with UART"
    pins = [
        io 1:3 = UART0::UART.TTL(DCE)
        ps 4 = VCC
        ps 5 = GND
    ]
}

module main
{
    DC.SRC PWR(3.3V, 100mA)
    MCU_UART U_MCU
    HDR_1x3 J_DEBUG

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> U_MCU.VCC
    U_MCU.GND -> GND
    U_MCU.UART0.GND -> GND

    U_MCU.UART0.TX -> J_DEBUG.1
    U_MCU.UART0.RX -> J_DEBUG.2
    GND -> J_DEBUG.3
}
