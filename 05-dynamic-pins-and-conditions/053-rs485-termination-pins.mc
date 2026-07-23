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
    RS485_ENDPOINT                 U_NODE
    RS485_ENDPOINT("RS485_TERM120") U_END
    RES R_TERM(120R, 50V)

    BUS_A -> U_NODE.A
    BUS_B -> U_NODE.B
    U_NODE.GND -> GND

    BUS_A -> U_END.A
    BUS_B -> U_END.B
    // The termination path uses pins that exist only on the terminated variant.
    BUS_A -> U_END.TERM0 -> R_TERM -> U_END.TERM1 -> BUS_B
    U_END.GND -> GND
}
