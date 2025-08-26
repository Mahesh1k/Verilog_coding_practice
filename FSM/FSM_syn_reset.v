//Module
module fsm(out,j,k,reset,clk);
input j,k,reset,clk;
output out;
parameter OFF=0, ON=1;
reg state, next_state;
//state transistion logic
always @(*) begin
case (state)
    OFF: next_state=j?ON:OFF;
    ON: next_state=k?OFF:ON;
    default: next_state<=OFF;
endcase
end
//State transistion
always @(posedge clk) begin
if (reset)
state<=OFF;
else
state<=next_state; 
end
//Output logic
assign out=(state==ON);
endmodule
//Test bench
`timescale 1ns/1ps
module fsm_tb;
reg J,K,res;
wire Q;
reg clk;
fsm DUT(.out(Q),.j(J),.k(K),.reset(res),.clk(clk));
initial clk=1'b0;
always #5 clk=~clk;
initial begin
    #3 res=1'b1;
    #3 res=1'b0;
    #7 J=1'b0;
    #10 J=1'b1;
    #10 K=1'b0;
    #10 K=1'b1;
    #10 res=1'b1;
    #3 $finish;
end
initial begin
    $dumpfile("fsm_syn_res.vcd");
    $dumpvars(0,fsm_tb);
end
initial begin
    $display("Time\tJ\tK\tQ");
    $monitor("%d\t%b\t%b\t%b\t%b",$time,clk,J,K,Q);
end
endmodule




