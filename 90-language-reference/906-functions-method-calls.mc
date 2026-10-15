// Reference: Functions And Method Calls
// Focus: func parameters, this, return, and calling a component method.

component REF_LED
{
    name = "Reference LED"
    pins = [
        io [1, 2] = DIO{A, K}   // A = anode, K = cathode (DIO face adoption)
    ]

    func ConnectAnode(signal)
    {
        signal -> this.A
        return this
    }

    func ConnectCathode(ground)
    {
        this.K -> ground
    }
}

module main
{
    io GND
    io GPIO_STATUS

    REF_LED D_STATUS
    RES R_LIMIT(330R, 50V)

    GPIO_STATUS -> R_LIMIT.1
    D_STATUS.ConnectAnode(R_LIMIT.2).ConnectCathode(GND)
}
