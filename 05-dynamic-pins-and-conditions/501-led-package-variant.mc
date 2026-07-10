// Example: LED Package Variant
// Goal: Select attributes from a parameter value.
// Language focus: default parameters, if, else if, conditional attributes.

component CONFIG_LED(package_style::STRING = "0603")
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
    // Omitting the argument selects the default 0603 branch.
    CONFIG_LED D_STATUS
}
