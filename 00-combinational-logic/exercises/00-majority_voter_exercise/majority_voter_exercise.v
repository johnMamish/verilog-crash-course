`timescale 1ns/100ps

module majority_voter_exercise();
    ////////////////////////////////////////////////////////////////
    // Circuit
    reg a;
    reg b;
    reg c;

    reg result;

    always @* begin
        // Insert code in here that makes result equal to
        //   0 if 2 or more of {a, b, c} are 0
        //   1 if 2 or more of {a, b, c} are 1
        //----------------------------------------------------------------
        // your code here
        //----------------------------------------------------------------
    end

    ////////////////////////////////////////////////////////////////
    // Testbench
    initial begin
        $dumpfile("majority_voter_exercise.vcd");
        $dumpvars(0, majority_voter_exercise);

        // Insert code here that tests all possible inputs of a, b, and c.
        // maybe see if you can do it with a for loop!
        //----------------------------------------------------------------
        // your code here
        //----------------------------------------------------------------

        $finish;
    end
endmodule
