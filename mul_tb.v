`timescale 1ns/1ps
module mul_tb();
	//parameter DATA_WID = 2;
	reg[3:0] a,b;
	wire[7:0] out;
	reg enable;
	wire overflow;

	initial begin
		$dumpvars(0,mul_tb);
		a <= 4'd0;
		b <= 4'd0;
		enable = 0;
		#20
		enable = 1;
		#20
		a <= 4'd2;
		b <= 4'd4;
		#20
		a <= 4'd1;
		b <= 4'd10;
		#20
		$stop;
	end
	mul#(4) DUT(.a(a),.b(b),.enable(enable),.out(out),.overflow(overflow));
endmodule
