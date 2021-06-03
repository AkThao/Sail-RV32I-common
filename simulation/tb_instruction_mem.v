module top();
	reg[31:0]  addr;
	reg clk;
	wire[31:0] out;

	instruction_memory my_instr_mem(
		.addr(addr),
		.clk(clk),
		.out(out)
		);


	//simulation
	always
		#5 clk = ~clk;

	initial begin
		$dumpfile ("imm_record.vcd");
		$dumpvars;

		clk <= 0;
		for(addr = 0; addr < 100; addr = addr + 1) begin
			#100;
		end
		$finish;
	end

endmodule
