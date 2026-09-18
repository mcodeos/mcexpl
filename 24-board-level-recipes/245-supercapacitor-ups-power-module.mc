// Example: Photo-Grounded Supercapacitor UPS Power Module
// Goal: Model a 9-24 V input, a 5 V primary path, and short-duration supercapacitor backup.
// Evidence boundary: Visible parts are explicit; unreadable controller ICs remain generic.

component BOARD_POWER_CONNECTOR(volt::UV.VOLT)
{
    name = "Two-Pin Board Power Connector"
    description = "Two-pin connector for a board power rail and ground"
    voltage = volt
    pins = [
        1 = POSITIVE
        2 = GND
    ]
}

component SUPERCAPACITOR(cap::UV.CAP, volt::UV.VOLT)
{
    name = "Supercapacitor"
    description = "Polarized supercapacitor energy-storage element"
    voltage = volt
    spec = [
        capacitance = cap
        rated_voltage = volt
    ]
    pins = [
        1 = POSITIVE
        2 = NEGATIVE
    ]
}

component DNP_SUPERCAPACITOR_FOOTPRINT
{
    name = "Unpopulated Supercapacitor Footprint"
    description = "PCB footprint present in the two-capacitor SKU but not electrically populated"
    package = "DNP radial supercapacitor footprint"
    pins = [
        1 = POSITIVE_PAD
        2 = NEGATIVE_PAD
    ]
}

component POWER_INDUCTOR_MARKED(marking::STRING, nominal_inductance::UV.IND)
{
    name = "Marked Power Inductor " + marking
    description = "Power inductor whose top marking is visible in the product photograph"
    spec = [
        top_marking = marking
        nominal_inductance = nominal_inductance
    ]
    pins = [
        1 = PIN1
        2 = PIN2
    ]
}

