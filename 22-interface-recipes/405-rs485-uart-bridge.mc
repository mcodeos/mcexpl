// Example: RS485 UART Bridge
// Goal: Bridge UART signals to an RS485 transceiver.
// Library focus: UART, RS485, RES, DC.

component MCU_UART
{
    name = "MCU with UART"
    pins = [
        io 1:3 = UART0::UART.TTL(DCE)
        4 = VCC
        5 = GND
    ]
}

component RS485_BRIDGE
{
    name = "UART to RS485 Bridge"
    pins = [
        io 1:3 = UART0::UART.TTL(DTE)
        io 4:6 = BUS::UART.RS485(Master)
        7 = VCC
        8 = GND
        9 = DE
        10 = RE_N
    ]
}

module main
{
    DC.SRC PWR(5V, 200mA)
    MCU_UART U_MCU
    RS485_BRIDGE U_RS485
    HDR_1x3 J_BUS
    RES R_TERM(120R, 50V)

    PWR.1 -> V5V
    PWR.2 -> GND

    V5V -> U_RS485.VCC
    U_RS485.GND -> GND
    U_MCU.VCC -> V5V
    U_MCU.GND -> GND
    U_MCU.UART0.GND -> GND
    U_RS485.UART0.GND -> GND

    U_MCU.UART0.TX -> U_RS485.UART0.RX
    U_RS485.UART0.TX -> U_MCU.UART0.RX
    U_RS485.DE -> TX_ENABLE
    U_RS485.RE_N -> RX_ENABLE_N

    U_RS485.BUS.A -> RS485_A
    U_RS485.BUS.B -> RS485_B
    U_RS485.BUS.GND -> GND
    RS485_A -> R_TERM -> RS485_B

    RS485_A -> J_BUS.1
    RS485_B -> J_BUS.2
    GND -> J_BUS.3
}
