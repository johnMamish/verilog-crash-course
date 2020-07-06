# reg, always @*, and gtkwave

Verilog is a text-based language that can be used to describe logic circuits that are built out of wires, logic gates, multiplexers, and other primitives. Once you know your way around Verilog, you'll find that there's a pretty clear correlation between many Verilog constructs and schematics that you'd see drawn on a sheet. Unlike hand-drawn schematics, though, Verilog is faster and often easier to write, and works nicely with source-code management tools.

In this first speed-course example, we'll talk about some very basic Verilog language constructs. I'll also give some rules that Verilog technically allows you to break, but will make your code much harder to write or maintian. I might also tell some little white lies about Verilog that make it easier to understand.

In each of the "Example" folders here, you'll find a simple example demonstrating these basic principles in one way or another. Most of the useful information I've written up will be in the comments of those source files.

They can each be made by running 'make', and then you can look at what the circuit did by opening the generated ".vcd" file with gtkwave.
