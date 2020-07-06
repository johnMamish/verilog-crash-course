`timescale 1ns/100ps

// This module contains our hardware circuit design
module and_module_example(input wire a,
                          input wire b,
                          // ^^^ Inputs a and b are not 'reg' like the other things we've seen so
                          // far. Inputs to a module must not be 'reg', they can be only of another
                          // type called 'wire'.
                          //
                          // A simplified view of the difference between reg and wire is that
                          //    * reg entities are driven by combinational logic (or, later on, by
                          //      registers) inside always @ blocks
                          //    * wire entities transport values held by reg entities between
                          //      different modules and logic blocks
                          //
                          // 'a' and 'b' are wires within this module. An outside module
                          // could drive 'a' and 'b' with its own 'reg' entities (as we will see
                          // in the testbench below). Inside this module though, 'a' and 'b' must be
                          // treated as wires; they can't have values assigned to them within this
                          // module (if we could do that, then we might contradict values coming in
                          // from outside).

                          output reg c
                          // ^^^ Outputs are generally of type 'reg'. This is because the hardware
                          // inside this module is actively driving c.
                          );
    always @* begin
        c = a & b;
    end
endmodule

// We keep our testbench code in a seperate place than our circuit design.
//
// Verilog would allow us to put our 'initial' statement inside our and_module_example module, but
// we want to keep code that describes hardware seperate from code that describes how we want to
// test the hardware.
module and_module_example_testbench();
    ////////////////////////////////////////////////////////////////
    // Circuit
    reg a_testbench;
    reg b_testbench;

    wire c_output;

    // this is how we instantiate a single and module to test out in our testbench
    and_module_example this_and(.a(a_testbench),
                                .b(b_testbench),
                                .c(c_output));

    ////////////////////////////////////////////////////////////////
    // Testbench
    integer i;
    initial begin
        $dumpfile("and_module_example.vcd");
        $dumpvars(0, and_module_example_testbench);

        a_testbench = 1'b0;
        b_testbench = 1'b0;
        #10;

        a_testbench = 1'b1;
        b_testbench = 1'b0;
        #10;

        a_testbench = 1'b0;
        b_testbench = 1'b1;
        #10;

        a_testbench = 1'b1;
        b_testbench = 1'b1;
        #10;

        $finish;
    end
endmodule
