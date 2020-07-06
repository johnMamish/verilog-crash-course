`timescale 1ns/100ps

// 2-input and gate
module and_example(input wire a,
                   input wire b,

                   output reg c);
    always @* begin
        c = a & b;
    end
endmodule

// 4-input and gate composed of 3 2-input and gates.
module nested_and4_example(input wire in1,
                           input wire in2,
                           input wire in3,
                           input wire in4,

                           // in this case, we have our output be a wire because we don't drive it with an
                           // always @* block inside this module. Instead, one of its sub-modules drives
                           // it with its own reg.
                           output wire result);
    wire out1;
    wire out2;

    and_example and1(.a(in1),
                     .b(in2),
                     .c(out1));

    and_example and2(.a(in3),
                     .b(in4),
                     .c(out2));

    and_example and3(.a(out1),
                     .b(out2),
                     .c(result));

endmodule

// It's worth pointing out that this above example is kind of contrived... If you ever need a
// 4-input and gate, you can just use regular 'and' operators like this:
//
//     a && b && c && d
//
// Making a module like above will just make your code harder to read.

module nested_and_example_testbench();
    ////////////////////////////////////////////////////////////////
    // Circuit
    reg [3:0] input_bits;

    wire result;

    // Instead of having 4 totally seperate 'reg' in our testbench, we can just have a single 4-bit
    // reg. It's individual bits can be accessed with square brackets, just like an array is
    // dereferenced in C or java.
    nested_and4_example this_and4(.in1(input_bits[0]),
                                  .in2(input_bits[1]),
                                  .in3(input_bits[2]),
                                  .in4(input_bits[3]),
                                  .result(result));

    ////////////////////////////////////////////////////////////////
    // Testbench
    integer i;
    initial begin
        $dumpfile("nested_and_example.vcd");
        $dumpvars(0, nested_and_example_testbench);

        // Because we're now working with a 4-bit reg instead of with 4 seperate variables, we can
        // more easily just use a for loop to go through all the possible values.
        input_bits = 4'h0;
        for (i = 0; i < 16; i = i + 1) begin
            #10;
            input_bits = input_bits + 4'h1;
        end

        $finish;
    end
endmodule
