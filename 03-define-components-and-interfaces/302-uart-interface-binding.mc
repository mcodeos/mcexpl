// Example: UART Interface Binding
// Goal: Define a small component with a UART interface and connect it to a header.
// Language focus: pin ranges, interface binding, interface member access.

component MCU_UART
{
    name = "MCU with UART"
    pins = [
        // Pins 1 through 3 become UART0.TX, UART0.RX, and UART0.GND.
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

    // UART0 is the bound interface name; TX and RX are its members.
    U_MCU.UART0.TX -> J_DEBUG.1
    U_MCU.UART0.RX -> J_DEBUG.2
    GND -> J_DEBUG.3
}
