//   (C) Copyright International Business Machines 2017

// File name: ecc_ff_add_tb.v
//
// Author: Niranjan Vaish (niranjan.vaish@in.ibm.com)
//
// Description: Sample verilog testbench to simulate
//              finite field addition operation.
// 
// Chanage log:
// 05/10/2017 : Initial version. (Niranjan)
//
//

module ecc_ff_add_tb;
parameter m=163;
parameter sample_size=56;

reg [m-1:0] a, b, q_expected;
wire [m-1:0] q;

reg [m-1:0] a_in_array[0:sample_size-1];
reg [m-1:0] b_in_array[0:sample_size-1];
reg [m-1:0] q_out_array[0:sample_size-1];

reg clk;
integer i, j, err_cnt;

ecc_ff_add #(m) inst_ecc_ff_add(clk, a, b, q);

always #10 clk = ~clk;

initial 
begin
    $readmemh("../Testvectors/ecc_inp_a.txt", a_in_array);
    $readmemh("../Testvectors/ecc_inp_b.txt", b_in_array);
    $readmemh("../Testvectors/ecc_add.op.txt", q_out_array);
    clk = 1'b1;
    i = 0;
    j = 0;
    err_cnt = 0;

    @(negedge clk);
    a = a_in_array[i];
    b = b_in_array[i];

    repeat(sample_size)
    begin
        @(negedge clk);
        q_expected = q_out_array[i];
	if (q_expected !== q)
	begin
	    $display($time, "For input a=%h and b=%h, expected output=%h differs from actual output=%h\n", a, b, q_expected, q);
	    err_cnt = err_cnt + 1;
	end
        i = i+1;
        a = a_in_array[i];
        b = b_in_array[i];
    end
    @(posedge clk);
    if (err_cnt == 0)
        $display("TEST SUCCESSFUL...\n");
    $finish;
end

endmodule
