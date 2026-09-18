// Example: ADC Input RC Filter
// Goal: Add a simple low-pass filter before an ADC input node.
// Library focus: RES, CAP.MLCC.

module main
{
    io ADC_IN
    io GND
    io SENSOR_RAW

    RES R_FILTER(1000R, 50V)
    CAP.MLCC C_FILTER(10nF, 16V)

    SENSOR_RAW -> R_FILTER -> ADC_IN
    ADC_IN -> C_FILTER -> GND
}
