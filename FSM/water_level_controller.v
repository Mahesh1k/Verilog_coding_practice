module wlc(dfr,fr1,fr2,fr3,clk,reset,s1,s2,s3);
input clk,reset,s1,s2,s3;
output reg dfr,fr1,fr2,fr3;
parameter q0=2'b00,q1=2'b01,q2=2'b10,q3=2'b11;
reg [1:0] state;
always @(posedge clk) begin
    if (reset) begin
        state<=q0;
        {fr1,fr2,fr3,dfr}<=4'b1111;
    end
    else begin
case(state)
q0: begin 
    if (s1) begin
    state<=q1;
    {fr1,fr2}<=2'b11;
    end
    else begin
        state<=q0;
        {fr1,fr2,fr3,dfr}<=4'b1111;
    end
end
q1: begin
    if (~s1&~s2&~s3) begin
    state<=q0;
    {fr1,fr2,fr3,dfr}<=4'b1111;
    end
     if (s1&s2) begin
    state<=q2;
    fr1<=1;
    end
end
q2: begin
    if (s1) begin
    state<=q1;
    {fr1,fr2,fr3,dfr}<=4'b1101;
    end
    if (s1&s2&s3) begin
    state<=q3;
    {fr1,fr2,fr3,dfr}<=4'b0000;
    end
end
q3: begin
    if (s1&s2) begin
    state<=q2;
    {fr1,fr2,fr3,dfr}<=4'b1001;
    end
    else begin
        state<=q3;
        {fr1,fr2,fr3,dfr}<=4'b0000;
    end
end
default:  begin
    state<=q0;
    {fr1,fr2,fr3,dfr}<=4'b1111;
end
endcase
end
end
endmodule
// Test bench
module wlc_tb;
reg reset,s1,s2,s3,clk;
wire fr1,fr2,fr3,dfr;
wlc DUT(dfr,fr1,fr2,fr3,clk,reset,s1,s2,s3);
initial clk=0;
always #5 clk=~clk;
initial begin
    $display("Time\tClock\tS1\tS2\tS3\tfr1\tfr2\tfr3\tdfr");
    $monitor("%d\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b",$time,clk,reset,s1,s2,s3,fr1,fr2,fr3,dfr);
    $dumpfile("water_level_controller.vcd");
    $dumpvars;
    reset=1;
    s1=0;
    s2=0;
    s3=0;
    #7 reset=0;
    #10 s1=1; s2=0; s3=0;
    #10 s1=1; s2=1; s3=0;
    #10 s1=1; s2=1; s3=1;
    #10 s1=1; s2=1; s3=0;
    # 100 $finish;
end
endmodule




