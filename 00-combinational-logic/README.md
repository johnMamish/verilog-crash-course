# Basic combinational logic

#### Using `always @*` and `reg`


##### Hi

Verilog is a text-based language that can be used to describe logic circuits that are built out of wires, combinational logic (blobs of logic gates), and flip-flops. It's often easy to convert graphical schematics to Verilog, but Verilog is often faster and easier to write than schematics, and it works more nicely with source-code management tools like git.

In this first set of crash-course examples, we'll talk about some very basic Verilog language constructs. I'll also give some rules that Verilog technically allows you to break, but will make your code much harder to write or maintian. I might also tell some little white lies about Verilog that make it easier to understand.

In each of the "Example" folders here, you'll find a simple example demonstrating these basic principles in one way or another. Most of the useful information I've written up will be in the comments of those source files.

They can each be made by running 'make', and then you can look at what the circuit did by opening the generated ".vcd" file with gtkwave.

##### `reg`
A `reg` is a logical entity in Verilog made up of bits (which can nominally be `0` or `1`). A single `reg` can hold 1 bit or many bits.

```Verilog
    reg        my_one_bit_thing;   // declares a 1-bit reg.
    reg        a, b;         // declares 2 1-bit regs, called 'a' and 'b'.
    reg [31:0] my_integer;   // declares a 32-bit reg whose bits are numbered 0 to 31.
```

##### `always @*` (a.k.a `always @(*)`)
For a reg to be driven by combinational logic (a blob of `and`s, `or`s, `not`s, adders, `mux`es, etc... which doesn't loop back on itself), we use an `always @(*)` block. `always @*` blocks don't describe an algorithm to be interpreted step-by-step the same way that a Python script does, instead, `always @*` blocks describe a logic circuit; the stuff inside `always @*` blocks is interpreted line by line to describe a logic circuit.

```Verilog
    // here, "begin" acts like an opening curly brace would in C++/Java, and "end" acts like a
    // closing curly brace.
    always @* begin
        // my_one_bit_thing is continuously updated with the value of (a & b); immediately after 'a' or
        // 'b' changes, 'my_one_bit_thing' is updated.
        my_one_bit_thing = a & b;
    end
```

You can use the following operators and flow-control structures inside `always @*` blocks to describe logic circuits, which will be familiar to you if you've programmed before
  * arithmetic / bitwise logic operators `+`, `-`, `*`, `/`, `&`, `|`, `^`
  * comparison operators `<`, `>`, `<=`, `>=`, `==`, `!=`
  * `if ()`, `else`, `else if ()`
  * `case ()`

We assign values to `reg`s inside an `always @*` block using the `=` sign. You shouldn't assign a reg's value to itself in an `always @*` block, it should be a combination of other `reg`s.

If a `reg` has a value assigned to it inside an `always @*` block, it should be assigned to exactly once within that `always @*` block. Having cases where you assign to it more than once is fine, but it can make code that's difficult to debug when you're just starting out. Having cases where you assign to it zero times is really bad because the Verilog compiler will inadvertently generate an SR latch.

```Verilog
    // Good example, my_one_bit_thing is assigned to exactly once inside this always @* block.
    always @* begin
        my_one_bit_thing = a | b;
    end

    // This is also perfectly ok. Only one side of the 'if' statement will ever be true, so
    // my_one_bit_thing is assigned to exactly once.
    always @* begin
        if ((a & !b) || (b & !a)) begin
            my_one_bit_thing = a;
        end else begin
            my_one_bit_thing = 0;
        end
    end

    // This is a problem. The Verilog compiler will generate a latch.
    always @* begin
        if (a) begin
            my_one_bit_thing = !b;
        end
    end
```
Inadvertently generating a non-edge-triggered SR latch is bad because circuits containing them are more prone to timing glitches and can be much harder to debug. Well-crafted code is easy for others to read and easy for you to debug, so generating SR latches should be avoided.
