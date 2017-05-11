//   (C) Copyright International Business Machines 2017

// File name: ecc_ff_add.v
//
// Author: Niranjan Vaish (niranjan.vaish@in.ibm.com)
//
// Description: Sample verilog module to demonstrate 
//              finite field addition operation.
// 
// Chanage log:
// 05/10/2017 : Initial version. (Niranjan)
//
//


module ecc_ff_add(clk, a, b, q);
parameter m=163;

input clk;
input [m-1:0] a, b;
output [m-1:0] q;

reg [m-1:0] q;

always @(posedge clk)
	q = a ^ b;

endmodule
