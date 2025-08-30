module seq_fsm(x,clk,reset,y);
input clk,x,reset;
output y;
parameter s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;
reg [1:0] next_state, state;
always @(*) begin
case(state)
s0: next_state<=x?s1:s0;
s1: next_state<=x?s2:s1;
s2: next_state<=x?s3:s2;
s3: next_state<=x?s3:s0;
default: next_state<=s0;
endcase
end
assign y=(state==s3);
always @(posedge clk)
if (~reset)
state<=s0;
else
state<=next_state;
endmodule
//Test bench
module seq_fsm_tb();
reg x,clk,reset;
wire y;
seq_fsm DUT(x,clk,reset,y);
initial clk=0;
always #5 clk=~clk;
initial begin
    $display("Time\tClock\tInput\tOutput");
    $monitor("%d\t%b\t%b\t%b",$time,clk,x,y);
    reset=0;
    #7 reset=1;
    #6 x=1;
    #10 x=1;
    #10 x=1;
    #10 x=0;
    #10 x=1;
    #10 x=1;
    #10 x=1;
    #10 x=0;
#10 $finish;
end
endmodule
