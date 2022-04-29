/* ----------------------------------------------------------------------- */
/*                                                                         */
/*   Quartz Arc                                                            */
/*                                                                         */
/*   8Bit CPU                                                              */
/*                                                                         */
/*   Terasic DE0-CV                                                        */
/*                                                                         */
/*   System: Core                                                          */
/*   Role: Reset & Clock Control                                           */
/*   Filename: QA_RCC.v                                                    */
/*   Date: 29th April 2022                                                 */
/*   Created By: Benjamin Rosser                                           */
/*                                                                         */
/*   This code is covered by Creative Commons CC-BY-NC-SA license          */
/*   (C) Copyright 2021 Benjamin Rosser                                    */
/*                                                                         */
/* ----------------------------------------------------------------------- */

module QA_RCC_Module (

  input Clock50,
	input ClockManual,
	input ClockSelect,
	input nReset,
	
	output ClockMain,
	output ResetMain

);


  wire Reset = ~nReset;
	
	wire Clock;
	wire Locked;
	
	QA_MainPLL ClockPLL(Clock50, Reset, Clock);
	
  reg [31:0] ClockCounter = 32'h00000000;
	
	always @ (posedge Clock or posedge Reset)
	begin
	
	  if (Reset)
		begin
		  ClockCounter <= 32'h00000000;
		end
		else
		begin
		  ClockCounter <= ClockCounter + 32'h00000001;
		end
	
	end
	
	assign ClockMain = ClockSelect ? ClockCounter[19] : ~ClockManual;
	assign ResetMain = Reset;
	

endmodule

