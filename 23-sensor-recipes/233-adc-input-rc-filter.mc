// Example: ADC Input RC Filter
// Goal: Add a simple low-pass filter before an ADC input node.
// Library focus: RES, CAP.CER.

module main
{
    RES R_FILTER(1000R, 50V)
    CAP.CER C_FILTER(10nF, 16V)

    SENSOR_RAW -> R_FILTER -> ADC_IN
    ADC_IN -> C_FILTER -> GND
}
