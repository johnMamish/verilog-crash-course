# Sequential logic

#### using `always @(posedge ***)` blocks and the `<=` assignment operator
In parts 00 and 01, we designed combinatorial logic by assigning values to `reg`s inside `always @*` blocks using the `=` operator. All of this logic should be strictly feed-forward and hold no state; the output of a circuit at any point in time is dependant on ONLY its inputs at that moment. This makes it impossible to make counters, state machines, processors, or neural network accelerators.

`always @(posedge ***)` blocks (usually `always @(posedge clock)`) will store values in `reg`s at a specific point in time (when a certain signal rises from 0 to 1). `reg`s that are assigned a value inside an `always @(posedge ***)` block will behave as registers; they retain their value until the next `posedge` of the given signal comes along.

The purpose of `always @*` blocks is to generate feed-forward combinational logic made of `and`, `or`, and `not` gates.

The purpose of an `always @(posedge ***)` block is to store results of `always @*` blocks in flip-flops (although it's sometimes ok to put a little bit of simple combinational logic inside an `always @(posedge ***)` block).

Because we conceptualize everything inside `always @(posedge ***)` blocks as happening at a specific instant in time, we use the `<=` operator for assignments in `always @(posedge ***)` blocks. Verilog tells us that this is the "parallel assignment" operator; in an `always` block, everything with the `<=` assignment operator gets its assignments at the same time. It's wrong to think of an `always @(posedge ***)` block as being interpreted line-by-line; we're just telling Verilog what we want stored in our flip-flops at the rising edge of the next clock cycle, so it makes sense to use the parallel `<=` assignment operator.

```Verilog
    // this is a counter that rolls over at the value 0xc7 (199 in decimal).
    module counter(input            clk,
                   output reg [7:0] cnt);
    reg [7:0] cnt_next;
    always @* begin
        if (cnt == 8'hc8) begin
            cnt_next = 8'h00;
        end else begin
            cnt_next = cnt + 8'h01;
        end
    end

    // we can choose the posedge (or negedge) of any signal, but it should be a clock signal, not
    // some random result of a combinational calculation.
    always @(posedge clk) begin
        // inside here, we just take the "next value" for our counter that we derived from our
        // combinational always @* block and assign it to "cnt" on every rising edge of "clock".
        cnt <= cnt_next;
    end
```