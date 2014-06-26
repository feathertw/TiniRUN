`timescale 1ns/10ps

`include "../TiniSOC/soc.v"
`include "lib.v"

`define PERIOD 10
module testbench();
	reg clock;
	reg reset;
	reg do_system;

	soc SOC(
		.clock(clock),
		.reset(reset),
		.do_system(do_system)
	);

	always  #(`PERIOD/2) clock=~clock;

	//initial begin
	//	$dumpfile("testbench.vcd");
	//	$dumpvars;
	//end
	initial begin
		#0 	clock=0;
		#0	reset=1; do_system=0;
		#12	reset=0; do_system=1;
		$readmemb("mbin.prog",SOC.IM.mem_data);
	end

	`SET_UART_TX
	`SET_UART_RX

endmodule
