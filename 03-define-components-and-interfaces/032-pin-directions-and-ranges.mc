// Example: Pin Directions And Ranges
// Goal: Describe simple input, output, bidirectional, and power pins.
// Language focus: in, out, io, ps, physical pin ranges, indexed pin names.

component SIMPLE_IO_DEVICE
{
    name = "Simple I/O Device"
    pins = [
        in 1 = ENABLE
        out 2 = READY
        io [3:4] = GPIO[1:2]
        ps 5 = VCC
        ps 6 = GND
    ]
}

module main
{
    DC.SRC PWR(3.3V, 20mA)
    SIMPLE_IO_DEVICE U_IO

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> U_IO.VCC
    U_IO.GND -> GND

    ENABLE -> U_IO.ENABLE
    U_IO.READY -> READY
    GPIO1 -> U_IO.GPIO1
    U_IO.GPIO2 -> GPIO2
}
