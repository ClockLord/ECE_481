set_property SRC_FILE_INFO {cfile:C:/Users/sucit/Downloads/NexysA7.xdc rfile:../../../../../../../../../../Downloads/NexysA7.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:4 export:INPUT save:INPUT read:READ} [current_design]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]
