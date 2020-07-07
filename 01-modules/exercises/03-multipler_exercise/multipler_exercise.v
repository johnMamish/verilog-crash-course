`timescale 1ns/100ps

/**
 * Given 2 4-bit unsigned numbers, this module should produce their product. You could just use the
 * Verilog '*' operator, or you could try doing it using the method shown in pages 2 - 3 of this
 * set of lecture slides
 *     http://courses.csail.mit.edu/6.111/f2008/handouts/L09.pdf
 *
 * Maybe try long-multiplying a few binary numbers by hand first to get the hang of it... for
 * instance:
 *
 *     1001   = 9
 *    *1101   = 13
 * ---------
 *     1001
 *    0000
 *   1001
 * +1001
 * ---------
 *  1110101   = 117
 *
 * It might also help if you know how to 'bitslice' numbers (to get the middle 2 bits of a 4-bit
 * number, you can do number[2:1]) and how to bitwise concatenate signals.
 *
 *     reg [3:0] a;
 *     {2'h0, a, 2'h0}  <--- this will be an 8-bit expression holding the value of 'a', padded on
 *                           both sides by 2 zero bits.
 */
module multiplier(input wire [3:0] a,
                  input wire [3:0] b,

                  output reg [7:0] product);

endmodule

module multiplier_exercise_tb();
    reg [8:0] count_over;

    reg [3:0] a;
    reg [3:0] b;
    wire [7:0] product;
    multiplier mul(.a(a),
                   .b(b),
                   .product(product));

    initial begin
        $dumpfile("multiplier_exercise.vcd");
        $dumpvars(0, multiplier_exercise_tb);

        count_over = 9'h0;
        a = count_over[3:0];
        b = count_over[7:4];
        while(count_over < 9'h100) begin
            #10;
            if (product !== (a * b)) begin
                $display("test case failed. Check .vcd output for info.");
                $finish;
            end
            count_over = count_over + 9'h1;
            a = count_over[3:0];
            b = count_over[7:4];
        end

        $display("all tests passed!");
        $finish;
    end
endmodule
