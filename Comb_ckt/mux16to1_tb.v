`timescale 1ns/1ps
`include "mux16to1.v"
module mux16to1_tb();
reg [15:0] A;
reg [3:0] B;
wire C;
integer i;
mux16to1 dut(.in(A),.sel(B),.out(C));
initial 
begin
    $display("Time\tsel\tout");
    $monitor("%0dns\t%b\t%b",$time,B,C);
    A=16'b0101010101010101;
    for(i=0; i<16; i=i+1) begin
        B=i;
        #10;
end
$finish;
end
   initial begin
        $dumpfile("mux16to1_tb.vcd");
        $dumpvars(0, mux16to1_tb);
    end
endmodule