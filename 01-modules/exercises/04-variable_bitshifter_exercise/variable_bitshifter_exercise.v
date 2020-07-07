`timescale 1ns/100ps

/**
 * This module should shift its input by the given number of bits.
 *
 * If the 'direction' bit is high, it should be shifted to the left; if 'direction' is low, it
 * should be shifted to the right.
 *
 * If 'sign_extend' is 0 or if a left-shift is being done, the empty bits should be filled with
 * the value in 'fill'.
 * If 'sign_extend' is 1 and a right-shift is being done, the right-shifted number should be sign-
 * extended with its most-significant bit. e.g:
 *    8'b1111_1010 right-shifted by 1 with sign_extend enabled becomes 8'b1111_1101
 *    8'b0111_0001 right-shifted by 1 with sign_extend enabled becomes 8'b0011_0000
 *
 * A couple of constructs that we didn't talk about much but may come in handy are:
 *    * The 'case' statement, which visually looks very similar to case statements in traditional
 *      programming languages and is basically shorthand for a multiplexer
 *          case(my_reg)
 *              1'b0: $display("my_reg is 0");
 *              1'b1: $display("my_reg is 1");
 *          endcase
 *
 *    * The curly-brace concatenation/replication operators, which let you smash two short 'reg's
 *      together into a longer reg.
 *        * concatenation:
 *          { 4'b1010, 4'b0000 } is equivalent to 8'b10100000
 *        * replication:
 *          { {8{1'b0}} } is equivalent to 8'b00000000
 *        * replication and concatenation:
 *          { {4{1'b1}}, {4{1'b0}} } is equivalent to 8'b11110000
 *
 * There are a few different ways to implement this module. Google is your friend; go with a method
 * that makes sense!
 */


/**
 * As you might have noticed in other examples, `define macros work somewhat similarly to how they
 * work in C/C++, but to use them in an expression, they need to be prefixed by a backtick (the
 * character that shares a key with the tilde (~)).
 * e.g.
 *     if (direction == `SHIFT_DIRECTION_RIGHT) begin
 *         // do it this way
 *     end else begin
 *         // do it the other way
 *     end
 */
`define SHIFT_DIRECTION_RIGHT (1'b0)
`define SHIFT_DIRECTION_LEFT (1'b1)

/**
 * input shiftee        Number which is to be shifted
 * input shift_amount   Number of bits by which to shift the 'shiftee'. Values between 0 and 8 are
 *                      valid, amounts outside that range can be handled however you want; they're
 *                      undefined.
 * input fill_bit       Specifies whether the empty bits left by the shift should be filled with a
 *                      '1' or a '0'.
 * input sign_extend    If this bit is '1', right-shifts shall be sign-extended instead of filled
 *                      with 'fill_bit'. This bit has no effect on left-shifts.
 *
 * output shifted       The input, but shifted according to the given parameters
 */
module shifter(input [7:0] shiftee,
               input [3:0] shift_amount,
               input       direction,
               input       fill_bit,
               input       sign_extend,

               output reg [7:0] shifted);
    //----------------------------------------------------------------
    // your code here
    //----------------------------------------------------------------
endmodule



module variable_bitshifter_exercise_tb();
    reg [7:0] shiftee;
    reg [3:0] shift_amount;
    reg       direction;
    reg       fill_bit;
    reg       sign_extend;

    wire [7:0] shifted;

    shifter sh(.shiftee(shiftee),
               .shift_amount(shift_amount),
               .direction(direction),
               .fill_bit(fill_bit),
               .sign_extend(sign_extend),

               .shifted(shifted));

    integer i, j;
    initial begin
        // basic right-shift testcases
        shiftee = 8'h6a;
        shift_amount = 4'h0;
        direction = `SHIFT_DIRECTION_LEFT;
        fill_bit = 1'b0;
        sign_extend = 1'b0;
        #1;
        if (shifted !== 8'h6a) begin
            $display("A test case failed. Check .vcd output for info.");
            $finish;
        end
        #9;
        shift_amount = 4'h3;
        #1;
        if (shifted !== 8'h0d) begin
            $display("A test case failed. Check .vcd output for info.");
            $finish;
        end
        #9;
        direction = `SHIFT_DIRECTION_RIGHT;
        #1;
        if (shifted !== 8'h50) begin
            $display("A test case failed. Check .vcd output for info.");
            $finish;
        end

        // sign-extend tests
        shiftee = 8'hf0;
        shift_amount = 4'h0;
        direction = `SHIFT_DIRECTION_RIGHT;
        fill_bit = 1'b1;
        sign_extend = 1'b0;
        for (i = 0; i < 2; i = i + 1) begin
            for (j = 0; j <= 8; j = j + 1) begin
                #1;
                if (shifted[7:4] !== 4'hf) begin
                    $display("A test case failed. Check .vcd output for info.");
                    $finish;
                end
                shift_amount = j;
                #9;
            end
            fill_bit = ~fill_bit;
        end
        #10;
        $finish;
    end

endmodule
