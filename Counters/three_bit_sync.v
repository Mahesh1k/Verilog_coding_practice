module three_bit_sync(clk,reset,count);
input clk,reset;
output [2:0] count;
wire w;
assign w=count[1]&count[0];
jkff M1(1'b1,1'b1,clk,reset,count[0]);
jkff M2(count[0],count[0],clk,reset,count[1]);
jkff M3(w,w,clk,reset,count[2]);
endmodule
module jkff(j,k,clk,reset,q);
input j,k,clk,reset;
output reg q;
always @(posedge clk)
if (reset)
q<=0;
else
q<=(~k&q)|(j&~q);
endmodule
// Test bench
module three_bit_sync_tb();
reg clk,reset;
wire [2:0] count;
three_bit_sync DUT(clk,reset,count);
initial clk=0;
always #5 clk=~clk;
initial begin 
    $display("Time\tClock\tCount");
    $monitor("time=%d\tclk=%b\tcount=%b",$time,clk,count);
    reset=1;
    #12 reset=0;
    # 100 $finish;
end
initial begin
    $dumpfile("three_bit_sync.vcd");
    $dumpvars;
end
endmodule
