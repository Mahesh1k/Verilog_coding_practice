module seq_111(x, clk, reset, out);
    input x, clk, reset;
    output out;
    wire Q1, Q0;
    wire J1, K1, J0, K0;

    // Excitation equations from K-map
    assign J1 = x & Q0;
    assign K1 = (~x) & Q0;
    assign J0 = x & ~Q1 & ~Q0;
    assign K0 = (~x) | Q1;

    // Instantiate JK flip-flops
    jkff FF1(J1, K1, clk, reset, Q1);
    jkff FF0(J0, K0, clk, reset, Q0);

    // Output logic
    assign out = Q1 & Q0 & x;
endmodule


module jkff(J, K, clk, reset, Q);
    input J, K, clk, reset;
    output reg Q;

    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 0;
        else
            case ({J,K})
                2'b00: Q <= Q;      // No change
                2'b01: Q <= 0;      // Reset
                2'b10: Q <= 1;      // Set
                2'b11: Q <= ~Q;     // Toggle
            endcase
    end
endmodule


// Testbench
module seq_111_tb();
    reg x, clk, reset;
    wire out;

    seq_111 DUT(x, clk, reset, out);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Time\tclk\tx\tout");
        $monitor("%0d\t%b\t%b\t%b", $time, clk, x, out);

        reset = 1; x = 0;
        #6 reset = 0;

        // Input stream to test overlap
        #4 x=1;
        #10 x=1;
        #10 x=1;  // detect here
        #10 x=1;  // overlap detect again
        #10 x=0;
        #10 x=1;
        #10 x=1;
        #10 x=1;  // detect here
        #10 x=0;
        #10 $finish;
    end

    initial begin
        $dumpfile("seq_111.vcd");
        $dumpvars;
    end
endmodule
