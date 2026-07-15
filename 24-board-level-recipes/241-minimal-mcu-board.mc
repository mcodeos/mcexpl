// Example: Minimal MCU Board
// Goal: Combine MCU power, decoupling, reset, and a small debug header.
// Library focus: DC, CAP.CER, RES, HDR.

component GENERIC_MCU
{
    name = "Generic MCU"
    pins = [
        ps 1 = VCC
        ps 2 = GND
        io 3 = RESET_N
        io 4 = DBG_IO
        io 5 = DBG_CLK
    ]
}

module main
{
    DC.SRC PWR(3.3V, 200mA)
    GENERIC_MCU U_MCU
    CAP.CER C_MCU(100nF, 10V)
    CAP.CER C_BULK(4.7uF, 10V)
    RES R_RESET(10000R, 50V)
    HDR_1x5 J_DEBUG

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> U_MCU.VCC
    U_MCU.GND -> GND

    V3V3 -> C_MCU -> GND
    V3V3 -> C_BULK -> GND

    V3V3 -> R_RESET -> RESET_N
    RESET_N -> U_MCU.RESET_N

    V3V3 -> J_DEBUG.1
    GND -> J_DEBUG.2
    RESET_N -> J_DEBUG.3
    U_MCU.DBG_IO -> DBG_IO
    DBG_IO -> J_DEBUG.4
    U_MCU.DBG_CLK -> DBG_CLK
    DBG_CLK -> J_DEBUG.5
}
