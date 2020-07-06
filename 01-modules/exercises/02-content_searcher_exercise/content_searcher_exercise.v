`timescale 1ns/100ps

/**
 * In some applications (CPU caches, for instance), it can be very helpful to make a sort of
 * 'reverse multiplexer', meaning that instead of putting in an index and getting a signal value
 * out, you put in a signal value and then the circuit will tell you if that value exists anywhere
 * in its list of values.
 *
 * This module should be able to take 4 values in 4 different slots. When a 'query' value is
 * presented, it should return the index of the matching value. Of course, it's pretty likely that
 * no values will match at all. In that case, the 'match' line should go low.
 *
 *            ------------------------
 *   0x37 --->| slot 0        match? |--->  '1' (yes! the value in slot 2 matches)
 *   0x00 --->| slot 1   match index |--->  '2' (slot 2 has, well, index 2)
 *   0xf3 --->| slot 2               |
 *   0x20 --->| slot 3               |
 *            |                      |
 *   0xf3 --->| query                |
 *            ------------------------
 *
 * If 2 or more pieces of content match, the lower-indexed slot is the one that's returned.
 *
 * Maybe there's a way to use your find_first_set module from the last exercise here?
 */
module content_searcher(input wire [7:0] slot0,
                        input wire [7:0] slot1,
                        input wire [7:0] slot2,
                        input wire [7:0] slot3,
                        input wire [7:0] query,

                        output reg       matched,
                        output reg [1:0] match_index);
    //----------------------------------------------------------------
    // your code here
    //----------------------------------------------------------------
endmodule

// Just run the testbench, and it'll automatically check a few test cases for you.
module content_searcher_tb();
    reg [7:0] slots [0:3];
    reg [7:0] query;

    wire matched;
    wire [1:0] match_index;

    content_searcher cs(.slot0(slots[0]),
                        .slot1(slots[1]),
                        .slot2(slots[2]),
                        .slot3(slots[3]),
                        .query(query),

                        .matched(matched),
                        .match_index(match_index));

    integer i;
    initial begin
        $dumpfile("content_searcher_exercise.vcd");
        $dumpvars(0, content_searcher_tb);

        slots[0] = 8'h11;
        slots[1] = 8'h00;
        slots[2] = 8'h33;
        slots[3] = 8'h44;
        query    = 8'h00;
        #10;
        if ((matched !== 1'b1) || (match_index !== 2'b01)) begin
            $display("test case failed. check the .vcd file");
            $finish;
        end

        query = 8'h44;
        #10;
        if ((matched !== 1'b1) || (match_index !== 2'b11)) begin
            $display("test case failed. check the .vcd file");
            $finish;
        end

        query = 8'h11;
        #10;
        if ((matched !== 1'b1) || (match_index !== 2'b00)) begin
            $display("test case failed. check the .vcd file");
            $finish;
        end

        slots[2] = 8'h11;
        #10;
        if ((matched !== 1'b1) || (match_index !== 2'b00)) begin
            $display("test case failed. check the .vcd file");
            $finish;
        end

        query = 8'hfe;
        #10;
        if (matched !== 1'b0) begin
            $display("test case failed. check the .vcd file");
            $finish;
        end

        $display("all test cases passed!");
        $finish;
    end
endmodule
