module mul#(parameter DATA_WID = 4)(a,b,enable,out,overflow);
	input [DATA_WID - 1:0] a, b;
	input enable;
	output[DATA_WID*2 - 1:0] out;
	output overflow;
	wire [DATA_WID - 1 : 0] partial_sums [DATA_WID - 1 : 0];
	genvar i,j;
	//generate
	for (i = 0; i < DATA_WID; i = i + 1) begin
		for (j = 0; i < DATA_WID; i = i + 1) begin
			assign partial_sums[i][j] = a[i] | b[j];
		end
	end
	//endgenerate



endmodule // adder
