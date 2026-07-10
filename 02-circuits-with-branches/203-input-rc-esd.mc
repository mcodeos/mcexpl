// Example: Input RC ESD
// Goal: Share one protected input node between a filter capacitor and ESD diode.
// Library focus: RES, CAP, DIO.ESD.

module main
{
    RES R_INPUT(100R, 50V)
    CAP.CER C_FILTER(1nF, 16V)
    DIO.ESD D_ESD("USBLC6", "IEC61000-4-2")

    INPUT_EXT -> R_INPUT -> ADC_IN
    // Both protection parts begin at the same ADC_IN node.
    ADC_IN -> C_FILTER -> GND
    ADC_IN -> D_ESD.INPUT
    D_ESD.GND -> GND
}
