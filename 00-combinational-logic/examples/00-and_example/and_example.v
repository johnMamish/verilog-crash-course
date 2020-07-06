`timescale 1ns/100ps

// To see what this file does, run the following commands
//     user@computer$ make
//     user@computer$ ./and_example.vvp
//     user@computer$ gtkwave
//
// These commands compile and_example.v into a program that simulates your hardware design. The
// program runs the simulation, and the resulting digital waveforms of the simulation are dropped
// into a file called "and_example.vcd", which can be opened with viewers like gtkwave.

// Ignore the use of the word 'module' here; we'll talk about it later.
//
// All you need to know now is that all of the hardware you design needs to be kept inside a module,
// kinda like how everything needs to be inside a class in Java.
module and_example();
    ////////////////////////////////////////////////////////////////
    // This code describes a circuit.

    // *** This declares a 1-bit logical entity that can have a value assigned to it.
    reg result;

    reg a;
    reg b;

    // *** 'reg's have their values assigned to them from within 'always' blocks.
    //
    // Depending on the type of 'always' block used to assign to a reg, it will behave either
    // like a wire or like an edge-triggered register. For now, we are only looking at always @*
    // blocks, which means that the assignments inside of them happen continuously*, just like
    // the way that a wire driven by a single digital signal has its state continuously updated by
    // whatever's driving it.
    //
    // *(this isn't 100% true in Ye Olde Verilog, but is true in SystemVerilog, the updated version.
    // This little white lie is practically true for many purposes in Verilog).
    always @* begin
        result = a & b;
    end

    // *** Always @* blocks should be used to implement 'forward-propagating' combinational logic like
    // adders, multiplexers, or lookup tables.
    //
    // Other types of block will be used to implement logic that requires storing state, like
    // counters, FSMs, or pipelines.

    // side note: "begin" and "end" are basically opening and closing curly braces, but for Verilog.

    ////////////////////////////////////////////////////////////////
    // This code describes a 'testbench'

    // kinda like main() in C, "initial" gives the simulator an entry point; this is where the
    // simulation begins. This is where we specify how we want to poke and prod the circuit we
    // described above to see if it works.
    initial begin
        // These 2 lines will make all of the signals inside our file get dumped into a '.vcd' file,
        // which we can inspect in a program like gtkwave to see if our hardware is working right.
        $dumpfile("and_example.vcd");
        $dumpvars(0, and_example);

        // toggle 'a' and 'b' into all 4 possible values, waiting for 10 nanoseconds in between each.
        //
        // "1'b0" is a constant.
        //     "1'" means that it's one bit wide.
        //     "b"  means that it's in binary.
        //     "0"  is the value.
        //
        // Other valid constants could include
        //     "32'hf00fba11"
        //     "8'b1001_0110"  (underscores are allowedto split up long constants for readability)
        //     "3'h6"
        a = 1'b0;
        b = 1'b0;

        // #<time> represents a delay. #10 represents a delay of 10 nanoseconds.
        #10;

        a = 1'b1;
        b = 1'b0;
        #10;

        a = 1'b0;
        b = 1'b1;
        #10;

        a = 1'b1;
        b = 1'b1;
        #10;

        // Now we're done.
        $finish;
    end
endmodule
