/* ----------------------------------------------------------------------- */
/*                                                                         */
/*   Quartz Arc                                                            */
/*                                                                         */
/*   8Bit CPU                                                              */
/*                                                                         */
/*   Terasic DE0-CV                                                        */
/*                                                                         */
/*   System: Core                                                          */
/*   Role: Top Level                                                       */
/*   Filename: QA_Main.v                                                   */
/*   Date: 29th April 2022                                                 */
/*   Created By: Benjamin Rosser                                           */
/*                                                                         */
/*   This code is covered by Creative Commons CC-BY-NC-SA license          */
/*   (C) Copyright 2021 Benjamin Rosser                                    */
/*                                                                         */
/* ----------------------------------------------------------------------- */

module (

	input              RESET_N,

	input              CLOCK_50,
	input              CLOCK2_50,
	input              CLOCK3_50,
	inout              CLOCK4_50,

	inout       [35:0] GPIO_0,
	inout       [35:0] GPIO_1,

	input       [3:0]  KEY,

	output      [9:0]  LEDR,

	input       [9:0]  SW,

	output      [6:0]  HEX0,
	output      [6:0]  HEX1,
	output      [6:0]  HEX2,
	output      [6:0]  HEX3,
	output      [6:0]  HEX4,
	output      [6:0]  HEX5,

	inout              PS2_CLK,
	inout              PS2_CLK2,
	inout              PS2_DAT,
	inout              PS2_DAT2,

	output      [3:0]  VGA_B,
	output      [3:0]  VGA_G,
	output             VGA_HS,
	output      [3:0]  VGA_R,
	output             VGA_VS,

	output             SD_CLK,
	inout              SD_CMD,
	inout       [3:0]  SD_DATA,

	output      [12:0] DRAM_ADDR,
	output      [1:0]  DRAM_BA,
	output             DRAM_CAS_N,
	output             DRAM_CKE,
	output             DRAM_CLK,
	output             DRAM_CS_N,
	inout       [15:0] DRAM_DQ,
	output             DRAM_LDQM,
	output             DRAM_RAS_N,
	output             DRAM_UDQM,
	output             DRAM_WE_N

);


  //---
  //RCC
	wire Clock50In     = CLOCK_50;
	wire ClockManualIn = KEY[0];
	wire ClockSelectIn = SW[0];
	wire ResetIn       = RESET_N;
	
  wire ClockMain;
	wire ResetMain;

  QA_RCC_Module QA_RCC(
	  Clock50In, 
		ClockManualIn, 
		ClockSelectIn, 
		ResetIn, 
		ClockMain, 
		ResetMain
	);

	
	//
	
	
	//--------------
	//7 Seg Displays
	wire [2:0] Disp_7Seg_Enable = 3'b111;
  wire [23:0] Disp_7Seg_Data   = {CPU_Debug_IR, CPU_Debug_BusMain, CPU_Debug_PC};
  wire [41:0] Disp_7Seg_Output;
	
	QA_7Seg_Module QA_7Seg(Disp_7Seg_Enable, Disp_7Seg_Data, Disp_7Seg_Output);

	assign HEX0 = Disp_7Seg_Output[6:0];
	assign HEX1 = Disp_7Seg_Output[13:7];
	assign HEX2 = Disp_7Seg_Output[20:14];
	assign HEX3 = Disp_7Seg_Output[27:21];
	assign HEX4 = Disp_7Seg_Output[34:28];
	assign HEX5 = Disp_7Seg_Output[41:35];

endmodule

