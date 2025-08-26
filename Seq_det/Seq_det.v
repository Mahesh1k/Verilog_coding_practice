module seq_det(clk,x,z);
input clk,x;
output reg z;
reg [1:0] state;
parameter s0=0,s1=1,s2=2,s3=3;
always@(posedge clk)
case(state)
s0:z<=0;
s1:z<=0;
s2:z<=0;
s3:z<=x?0:1;
default: z<=0;
endcase
always@(posedge clk)
case(state)
s0:state<=x?s0:s1;
s1:state<=x?s2:s1;
s2:state<=x?s3:s1;
s3:state<=x?s0:s1;
default: state<=s0;
endcase
endmodule
//Testbench
`timescale 1ns/1ps
module seq_det_tb;
reg clk,x;
wire z;
integer i;
seq_det DUT(clk,x,z);
initial clk=0;
always #5 clk=~clk;
always @(posedge clk) begin
$monitor("%dns\t%b\t%b\t%b",$time,clk,x,z);
end
initial 
begin
    $dumpfile("Seq_det.vcd");
$dumpvars(0,seq_det_tb);
$display("Time\tclock\tinput\toutput");
$monitor("%dns\t%b\t%b\t%b",$time,clk,x,z);
end
initial begin
   #2;
   for (i=0; i<10; i++)
    begin
        if (i%2==0) 
        begin
        x=0;
        #20; 
        end
        else 
        begin
        x=1;
        #20;
         end
    end
#200 $finish;
end
endmodule
