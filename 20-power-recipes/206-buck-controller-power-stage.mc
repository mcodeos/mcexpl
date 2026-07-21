// Example: Buck Controller Power Stage
// Goal: Show the external power stage and feedback network of an asynchronous buck.
// Library focus: IND.POWER, DIO.SCH, RES, CAP, DC.

component BUCK_CONTROLLER(v_in::UV.VOLT, v_fb::UV.VOLT, f_sw::UV.HZ)
{
    name = "Buck Controller"
    spec = [
        input_voltage = v_in
        feedback_voltage = v_fb
        switching_frequency = f_sw
    ]
    pins = [
        ps 1 = VIN
        out 2 = SW
        in 3 = FB
        ps 4 = GND
    ]
}

module main
{
    DC.SRC PWR(12V, 2A)
    BUCK_CONTROLLER U_CTRL(12V, 1V, 500kHz)
    IND.POWER L_BUCK(10uH, 2A, 3A, 0.05R)
    DIO.SCH D_CATCH(0.4V, 40V, 3A)
    RES R_FB_TOP(40000R, 50V)
    RES R_FB_BOTTOM(10000R, 50V)
    CAP.CER C_IN(10uF, 25V)
    CAP.CER C_OUT(22uF, 10V)

    PWR.1 -> V12V
    PWR.2 -> GND

    V12V -> U_CTRL.VIN
    U_CTRL.GND -> GND
    U_CTRL.SW -> SW_NODE
    SW_NODE -> L_BUCK -> V5V

    GND -> D_CATCH.ANODE
    D_CATCH.CATHODE -> SW_NODE

    V5V -> R_FB_TOP -> FB_NODE
    FB_NODE -> R_FB_BOTTOM -> GND
    FB_NODE -> U_CTRL.FB

    V12V -> C_IN -> GND
    V5V -> C_OUT -> GND
}
