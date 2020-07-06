`timescale 1ns/100ps

/**
 * Given a 4-bit number, this module should output the position of the first set bit in the number.
 * For instance, in the binary number
 *    1100
 *     ^----- bit #2 is the first set, so first_set should be 2'b10
 * or in the binary number
 *    0101
 *       ^--- bit #0 is the first set, so first_set should be 2'b00
 *
 * If all bits are zero, the "none_set" output should be high
 */
module find_first_set(input wire [3:0] n,

                      output reg [1:0] first_set,
                      output reg       none_set);
    //----------------------------------------------------------------
    // your code here
    //----------------------------------------------------------------
endmodule

// Just run the testbench, and it'll automatically check a few test cases for you.
module find_first_set_exercise_tb();
    reg [3:0] n;

    wire [1:0] first_set;
    wire       none_set;
    find_first_set ffs(.n(n),
                       .first_set(first_set),
                       .none_set(none_set));

    integer i;
    initial begin
        $dumpfile("find_first_set_exercise.vcd");
        $dumpvars(0, find_first_set_exercise_tb);

        n = 4'b0000;
        #10;
        if (none_set !== 1'b1) begin
            $display("test case failed for n = 0b%b", n);
            $finish;
        end

        n[0] = 1'b1;
        for (i = 0; i < 8; i = i + 1) begin
            n[3:1] = i;
            #10;
            if ((none_set !== 1'b0) || (first_set !== 2'b00)) begin
                $display("test case failed for n = 0b%b", n);
                $finish;
            end
        end

        n[1:0] = 2'b10;
        for (i = 0; i < 4; i = i + 1) begin
            n[3:2] = i;
            #10;
            if ((none_set !== 1'b0) || (first_set !== 2'b01)) begin
                $display("test case failed for n = 0b%b", n);
                $finish;
            end
        end

        n[2:0] = 3'b100;
        for (i = 0; i < 2; i = i + 1) begin
            n[3] = i;
            #10;
            if ((none_set !== 1'b0) || (first_set !== 2'b10)) begin
                $display("test case failed for n = 0b%b", n);
                $finish;
            end
        end

        n = 4'b1000;
        #10;
        if ((none_set !== 1'b0) || (first_set !== 2'b11)) begin
            $display("test case failed for n = 0b%b", n);
            $finish;
        end

        $display("all tests passed!");
        $finish;
    end
endmodule
