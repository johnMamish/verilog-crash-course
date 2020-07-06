`timescale 1ns/100ps


module one_bit_full_adder(input wire a,
                          input wire b,
                          input wire carry_in,

                          output reg sum,
                          output reg carry_out);
    //----------------------------------------------------------------
    // your code here
    //----------------------------------------------------------------
endmodule


module four_bit_full_adder(input wire [3:0] a,
                           input wire [3:0] b,
                           input wire carry_in,

                           output wire [3:0] sum,
                           output wire carry_out);
    // use one_bit_full_adders to make a four bit adder
    //----------------------------------------------------------------
    // your code here
    //----------------------------------------------------------------
endmodule

// For this exercise, all you have to do is run the testbench. If there's a bug, it will print a
// messsage. If it says you didn't pass, check the .vcd file with gtkwave.
module adder_exercise_tb();
    reg  [3:0] a;
    reg  [3:0] b;
    reg        carry_in;
    wire [4:0] sum;

    four_bit_full_adder adder(.a(a),
                              .b(b),
                              .carry_in(carry_in),

                              .sum(sum[3:0]),
                              .carry_out(sum[4]));

    reg [9:0] count_over;
    initial begin
        $dumpfile("adder_exercise.vcd");
        $dumpvars(0, adder_exercise_tb);

        count_over = 10'h000;
        while (count_over < 10'h200) begin
            a = count_over[3:0];
            b = count_over[7:4];
            carry_in = count_over[8];
            #1;
            if (sum !== (a + b + carry_in)) begin
                $display("failed for a = 0x%h, b = 0x%h, carry_in = %b", a, b, carry_in);
                $display("expected sum = 0x%h, got sum = 0x%h", (a + b + carry_in), sum);
                $display("aborting");
                $finish;
            end
            count_over = count_over + 9'h1;
            #9;
        end

        $display("all tests passed!");
        $finish;
    end
endmodule
