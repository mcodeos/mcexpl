// Reference: Functions And Method Calls
// Focus: func parameters, this, return, and calling a component method.

component REF_LED
{
    name = "Reference LED"
    pins = [
        1 = ANODE
        2 = CATHODE
    ]

    func Light(signal, resistor, ground)
    {
        signal -> resistor -> this -> ground
        return this
    }
}

module main
{
    REF_LED D_STATUS
    RES R_LIMIT(330R, 50V)

    D_STATUS.Light(GPIO_STATUS, R_LIMIT, GND)
}
