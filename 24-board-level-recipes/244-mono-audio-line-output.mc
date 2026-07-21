// Example: Mono Audio Line Output
// Goal: Buffer an already biased mono audio signal and expose an AC-coupled line output.
// Library focus: DC, Amplifier.BUFFER, CAP.CER, CAP.FILM, RES, AUDIO.RCA.
// AUDIO_IN must remain within the buffer supply range and already include any required DC bias.
// All ratings and values are illustrative; this recipe does not model analog performance.

module main
{
    DC.SRC PWR(5V, 100mA)
    Amplifier.BUFFER U_BUF(100000R, 10mA, 5V)
    CAP.CER C_DECOUPLE(100nF, 10V)
    CAP.FILM C_OUT(1uF, 10V)
    RES R_OUT_REF(100000R, 50V)
    AUDIO.RCA J_LINE_OUT

    PWR.1 -> V5V
    PWR.2 -> GND

    V5V -> U_BUF.DC.Vcc
    U_BUF.DC.Vee -> GND
    V5V -> C_DECOUPLE -> GND

    AUDIO_IN -> U_BUF.IN
    U_BUF.OUT -> C_OUT -> AUDIO_LINE_OUT
    AUDIO_LINE_OUT -> R_OUT_REF -> GND
    AUDIO_LINE_OUT -> J_LINE_OUT.Center
    J_LINE_OUT.Shield -> GND
}
