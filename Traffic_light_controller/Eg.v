module tfc(clk,ped,side_s,main_l,side_l,ped_l);
input clk,ped,side_s;
output reg [1:0] main_l,side_l;
output reg ped_l;
reg [2:0] pre_state,state;
reg [1:0] side_s_c,side_l_c;
parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100,s5=3'b101;
always @(posedge clk) //Side_sensor Counter
 begin
if (side_s) side_s<=side_s+1;
else side_s_c<=0;
if (side_s_c>3) side_s_c<=0;
 end
 always @(posedge clk) // Ped_l counter
 if 
always @ (posedge clk) // Side_l Green counter
if (side_l==2'b10) side_l_c<=side_l_c+1;

always @(posedge clk) //State transistion
begin
case(state)
s0: (side_s_c>2) state<=s1;
s1:state<=s2;
s2:
s5: 
default: next_state=s0;
endcase
end
always @(posedge clk) //Control signals
begin
case(pre_state)
s0: begin main_l<=2'b10; side_l<=2'b00; ped_l=0; end
s1: main_l=2'b01;
s2: begin main_l=2'b00; side_l=2'b10; end
s5: begin
ped_l=1;
main_l=2'b00;
side_l=2'b00;
end

if 
 end
default: begin main_l<=2'b10; side_l<=2'b00; ped_l=0; end
endcase
end