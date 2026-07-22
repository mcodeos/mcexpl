// Reference: Interface Binding And Roles
// Focus: binding a physical pin range to a named interface role.

component REF_UART_DEVICE
{
    name = "Reference UART Device"
    pins = [
        io 1:2 = UART0::UART.TTL(DCE)
        ps 3 = VCC
        ps 4 = GND
    ]
}

module main
{
    DC.SRC PWR(3.3V, 20mA)
    REF_UART_DEVICE U_DEV
    HDR_1x3 J_DEBUG

    PWR.1 -> V3V3
    PWR.2 -> GND
    V3V3 -> U_DEV.VCC
    U_DEV.GND -> GND

    U_DEV.UART0.TX -> J_DEBUG.1
    U_DEV.UART0.RX -> J_DEBUG.2
    GND -> J_DEBUG.3
}
