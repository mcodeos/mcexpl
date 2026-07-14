// Example: ADC Input RC Filter
// Goal: Add a simple low-pass filter before an ADC input node.
// Library focus: DC, RES, CAP.CER.

module main
{
    DC.SRC ADC_REF(3.3V, 1mA)
    RES R_FILTER(1000R, 50V)
    CAP.CER C_FILTER(10nF, 16V)

    ADC_REF.1 -> V3V3
    ADC_REF.2 -> GND

    SENSOR_RAW -> R_FILTER -> ADC_IN
    ADC_IN -> C_FILTER -> GND
}
