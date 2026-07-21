// Reference: Module Ports And Instantiation
// Focus: module parameters, module instances, and explicit port connections.

module STATUS_BLOCK(in signal, ps ground)
{
    RES R_LIMIT(330R, 50V)
    LED D_STATUS(2.0V, 5mA)

    signal -> R_LIMIT -> D_STATUS.ANODE
    D_STATUS.CATHODE -> ground
}

module main
{
    STATUS_BLOCK STATUS

    GPIO_STATUS -> STATUS.signal
    STATUS.ground -> GND
}
