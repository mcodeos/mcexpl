// Example: GPIO Expander Pins
// Goal: Add more pins for a larger device variant.
// Language focus: if, pins +=, pin ranges.

component GPIO_EXPANDER(partno::STRING = "GPIO8")
{
    name = "GPIO Expander"
    pins = [
        io [1:8] = GPIO[0:7]
        ps 9 = VCC
        ps 10 = GND
    ]

    if (partno == "GPIO16")
    {
        pins += [
            io [11:18] = GPIO[8:15]
        ]
    }
}

module main
{
    DC.SRC PWR(3.3V, 100mA)
    GPIO_EXPANDER            U_SMALL
    GPIO_EXPANDER("GPIO16") U_LARGE

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> U_SMALL.VCC
    U_SMALL.GND -> GND
    SMALL_GPIO0 -> U_SMALL.GPIO0

    V3V3 -> U_LARGE.VCC
    U_LARGE.GND -> GND
    LARGE_GPIO0 -> U_LARGE.GPIO0
    // GPIO8 exists only on the GPIO16 variant.
    LARGE_GPIO8 -> U_LARGE.GPIO8
}