component INPUT_PROTECTION_STAGE(v_in::UV.VOLT, i_out::UV.AMP)
{
    name = "Input Polarity Protection Stage"
    description = "Generic input protection stage; exact diode or MOSFET implementation is unknown"
    voltage = v_in
    spec = [
        maximum_input_voltage = v_in
        rated_output_current = i_out
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}

component WIDE_INPUT_POWER_CONTROLLER(i_out::UV.AMP, v_in::UV.VOLT)
{
    name = "Wide-Input Primary Power Controller"
    description = "Generic switching controller for the photographed 100-marked primary inductor"
    voltage = v_in
    spec = [
        rated_output_current = i_out
        maximum_input_voltage = v_in
    ]
    pins = [
        psnk 1 = INPUT
        psbi 2 = SWITCH
        in 3 = SENSE
        psnk 4 = GND
    ]
}

component TWO_CELL_SUPERCAP_CHARGER(v_cap::UV.VOLT)
{
    name = "Two-Cell Supercapacitor Charger and Balancer"
    description = "Generic current-limited charger with midpoint balancing for two series cells"
    voltage = v_cap
    spec = [
        bank_charge_voltage = v_cap
    ]
    pins = [
        psnk 1 = INPUT
        psrc 2 = CAP_TOP
        psbi 3 = CAP_MID
        psnk 4 = GND
    ]
}

component BACKUP_BOOST_CONTROLLER(v_out::UV.VOLT, i_out::UV.AMP, v_cap::UV.VOLT)
{
    name = "Supercapacitor Backup Boost Controller"
    description = "Generic controller for the photographed 1R0-marked backup inductor"
    voltage = v_out
    spec = [
        output_voltage = v_out
        output_current = i_out
        maximum_capacitor_voltage = v_cap
    ]
    pins = [
        psnk 1 = CAP
        psbi 2 = SWITCH
        in 3 = SENSE
        in 4 = ENABLE
        psnk 5 = GND
    ]
}

component PRIMARY_OUTPUT_SWITCH(v_out::UV.VOLT, i_out::UV.AMP)
{
    name = "Primary Output Power Switch"
    description = "Generic high-side primary path; it is not an assumed ideal power multiplexer"
    voltage = v_out
    spec = [
        output_voltage = v_out
        output_current = i_out
    ]
    pins = [
        psnk 1 = INPUT
        psrc 2 = OUTPUT
        in 3 = ENABLE
        psnk 4 = GND
    ]
}

component POWER_FAIL_DETECTOR(signal_high::UV.VOLT)
{
    name = "Input Power-Fail Detector"
    description = "Generic detector that reports whether external input power is present"
    voltage = signal_high
    spec = [
        signal_high_voltage = signal_high
    ]
    pins = [
        in 1 = SENSE
        out 2 = POWER_GOOD
        out 3 = BACKUP_ENABLE
        psnk 4 = GND
    ]
}

module INPUT_FRONT_END(psrc PRIMARY_INTERMEDIATE, out POWER_GOOD_3V, out BACKUP_ENABLE, psnk GND)
{
    io DC_INPUT_RAW
    io PRIMARY_SWITCH_NODE
    io VIN_PROTECTED

    BOARD_POWER_CONNECTOR J_DC_JACK(24V)
    BOARD_POWER_CONNECTOR J_DC_TERMINAL(24V)
    INPUT_PROTECTION_STAGE U_INPUT_PROTECTION(24V, 3A)
    WIDE_INPUT_POWER_CONTROLLER U_PRIMARY(3A, 24V)
    POWER_INDUCTOR_MARKED L_PRIMARY("100", 10uH)
    POWER_FAIL_DETECTOR U_POWER_FAIL(3V)
    CAP.ELEC C_INPUT(100uF, 35V)
    RES R_DC_IN_LED(2200R, 50V)
    LED D_DC_IN(2.0V, 5mA)

    J_DC_JACK.POSITIVE -> DC_INPUT_RAW
    J_DC_TERMINAL.POSITIVE -> DC_INPUT_RAW
    J_DC_JACK.GND -> GND
    J_DC_TERMINAL.GND -> GND

    DC_INPUT_RAW -> U_INPUT_PROTECTION.INPUT
    U_INPUT_PROTECTION.GND -> GND
    U_INPUT_PROTECTION.OUTPUT -> VIN_PROTECTED
    VIN_PROTECTED -> C_INPUT -> GND

    VIN_PROTECTED -> U_PRIMARY.INPUT
    U_PRIMARY.GND -> GND
    U_PRIMARY.SWITCH -> PRIMARY_SWITCH_NODE
    PRIMARY_SWITCH_NODE -> L_PRIMARY -> PRIMARY_INTERMEDIATE
    PRIMARY_INTERMEDIATE -> U_PRIMARY.SENSE

    PRIMARY_INTERMEDIATE -> U_POWER_FAIL.SENSE
    U_POWER_FAIL.GND -> GND
    U_POWER_FAIL.POWER_GOOD -> POWER_GOOD_3V
    U_POWER_FAIL.BACKUP_ENABLE -> BACKUP_ENABLE

    VIN_PROTECTED -> R_DC_IN_LED -> D_DC_IN.ANODE
    D_DC_IN.CATHODE -> GND
}

module SUPERCAP_STORAGE(psnk PRIMARY_INTERMEDIATE, psbi VCAP_TOP, psnk GND)
{
    io VCAP_MID
    TWO_CELL_SUPERCAP_CHARGER U_CHARGER(5.4V)
    // Working assumption: two 50 F cells in series form a 25 F bank; verify the cell markings.
    SUPERCAPACITOR C_SC1(50F, 2.7V)
    SUPERCAPACITOR C_SC2(50F, 2.7V)
    DNP_SUPERCAPACITOR_FOOTPRINT FP_SC3_DNP
    DNP_SUPERCAPACITOR_FOOTPRINT FP_SC4_DNP
    RES R_VCAP_LED(1000R, 50V)
    LED D_VCAP(2.0V, 5mA)

    PRIMARY_INTERMEDIATE -> U_CHARGER.INPUT
    U_CHARGER.GND -> GND
    U_CHARGER.CAP_TOP -> VCAP_TOP
    U_CHARGER.CAP_MID -> VCAP_MID

    VCAP_TOP -> C_SC1.POSITIVE
    C_SC1.NEGATIVE -> VCAP_MID
    VCAP_MID -> C_SC2.POSITIVE
    C_SC2.NEGATIVE -> GND

    VCAP_TOP -> FP_SC3_DNP.POSITIVE_PAD
    FP_SC3_DNP.NEGATIVE_PAD -> VCAP_MID
    VCAP_MID -> FP_SC4_DNP.POSITIVE_PAD
    FP_SC4_DNP.NEGATIVE_PAD -> GND

    VCAP_TOP -> R_VCAP_LED -> D_VCAP.ANODE
    D_VCAP.CATHODE -> GND
}

module PRIMARY_OUTPUT_PATH(psnk PRIMARY_INTERMEDIATE, in ENABLE, psrc V5V_OUT, psnk GND)
{
    PRIMARY_OUTPUT_SWITCH U_PRIMARY_PATH(5V, 3A)

    PRIMARY_INTERMEDIATE -> U_PRIMARY_PATH.INPUT
    ENABLE -> U_PRIMARY_PATH.ENABLE
    U_PRIMARY_PATH.GND -> GND
    U_PRIMARY_PATH.OUTPUT -> V5V_OUT
}

module BACKUP_BOOST_PATH(psnk VCAP_TOP, in ENABLE, psrc V5V_OUT, psnk GND)
{
    io BACKUP_SWITCH_NODE

    BACKUP_BOOST_CONTROLLER U_BACKUP(5V, 3A, 5.4V)
    POWER_INDUCTOR_MARKED L_BACKUP("1R0", 1uH)
    DIO.SCH D_BACKUP_OUT(0.35V, 30V, 5A)

    VCAP_TOP -> U_BACKUP.CAP
    U_BACKUP.GND -> GND
    ENABLE -> U_BACKUP.ENABLE
    VCAP_TOP -> L_BACKUP -> BACKUP_SWITCH_NODE
    BACKUP_SWITCH_NODE -> U_BACKUP.SWITCH
    BACKUP_SWITCH_NODE -> D_BACKUP_OUT.ANODE
    D_BACKUP_OUT.CATHODE -> V5V_OUT
    V5V_OUT -> U_BACKUP.SENSE
}

module OUTPUT_INTERFACES(psnk V5V_OUT, psnk GND)
{
    BOARD_POWER_CONNECTOR J_5V_TERMINAL(5V)
    USB.TYPEA J_USB_OUT
    CAP.ELEC C_OUTPUT(470uF, 10V)
    RES R_5V_OUT_LED(1000R, 50V)
    LED D_5V_OUT(2.0V, 5mA)

    V5V_OUT -> C_OUTPUT -> GND
    V5V_OUT -> J_USB_OUT.1
    J_USB_OUT.4 -> GND
    V5V_OUT -> J_5V_TERMINAL.POSITIVE
    J_5V_TERMINAL.GND -> GND

    V5V_OUT -> R_5V_OUT_LED -> D_5V_OUT.ANODE
    D_5V_OUT.CATHODE -> GND
}

module POWER_FAIL_INTERFACE(in POWER_GOOD_3V, psnk GND)
{
    BOARD_POWER_CONNECTOR J_POWER_FAIL(3V)

    POWER_GOOD_3V -> J_POWER_FAIL.POSITIVE
    J_POWER_FAIL.GND -> GND
}

module main
{
    io BACKUP_ENABLE
    io GND
    io POWER_GOOD_3V
    io PRIMARY_INTERMEDIATE
    io V5V_OUT
    io VCAP_TOP

    INPUT_FRONT_END INPUT
    SUPERCAP_STORAGE STORAGE
    PRIMARY_OUTPUT_PATH PRIMARY_PATH
    BACKUP_BOOST_PATH BACKUP_PATH
    OUTPUT_INTERFACES OUTPUTS
    POWER_FAIL_INTERFACE POWER_FAIL

    INPUT.PRIMARY_INTERMEDIATE -> PRIMARY_INTERMEDIATE
    PRIMARY_INTERMEDIATE -> STORAGE.PRIMARY_INTERMEDIATE
    PRIMARY_INTERMEDIATE -> PRIMARY_PATH.PRIMARY_INTERMEDIATE

    INPUT.POWER_GOOD_3V -> POWER_GOOD_3V
    POWER_GOOD_3V -> PRIMARY_PATH.ENABLE
    POWER_GOOD_3V -> POWER_FAIL.POWER_GOOD_3V

    INPUT.BACKUP_ENABLE -> BACKUP_ENABLE
    BACKUP_ENABLE -> BACKUP_PATH.ENABLE

    STORAGE.VCAP_TOP -> VCAP_TOP
    VCAP_TOP -> BACKUP_PATH.VCAP_TOP

    PRIMARY_PATH.V5V_OUT -> V5V_OUT
    BACKUP_PATH.V5V_OUT -> V5V_OUT
    V5V_OUT -> OUTPUTS.V5V_OUT

    INPUT.GND -> GND
    STORAGE.GND -> GND
    PRIMARY_PATH.GND -> GND
    BACKUP_PATH.GND -> GND
    OUTPUTS.GND -> GND
    POWER_FAIL.GND -> GND
}
