module ring_c(clk,init,count);
input clk,init;
output reg [3:0] count;
always @(posedge clk)  //Synchronous initialization
begin
    if (init) 
    count<=4'b0001;
    else
    count<={count[2:0],count[3]};
end
endmodule
//Testbench
module ring_c_tb;
reg clk,init;
wire [3:0] count;
ring_c DUT(clk,init,count);
initial clk=1'b0;
always #5 clk=~clk;
initial begin
    $display("Time\tClock\tInit\tCount");
    $monitor("%d\t%b\t%b\t%b",$time,clk,init,count);
    #2 init=1'b1;
    #10 init=1'b0;
    #100 $finish;
end
initial begin
    $dumpfile("ring_counter.vcd");
    $dumpvars();
end
endmodule




