module mul#(parameter DATA_WID = 4)(a,b,enable,outlo, outhi,overflow);
	input [DATA_WID - 1:0] a, b;
	input enable;
	wire [DATA_WID*2 - 1:0] out;
	output [DATA_WID - 1 : 0] outlo;
	output [DATA_WID - 1 : 0] outhi;
	output overflow;
	wire [DATA_WID - 1 : 0] partial_muls [DATA_WID - 1 : 0];
	genvar i,j;
	//generate
	for (i = 0; i < DATA_WID; i = i + 1) begin
		assign partial_muls[i] = {DATA_WID{a[i]}} & b;
	end
	//endgenerate
	wire [DATA_WID*2 - 1 : 0] shifted_muls [DATA_WID - 1 : 0];
	for (i = 0; i < DATA_WID; i = i + 1) begin
		assign shifted_muls[i] = partial_muls[i] << i;
	end
	wire [DATA_WID*2 - 1 : 0] partial_sums [DATA_WID - 2 : 0];
	wire[DATA_WID - 2 : 0] unused ;
	generate
	adder #(DATA_WID*2) add_part0 (shifted_muls[0],shifted_muls[1], enable, partial_sums[0], unused[0]);
	for (i = 1; i < DATA_WID - 1; i = i + 1) begin : generate_block_identifier
		adder #(DATA_WID*2) add_part (partial_sums[i - 1],shifted_muls[i+1],enable,partial_sums[i],unused[i]);
	end
	endgenerate
	assign out = partial_sums [DATA_WID - 2];
	assign outlo = out[DATA_WID - 1 : 0];
	assign outhi = out[DATA_WID*2 - 1 : DATA_WID];
endmodule // adder
