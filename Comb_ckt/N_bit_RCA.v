//Full adder
module FA(a,b,c,sum,cout);
input a,b,c;
output sum,cout;
assign sum=a^b^c;
assign cout=(a&b)|(b&c)|(c&a);
endmodule
//N_bit_RCA_module design using generate loop
module N_RCA(num1,num2,cin,sum,cout);
parameter N=4;
input cin;
input [N-1:0] num1, num2;
output cout;
output [N-1:0] sum;
wire [N:0] carry;
assign carry[0]=cin;
assign cout=carry[N];
genvar i;
generate for(i=0; i<N; i=i+1)
begin: fa_gen
FA M1(num1[i], num2[i], carry[i],sum[i],carry[i+1]);
end
endgenerate
endmodule
//Testbench
`timescale 1ns/1ps
module N_RCA_tb;
reg [3:0] num1,num2;
reg cin;
wire cout;
wire [3:0] sum;
N_RCA I1(num1,num2,cin,sum,cout);
initial begin
    $display("Time%d\tCin\tNumber1\tNumber2\tSum\tCout");
    $monitor("%d\t%b\t%b\t%b\t%b\t%b\t",$time,cin,num1,num2,sum,cout);
    #5 cin=0; num1=4'b0001; num2=4'b0011;
    #5 cin=1; num1=4'b1000; num2=4'b1000;
    #5 cin=0; num1=4'b1000; num2=4'b1000;
    #20 $finish;
end
initial begin
    $dumpfile("N_bit_RCA.vcd");
    $dumpvars();
end
endmodule

