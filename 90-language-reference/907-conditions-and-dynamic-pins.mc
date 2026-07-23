// Reference: Conditions And Dynamic Pins
// Focus: default parameters, if/else, conditional attributes, and pins +=.

component REF_VARIANT(partno::STRING = "BASE")
{
    name = "Reference Variant"
    pins = [
        io [1:2] = IO[0:1]
        ps 3 = GND
    ]

    if (partno == "WIDE")
    {
        pins += [
            io [4:5] = IO[2:3]
        ]
    }

    if (partno == "WIDE")
    {
        package = "5-pin"
    }
    else
    {
        package = "3-pin"
    }
}

module main
{
    REF_VARIANT         U_BASE
    REF_VARIANT("WIDE") U_WIDE

    BASE_IO0 -> U_BASE.IO0
    U_BASE.GND -> GND

    WIDE_IO0 -> U_WIDE.IO0
    // IO2 exists only when the WIDE condition appends pins 4 and 5.
    WIDE_IO2 -> U_WIDE.IO2
    U_WIDE.GND -> GND
}
