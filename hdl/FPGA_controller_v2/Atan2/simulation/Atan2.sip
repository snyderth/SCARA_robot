set_global_assignment -entity "Atan2" -library "lib_Atan2" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "Atan2" -library "lib_Atan2" -name IP_TOOL_VERSION "19.1"
set_global_assignment -entity "Atan2" -library "lib_Atan2" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_Atan2" -name SPD_FILE [file join $::quartus(sip_path) "../Atan2.spd"]
set_global_assignment -library "lib_Atan2" -name MISC_FILE [file join $::quartus(sip_path) "../../Atan2.qsys"]

set_global_assignment -library "lib_Atan2" -name MISC_FILE [file join $::quartus(sip_path) "Atan2.v"]
set_global_assignment -library "lib_Atan2" -name MISC_FILE [file join $::quartus(sip_path) "submodules/dspba_library_package.vhd"]
set_global_assignment -library "lib_Atan2" -name MISC_FILE [file join $::quartus(sip_path) "submodules/dspba_library.vhd"]
set_global_assignment -library "lib_Atan2" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Atan2_CORDIC_0.vhd"]
