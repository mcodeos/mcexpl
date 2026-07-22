// Example: LED Package Variant
// Goal: Select attributes from a parameter value.
// Language focus: typed parameters, if, else if, conditional attributes.

component CONFIG_LED(package_style::STRING)
{
    name = "Configurable LED"
    pins = [
        1 = ANODE
        2 = CATHODE
    ]

    if (package_style == "0603")
    {
        package = "0603"
        description = "Compact status LED"
    }
    else if (package_style == "1206")
    {
        package = "1206"
        description = "Large status LED"
    }
}

module main
{
    DC.SRC PWR(3.3V, 20mA)
    CONFIG_LED("0603") D_SMALL
    CONFIG_LED("1206") D_LARGE
    RES R_SMALL(330R, 50V)
    RES R_LARGE(330R, 50V)

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> R_SMALL -> D_SMALL.ANODE
    D_SMALL.CATHODE -> GND
    V3V3 -> R_LARGE -> D_LARGE.ANODE
    D_LARGE.CATHODE -> GND
}
