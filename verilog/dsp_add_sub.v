/*
	Authored 2019, Sebastian Venter.

	All rights reserved.
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions
	are met:

	*	Redistributions of source code must retain the above
		copyright notice, this list of conditions and the following
		disclaimer.

	*	Redistributions in binary form must reproduce the above
		copyright notice, this list of conditions and the following
		disclaimer in the documentation and/or other materials
		provided with the distribution.

	*	Neither the name of the author nor the names of its
		contributors may be used to endorse or promote products
		derived from this software without specific prior written
		permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
	FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
	COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
	LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
	ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
	POSSIBILITY OF SUCH DAMAGE.
*/


module dsp_add_sub(input1, input2, sub, out);
	input [31:0] input1;
	input [31:0] input2;
	input sub;

	output [31:0] out;
	
	reg CONST_1 = 1'b1;
	reg CONST_0 = 1'b0;

	SB_MAC16 i_sbmac16(
		.A(input2[31:16]),
		.B(input2[15:0]),
		.C(input1[31:16]),
		.D(input1[15:0]),
		.O(out),

		// the adder is asynchronous so the clock doesn't matter
		.CLK(CONST_1),
		.CE(CONST_0),

		// hold all reset lines low
		.IRSTTOP(CONST_0),
		.IRSTBOT(CONST_0),
		.ORSTTOP(CONST_0),
		.ORSTBOT(CONST_0),

		// the inputs are unregistered so these shoudn't matter
		.AHOLD(CONST_1),
		.BHOLD(CONST_1),
		.CHOLD(CONST_1),
		.DHOLD(CONST_1),
		.OHOLDTOP(CONST_1),
		.OHOLDBOT(CONST_1),
		
		// we're not using the accumulator so these shouldn't matter
		.OLOADTOP(CONST_0),
		.OLOADBOT(CONST_0),
		
		// 0-adder, 1-subtractor
		.ADDSUBTOP(sub),
		.ADDSUBBOT(sub),
		
		// cascaded carry to other DSP blocks
		.CO(),
		.CI(CONST_0),
		
		// cascaded accumulator carry
		.ACCUMCI(),
		.ACCUMCO(),
		
		// sign extension input/output for other DSP blocks
		.SIGNEXTIN(),
		.SIGNEXTOUT()
	);

	defparam i_sbmac16.NEG_TRIGGER = 1'b0;
	defparam i_sbmac16.C_REG = 1'b0;
	defparam i_sbmac16.A_REG = 1'b0;
	defparam i_sbmac16.B_REG = 1'b0;
	defparam i_sbmac16.D_REG = 1'b0;
	defparam i_sbmac16.TOP_8x8_MULT_REG = 1'b0;
	defparam i_sbmac16.BOT_8x8_MULT_REG = 1'b0;
	defparam i_sbmac16.PIPELINE_16x16_MULT_REG1 = 1'b0;
	defparam i_sbmac16.PIPELINE_16x16_MULT_REG2 = 1'b0;
	defparam i_sbmac16.TOPOUTPUT_SELECT = 2'b0;
	defparam i_sbmac16.TOPADDSUB_LOWERINPUT = 2'b0;
	defparam i_sbmac16.TOPADDSUB_UPPERINPUT = 1'b1;
	defparam i_sbmac16.TOPADDSUB_CARRYSELECT = 2'b10;
	defparam i_sbmac16.BOTOUTPUT_SELECT = 2'b00;
	defparam i_sbmac16.BOTADDSUB_LOWERINPUT = 2'b00;
	defparam i_sbmac16.BOTADDSUB_UPPERINPUT = 1'b1;
	// bottom of the adder, carry nothing in
	defparam i_sbmac16.BOTADDSUB_CARRYSELECT = 2'b00;
	defparam i_sbmac16.MODE_8x8 = 1'b1;
	// unsigned adder
	defparam i_sbmac16.A_SIGNED = 1'b0;
	defparam i_sbmac16.B_SIGNED = 1'b0;
endmodule
