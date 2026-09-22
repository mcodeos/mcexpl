// Example: USB Device Port
// Goal: Model a USB device connector and its signals.
// Library focus: USB, DIO.ESD, CAP, DC.

component USB_DEVICE
{
    name = "USB Device Controller"
    pins = [
        // USB.DATA b3810 face: first lane positive (1=D+, 2=D-)
        [1,2] = DATA{DP, DM}::USB.DATA(Device)
        3 = VBUS
        4 = GND
    ]
}

module main
{
    io GND
    io USB_DM
    io USB_DP
    io VBUS_5V

    USB.SOCK_MICROB J_USB
    USB_DEVICE U_DEV
    DIO.ESD D_DM(5V)    // partno "USBLC6" is BOM metadata; only core electrical formals are constructor params
    DIO.ESD D_DP(5V)
    CAP.MLCC C_VBUS(1uF, 10V)

    J_USB.1 -> VBUS_5V
    J_USB.5 -> GND

    VBUS_5V -> U_DEV.VBUS
    U_DEV.GND -> GND
    VBUS_5V -> C_VBUS -> GND

    J_USB.2 -> USB_DM
    J_USB.3 -> USB_DP
    USB_DM -> U_DEV.DATA.DM
    USB_DP -> U_DEV.DATA.DP

    USB_DM -> D_DM.CATHODE
    USB_DP -> D_DP.CATHODE
    D_DM.ANODE -> GND
    D_DP.ANODE -> GND
}
