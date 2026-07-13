// Reference: Functions And Method Calls
// Focus: func parameters, this, return, and calling a component method.

component REF_LED
{
    name = "Reference LED"
    pins = [
        1 = ANODE
        2 = CATHODE
    ]

    func Light(signal, ground)
    {
        signal -> this -> ground
        return this
    }
}

module main
{
    REF_LED D_STATUS

    D_STATUS.Light(GPIO_STATUS, GND)
}
