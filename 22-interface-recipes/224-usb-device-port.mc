// Example: USB Device Port
// Goal: Model a USB device connector and its signals.
// Library focus: USB, DIO.ESD, CAP, DC.

component USB_DEVICE
{
    name = "USB Device Controller"
    pins = [
        [1,2] = DATA{DM, DP}::USB.DATA(Peripheral)
        3 = VBUS
        4 = GND
    ]
}

module main
{
    USB.MICROB J_USB
    USB_DEVICE U_DEV
    DIO.ESD D_DM("USBLC6", "IEC61000-4-2")
    DIO.ESD D_DP("USBLC6", "IEC61000-4-2")
    CAP.CER C_VBUS(1uF, 10V)

    J_USB.1 -> VBUS_5V
    J_USB.5 -> GND

    VBUS_5V -> U_DEV.VBUS
    U_DEV.GND -> GND
    VBUS_5V -> C_VBUS -> GND

    J_USB.2 -> USB_DM
    J_USB.3 -> USB_DP
    USB_DM -> U_DEV.DATA.DM
    USB_DP -> U_DEV.DATA.DP

    USB_DM -> D_DM.INPUT
    USB_DP -> D_DP.INPUT
    D_DM.GND -> GND
    D_DP.GND -> GND
}
