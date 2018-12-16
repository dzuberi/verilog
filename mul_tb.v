`timescale 1ns/1ps
module mul_tb();
	parameter DATA_WID = 8;
	reg[DATA_WID - 1:0] a,b;
	wire[DATA_WID - 1:0] outlo;
	wire [DATA_WID - 1:0] outhi;
	reg enable;
	wire overflow;

	initial begin
		$dumpvars(0,DUT);
		a <= {{(DATA_WID - 4){1'b0}}, 4'd0};
		b <= {{(DATA_WID - 4){1'b0}}, 4'd0};
		enable = 0;
		#20
		enable = 1;
		#20
		a <= {{(DATA_WID - 4){1'b0}}, 4'd2};
		b <= {{(DATA_WID - 4){1'b0}}, 4'd4};
		#20
		a <= {{(DATA_WID - 4){1'b0}}, 4'd1};
		b <= {{(DATA_WID - 4){1'b0}}, 4'd10};
		#20
		a <= {{(DATA_WID - 4){1'b1}}, 4'd12};
		b <= {{(DATA_WID - 4){1'b1}}, 4'd12};
		#20
		$finish;
	end
	mul#(DATA_WID) DUT(.a(a),.b(b),.enable(enable),.outlo(outlo), .outhi(outhi),.overflow(overflow));
endmodule
