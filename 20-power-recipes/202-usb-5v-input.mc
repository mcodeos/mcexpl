// Example: USB 5 V Input
// Goal: Use a USB connector as a 5 V power input.
// Library focus: USB.MICROB, FUSE.PTC, DIO.TVS, CAP.

module main
{
    USB.MICROB J_USB
    FUSE.PTC F_USB(0.5A, 6V, 1A)
    DIO.TVS D_VBUS(6V, 12V, 600W)
    CAP.CER C_VBUS(10uF, 10V)

    J_USB.1 -> F_USB -> VBUS_5V
    J_USB.5 -> GND
    VBUS_5V -> D_VBUS.CATHODE
    D_VBUS.ANODE -> GND
    VBUS_5V -> C_VBUS -> GND
}
