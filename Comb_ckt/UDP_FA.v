//Full adder by User definded primitive and these are not synthesizable and ouputs cannot be more than one
primitive udp_fa(sum,a,b,c); //Frist port musst be output
 input a,b,c;
 output sum;
 table
    // a  b  c  sum 
       0 0 0 : 0;
       0 0 1 : 1;
       0 1 0 : 1 ;
       0 1 1 : 0;
       1 0 0 : 1;
       1 0 1 : 0 ;
       1 1 0 : 0 ;
       1 1 1 : 1 ;
 endtable
endprimitive
//Testbench
module udp_fa_tb;
reg a,b,c;
wire sum;
udp_fa M1(sum,a,b,c);
initial begin
    $display("Time\ta\tb\tc\tsum");
    $monitor("%d\t%b\t%b\t%b\t%b",$time,a,b,c,sum);
    #5 a=1; b=0; c=1;
    #5 a=0; b=0; c=1;
    #5 a=1; b=1; c=1;
    #5 $finish;
end
initial begin
    $dumpfile("udp_fa.vcd");
    $dumpvars();
end
endmodule

