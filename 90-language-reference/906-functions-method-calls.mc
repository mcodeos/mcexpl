// Reference: Functions And Method Calls
// Focus: func parameters, this, return, and calling a component method.

component REF_LED
{
    name = "Reference LED"
    pins = [
        1 = ANODE
        2 = CATHODE
    ]

    func ConnectAnode(signal)
    {
        signal -> ANODE
        return this
    }

    func ConnectCathode(ground)
    {
        CATHODE -> ground
    }
}

module main
{
    REF_LED D_STATUS
    RES R_LIMIT(330R, 50V)

    GPIO_STATUS -> R_LIMIT.1
    D_STATUS.ConnectAnode(R_LIMIT.2).ConnectCathode(GND)
}
