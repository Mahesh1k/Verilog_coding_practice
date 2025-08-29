module four_bit_RC(t,clk,rst,q);
input clk;
input rst;
input [3:0] t;
output wire [3:0] q;
tff M1(.in(t[0]),.clk(clk),.rst(rst),.out(q[0]));
tff M2(.in(t[1]),.clk(q[0]),.rst(rst),.out(q[1]));
tff M3(.in(t[2]),.clk(q[1]),.rst(rst),.out(q[2]));
tff M4(.in(t[3]),.clk(q[2]),.rst(rst),.out(q[3]));
endmodule
module tff(in,clk,rst,out);
input in,clk,rst;
output reg out;
always @(posedge clk, rst) begin
    if (rst)
    out<=0;
    else begin
if (in)
out<=~out;
else
out<=out;
    end
end
endmodule
//Test bench
module four_bit_RC_tb;
reg clk;
reg rst;
reg [3:0] t;
wire [3:0] q;
four_bit_RC DUT(t,clk,rst,q);
initial clk=0;
always #5 clk=~clk;
initial begin
    $display("Time\tClock\tState");
    $monitor("%d\t%b\t%b",$time,clk,q);
    t=4'b1111;
    rst=1;
    #7 rst=0;
end
initial begin
    # 150 $finish;
end
initial begin
    $dumpfile("four_bit_RC.vcd");
    $dumpvars;
end
endmodule