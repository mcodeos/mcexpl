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
    // U_SMALL uses the default eight-pin variant.
    GPIO_EXPANDER            U_SMALL
    GPIO_EXPANDER("GPIO16") U_LARGE
}
