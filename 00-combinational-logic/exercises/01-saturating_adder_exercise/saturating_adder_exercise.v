`timescale 1ns/100ps

module saturating_adder_exercise();
    ////////////////////////////////////////////////////////////////
    // Circuit
    reg [7:0] a;
    reg [7:0] b;

    reg [7:0] result;

    // maybe you need an extra reg?
    //----------------------------------------------------------------
    // your code here
    //----------------------------------------------------------------

    always @* begin
        // if a + b would generate a carry and overflow the counter, result should be set to 8'hff,
        // otherwise, it should be set to the result of a + b
        //----------------------------------------------------------------
        // your code here
        //----------------------------------------------------------------

        // Something that we didn't mention before: you should avoid assigning to the same reg
        // twice inside an always @* block.
        //
        // Just like exceptions can be a powerful tool in the arsenal of the C++/Java programmer,
        // re-using 'reg's inside an always @* block can be good, but let's try and keep it simple
        // for now; one reg <--> one expression <--> one assignment. (note that for 'if' statements
        // this still holds fine; only one part of the 'if' is ever active).
    end

    ////////////////////////////////////////////////////////////////
    // Testbench
    initial begin
        $dumpfile("saturating_adder_exercise.vcd");
        $dumpvars(0, saturating_adder_exercise);

        // write us some test code!
        //----------------------------------------------------------------
        // your code here
        //----------------------------------------------------------------

        $finish;
    end
endmodule
