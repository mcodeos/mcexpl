// Example: RS485 Termination Option
// Goal: Add optional termination pins for a bus endpoint variant.
// Language focus: if, pins +=, conditional attributes.

component RS485_ENDPOINT(termination::STRING = "none")
{
    name = "RS485 Endpoint"
    pins = [
        io 1 = A
        io 2 = B
        ps 3 = GND
    ]

    if (termination == "120R")
    {
        termination_value = 120R
        pins += [
            4 = TERM_A
            5 = TERM_B
        ]
    }
}

module main
{
    RS485_ENDPOINT("none") U_NODE
    RS485_ENDPOINT("120R") U_END
}
