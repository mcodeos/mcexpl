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
        recommended_current = 10mA
    }
    else if (package_style == "1206")
    {
        package = "1206"
        recommended_current = 20mA
    }
}

module main
{
    CONFIG_LED("0603") D_STATUS
}
