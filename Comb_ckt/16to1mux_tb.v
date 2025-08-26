'timescale 1ns/1ps
include "16to1mux.v"
module 16to1mux_tb;
reg [15:0] A;
reg [3:0] B;
wire C;
16to1mux dut(.A(in),.B(sel),.C(out));
initial 
begin
    $display("Time\tsel\tout");
    $monitor("%0dns\t%d\t%b",$time,sel,out);
    A=16'b0101010101010101;
    for(B=0; B<16 B=B+1)
    begin
        #10;
end
$finish;
end
initial
begin
    $dumpfile("16to1mux_tb.vcd");
    $dumpvars(0,16to1mux_tb);
end
endmodule