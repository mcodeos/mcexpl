// Reference: Module Ports
// Focus: module parameters with IO direction markers.

module main(in signal, ps ground)
{
    RES R_LIMIT(330R, 50V)
    LED D_STATUS(2.0V, 5mA)

    signal -> R_LIMIT -> D_STATUS.ANODE
    D_STATUS.CATHODE -> ground
}
