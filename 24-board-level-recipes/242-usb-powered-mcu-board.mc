// Example: USB-Powered MCU Board
// Goal: Build a power-only USB input, 3.3 V regulator, and generic MCU rail.
// Library focus: USB.MICRO_B, FUSE.PTC, DIO.TVS, REG.LDO, CAP.CER.

component GENERIC_MCU
{
    name = "Generic MCU"
    pins = [
        ps 1 = VCC
        ps 2 = GND
        io 3 = RESET_N
    ]
}

module main
{
    USB.MICRO_B J_USB
    FUSE.PTC F_USB(0.5A, 6V, 1A)
    DIO.TVS D_VBUS(6V, 12V, 600W)
    REG.LDO U_LDO(3.3V, 0.3A, 5V, 0.3V)
    CAP.CER C_VBUS(10uF, 10V)
    CAP.CER C_LDO_IN(1uF, 10V)
    CAP.CER C_LDO_OUT(1uF, 6.3V)
    CAP.CER C_MCU(100nF, 10V)
    RES R_RESET(10000R, 50V)
    GENERIC_MCU U_MCU

    J_USB.1 -> USB_VBUS_IN
    USB_VBUS_IN -> F_USB -> VBUS_5V
    J_USB.5 -> GND

    VBUS_5V -> D_VBUS.CATHODE
    D_VBUS.ANODE -> GND
    VBUS_5V -> C_VBUS -> GND

    VBUS_5V -> U_LDO.INPUT
    U_LDO.GND -> GND
    U_LDO.OUTPUT -> V3V3
    VBUS_5V -> C_LDO_IN -> GND
    V3V3 -> C_LDO_OUT -> GND

    V3V3 -> U_MCU.VCC
    U_MCU.GND -> GND
    V3V3 -> C_MCU -> GND

    V3V3 -> R_RESET -> RESET_N
    RESET_N -> U_MCU.RESET_N
}
