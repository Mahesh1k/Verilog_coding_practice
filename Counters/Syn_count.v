//Module design
module syn_c(clk,q);
input clk;
output reg [3:1] q;
wire [3:1] d;
reg [2:0] w;
initial q=3'b000;
always @(*) begin
    w[0]=q[3]|q[2];
    w[1]=~q[3]&~q[2];
    w[2]=q[3]&~q[1]; end
df A(w[0],clk,d[3]);
df B(w[1],clk,d[2]);
df C(w[2],clk,d[1]);
always @(posedge clk) 
q<=d; 
endmodule
module df(d,clk,q);
input d,clk;
output reg q;
always @(posedge clk)
q<=d;
endmodule
//Test bench
module tb;
reg clk;
wire [3:1] q;
syn_c DUT(clk,q);
initial clk=0;
always #5 clk=~clk;
initial begin
    $display("Time\tClock\tCount");
$monitor("%d\t%b\t%b",$time,clk,q);
#100 $finish;
end
initial begin 
    $dumpfile("Syn_count.vcd");
    $dumpvars(0,tb);
end
endmodule