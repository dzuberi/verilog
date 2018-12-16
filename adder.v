module adder#(parameter DATA_WID = 8)(a,b,enable,out,overflow);
	input [DATA_WID - 1:0] a, b;
	input enable;
	output[DATA_WID - 1:0] out;
	output overflow;

	wire [DATA_WID - 1: 0] g,p,c;
	wire [DATA_WID/2 - 1: 0] twobc;
	wire [DATA_WID/4 - 1: 0] fourbc;
	genvar i;

	for(i = 0; i < DATA_WID; i= i+1) begin
		assign g[i] = a[i]&b[i];
		assign p[i] = a[i]^b[i];
	end
	assign c[0] = g[0];
	assign out[0] = p[0];
	for(i = 1; i < DATA_WID; i= i+1) begin
		assign c[i] = (c[i-1]&p[i])|g[i];
		assign out[i] = p[i]^c[i-1];
	end
	assign overflow = g[DATA_WID-1];



endmodule // adder