`timescale 1ns/1ps
`include "mux16to1_using_4to1.v"
module mux16to1_using_4to1_tb;
reg [15:0] A;
reg [3:0] B;
wire C;
mux16to1 DUT(.in(A),.sel(B),.out(C));
initial begin
    $display("Time\tSelect line\tOutput");
$monitor("%dns\t%d\t%b",$time,B,C);
#5 A=16'h0F31;
#5 B=4'd2;
#5 B=4'd5;
#5 B=4'd6;
#10 $finish;
end
initial begin
    $dumpfile("mux16to1_using_4to1_tb.vcd");
    $dumpvars(0,mux16to1_using_4to1_tb);
end
endmodule