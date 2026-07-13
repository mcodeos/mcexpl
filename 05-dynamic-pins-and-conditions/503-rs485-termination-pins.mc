// Example: RS485 Termination Pins
// Goal: Add optional termination connection pins for a bus endpoint variant.
// Language focus: default parameter, if, pins +=.

component RS485_ENDPOINT(partno::STRING = "RS485_NODE")
{
    name = "RS485 Endpoint"
    pins = [
        io 1 = A
        io 2 = B
        ps 3 = GND
    ]

    if (partno == "RS485_TERM120")
    {
        pins += [
            io [4:5] = TERM[0:1]
        ]
    }
}

module main
{
    // Only the termination-ready part exposes TERM0 and TERM1.
    RS485_ENDPOINT                 U_NODE
    RS485_ENDPOINT("RS485_TERM120") U_END
}
