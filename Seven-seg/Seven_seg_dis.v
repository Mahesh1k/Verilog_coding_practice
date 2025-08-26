module seven_seg(input [6:0]in, output reg [3:0]out );
always @(*)
begin
    case(in)
    7'b0111111:out=0;
    7'b0000110:out=1;
    7'b1011011:out=2;
    7'b1001111:out=3;
    7'b1100110:out=4;
    7'b1101101:out=5;
    7'b1111101:out=6;
    7'b0000111:out=7;
    7'b1111111:out=8;
    7'b1100111:out=9;
    endcase
end
endmodule
//Testbench
`timescale 1ns/1ps
module seven_seg_tb;
reg [6:0] A;
wire [3:0] B;
seven_seg DUT(.in(A),.out(B));
initial begin
    $display("time\tinput\toutput");
    $monitor("%dns\t%b\t%d",$time,A,B);
    #5 A=7'b0000110;
    #5 A=7'b1100111;
#5 $finish;
end
initial begin
    $dumpfile("Seven_seg_dis.vcd");
    $dumpall;
end
endmodule  
