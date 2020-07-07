/**
 * This is the 'final boss' of my Verilog crash course, so a lot of stuff is left up to you.
 *
 * Write
 *    * A module that finds the integer square root of a 32-bit number.
 *      This sounds really hard at first (and it is hard), but this app note published by Microchip
 *      should give you a good starting point
 *           http://ww1.microchip.com/downloads/en/AppNotes/91040a.pdf
 *      Hint: it's basically describing a binary search algorithm for the right square root,
 *            checking its guess at every step by squaring its current guess.
 *
 *      Your module should take ~33 clock cycles to find the square root of a 32-bit number.
 *
 *    * A testbench that convinces you that your module works right.
 *
 *    * Extra challenge: Once your square root module works, modify it so it can 'bail out' early
 *      if it has found the right square root before all 32 of its guesses are used up.
 */

module integer_square_root(input        clock,
                           input        reset,
                           input [31:0] operand,

                           output reg [15:0] result);
    //----------------------------------------------------------------
    // your code here
    //----------------------------------------------------------------
endmodule


module integer_square_root_exercise_tb();
    //----------------------------------------------------------------
    // your code here
    //----------------------------------------------------------------
endmodule
