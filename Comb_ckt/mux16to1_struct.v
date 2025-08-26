//Structural modeling of mux2to1
module mux2to1(in,sel,out);
input [1:0] in;
input sel;
output out;
wire selbar,t1,t2;
not G1(selbar,sel);
and G2(t1,in[0],selbar);
and G3(t2,in[1],sel);
or G4(out,t1,t2);
endmodule
//mux4to1 specifed using mux2to1
module mux4to1(in,sel,out);
input [3:0] in;
input [1:0] sel;
output out;
wire [1:0] t;
mux2to1 M1(in[1:0],sel[0],t[0]);
mux2to1 M2(in[3:2],sel[0],t[1]);
mux2to1 M3(t,sel[1],out);
endmodule
//mux16to1 specified using mux4to1
module mux16to1(in,sel,out);
input [15:0] in;
input [3:0] sel;
output out;
wire [3:0] t;
mux4to1 M1(in[3:0],sel[1:0],t[0]);
mux4to1 M2(in[7:4],sel[1:0],t[1]);
mux4to1 M3(in[11:8],sel[1:0],t[2]);
mux4to1 M4(in[15:12],sel[1:0],t[3]);
mux4to1 M5(t,sel[3:2],out);
endmodule
//Testbench
`timescale 1ns/1ps
module mux16to1_tb;
reg [15:0] A;
reg [3:0] B;
wire C;
integer i;
mux16to1 DUT(A,B,C);
initial begin
    $display("Time\tSel\tOut");
    $monitor("%dns\t%d\t%b",$time,B,C);
    #2 A=16'h3c5d;
    for(i=0; i<16; i=i+2)begin
        #5 B=i;
    end
   #10 $finish;
end
   initial begin
        $dumpfile("mux16to1_struct.vcd");
        $dumpvars(0,mux16to1_tb);
end
endmodule