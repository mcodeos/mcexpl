// Example: Reusable LED Module
// Goal: Define a circuit block with ports and instantiate it twice.
// Language focus: module ports, module instances, explicit port connections.

module LED_INDICATOR(in signal, ps ground)
{
    RES R_LIMIT(330R, 50V)
    LED D_STATUS(2.0V, 5mA)

    signal -> R_LIMIT -> D_STATUS.ANODE
    D_STATUS.CATHODE -> ground
}

module main
{
    LED_INDICATOR STATUS_GREEN
    LED_INDICATOR STATUS_RED

    GPIO_GREEN -> STATUS_GREEN.signal
    STATUS_GREEN.ground -> GND
    GPIO_RED -> STATUS_RED.signal
    STATUS_RED.ground -> GND
}
