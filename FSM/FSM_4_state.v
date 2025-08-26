module fsm_4(in,out,clk);
input in,clk;
output out;
parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;
reg [1:0] state, next_state;
always @(*) begin
case (state)
A: next_state=in?B:A;
B: next_state=in?B:C;
C: next_state=in?D:A;
D: next_state=in?B:C;
default next_state=A;
endcase
end
always @(posedge clk) begin
state<=next_state;
end
assign out=(state==D);
endmodule
//Testbench
module tb;
reg in,clk;
wire out;
fsm_4 DUT(.in(in),.out(out),.clk(clk));
initial clk=0;
always #5 clk=~clk;
initial begin
    $display("Time\tClock\tinput\toutput");
    $monitor("%d\t%b\t%b\t%b",$time,clk,in,out);
    #3 in=1'b0;
    #10 in=1'b1;
    #10 in=1'b0;
    #10 in=1'b1;
    #10 in=1'b0;
    #30 $finish;
end
initial begin
    $dumpfile("FSM_4_state.vcd");
    $dumpvars;
end
endmodule




    


