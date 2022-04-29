set_global_assignment -entity "QA_MainPLL" -library "lib_QA_MainPLL" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "QA_MainPLL" -library "lib_QA_MainPLL" -name IP_TOOL_VERSION "21.1"
set_global_assignment -entity "QA_MainPLL" -library "lib_QA_MainPLL" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_QA_MainPLL" -name SPD_FILE [file join $::quartus(sip_path) "QA_MainPLL.spd"]

set_global_assignment -library "lib_QA_MainPLL" -name MISC_FILE [file join $::quartus(sip_path) "QA_MainPLL_sim/QA_MainPLL.vo"]
