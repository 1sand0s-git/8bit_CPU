/* ----------------------------------------------------------------------- */
/*                                                                         */
/*   Quartz Arc                                                            */
/*                                                                         */
/*   8Bit CPU                                                              */
/*                                                                         */
/*   Terasic DE0-CV                                                        */
/*                                                                         */
/*   System: Core                                                          */
/*   Role: On-board 7 Segment Display Driver                               */
/*   Filename: QA_7Seg.v                                                   */
/*   Date: 29th April 2022                                                 */
/*   Created By: Benjamin Rosser                                           */
/*                                                                         */
/*   This code is covered by Creative Commons CC-BY-NC-SA license          */
/*   (C) Copyright 2021 Benjamin Rosser                                    */
/*                                                                         */
/* ----------------------------------------------------------------------- */

module QA_7Seg_ROM_Module (

  input [3:0] addr,
	output [6:0] data

);

  //ROM 
  reg [6:0] rom[15:0];
	
	initial
	begin
	  $readmemb("QA_7Seg_ROM.mem", rom);
	end
	
	assign data = rom[addr];


endmodule



module QA_7Seg_Module (
  input [2:0] enable,
	input [23:0] data,
	output [41:0] segments
);

  //Digit 0
	wire [6:0] seg0;
	QA_7Seg_ROM_Module QA_7Seg_0 (data[3:0], seg0);

  //Digit 1
	wire [6:0] seg1;
	QA_7Seg_ROM_Module QA_7Seg_1 (data[7:4], seg1);

  //Digit 2
	wire [6:0] seg2;
	QA_7Seg_ROM_Module QA_7Seg_2 (data[11:8], seg2);

  //Digit 3
	wire [6:0] seg3;
	QA_7Seg_ROM_Module QA_7Seg_3 (data[15:12], seg3);

  //Digit 4
	wire [6:0] seg4;
	QA_7Seg_ROM_Module QA_7Seg_4 (data[19:16], seg4);

  //Digit 5
	wire [6:0] seg5;
	QA_7Seg_ROM_Module QA_7Seg_5 (data[23:20], seg5);
	
	//Output
	wire [13:0] byte0Out = enable[0] ? {seg1, seg0} : 14'h0000;
	wire [13:0] byte1Out = enable[1] ? {seg3, seg2} : 14'h0000;
	wire [13:0] byte2Out = enable[2] ? {seg5, seg4} : 14'h0000;
	
	assign segments = ~{byte2Out, byte1Out, byte0Out};


endmodule

