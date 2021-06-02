module top();
        reg[31:0]  inst;
        wire[31:0] imm;

        imm_gen my_imm_gen(
                .inst(inst[31:2]),
                .imm(imm)
        );


//simulation

initial begin
        $dumpfile ("imm_record.vcd");
        $dumpvars;


        inst = 32'b11111111111100000000000000010011;

        #5

        inst = 32'b00000000000011111000111110010011;

        #5

        inst = 32'b11111110000000000000111111100011;

        #5

        inst = 32'b00000001111111111111000001100011;

        #5

        inst = 32'b11111110000000000110111111100011;

        #5

        inst = 32'b11010101010001010101000001101111;

        #5

        inst = 32'b11111110000000000000111110100011;

        #5

        inst = 32'b10101011111010101010010100100011;

        #5

        $finish;
end

endmodule
