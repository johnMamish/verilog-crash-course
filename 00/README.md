# reg, always @*, and gtkwave

Verilog is a text-based language that can be used to describe logic circuits that are built out of wires, logic gates, multiplexers, and other primitives. Once you know your way around Verilog, you'll find that there's a pretty clear correlation between many Verilog constructs and schematics that you'd see drawn on a sheet. Unlike hand-drawn schematics, though, Verilog is faster and often easier to write, and works nicely with source-code management tools.

In this first speed-course example, we'll talk about some very basic Verilog language constructs. I'll also give some rules that Verilog technically allows you to break, but will make your code much harder to write or maintian. I might also tell some little white lies about Verilog that make it easier to understand.

### `reg` and `always @*`

``` Verilog

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

    ////////////////////////////////////////////////////////////////
    // This code describes a 'testbench'

    // kinda like main() in C
    initial begin
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

        // #<time> represents a delay.
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

        $finish;
    end
```

In each of the "Example" folders here, you'll find a simple example demonstrating these basic principles in one way or another. They can each be made by running 'make', and then you can look at what the circuit did by opening the generated ".vcd" file with gtkwave.
