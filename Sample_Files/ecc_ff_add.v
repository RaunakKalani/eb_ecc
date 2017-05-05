module ecc_ff_add(a, b, q);
parameter m=163;

input [m-1:0] a, b;
output [m-1:0] q;

assign q = a ^ b;

endmodule
