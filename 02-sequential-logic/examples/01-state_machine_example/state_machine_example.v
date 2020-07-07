`timescale 1ns/100ps

/**
 * This simple state machine holds output_a high for a fixed number of cycles, then output_b high
 * for a fixed number of cycles, then output_c high for a fixed number of cycles before keeping all
 * outputs low for a fixed number of cycles.
 *
 * If you cycled through its states super fast (say, give it a clock of 1MHz), it could be used to
 * light up an RGB LED with a constant solid color that's a mix of red, green, and blue. To make
 * the LED purple, program it to make it stay in the red and blue states for longer, and bypass the
 * green state entirely.
 *
 *        cycle_count < threshold              cycle_count < threshold        cycle_count < threshold
 *     cycle_count <- cycle_count + 1       cycle_count <- cycle_count + 1   cycle_count <- cycle_count + 1
 *            ┌─────┐                              ┌─────┐                              ┌─────┐
 *            V     │        cycle_count >         V     │        cycle_count >         V     │
 *    ┌─────────────┴───┐      threshold   ┌─────────────┴───┐      threshold   ┌─────────────┴───┐
 *    |'All outputs off'├─────────────────>|  'Output A on'  ├─────────────────>|  'Output B on'  │
 *    |      state      │ cycle_count <- 0 |      state      │ cycle_count <- 0 |      state      │
 *    └─────────────────┘                  └─────────────────┘                  └─────────────────┘
 *               ^                                                              cycle_count >   │
 *               │                                                                   threshold  │
 *               │                           cycle_count < threshold          cycle_count <- 0  │
 *               │                         cycle_count <- cycle_count + 1                       │
 *               │                                         ┌─────┐                              │
 *               │                                         V     │                              │
 *               │     cycle_count > threshold           ┌───────┴─────────┐                    │
 *               └───────────────────────────────────────┤  'Output C on'  │<───────────────────┘
 *                            cycle_count <- 0           │      state      │
 *                                                       └─────────────────┘
 */
`define OUTPUT_NONE_STATE (2'b00)
`define OUTPUT_A_STATE (2'b01)
`define OUTPUT_B_STATE (2'b10)
`define OUTPUT_C_STATE (2'b11)

`define OUTPUT_NONE_CYCLES (8'h20)
`define OUTPUT_A_CYCLES (8'h10)
`define OUTPUT_B_CYCLES (8'h08)
`define OUTPUT_C_CYCLES (8'h18)

module output_cycler_state_machine(input clock,
                                   input reset,

                                   output reg out_a,
                                   output reg out_b,
                                   output reg out_c);
    reg [1:0] state;
    reg [1:0] state_next;

    reg [7:0] cycle_counter;
    reg [7:0] cycle_counter_next;

    // logic for advancing the state machine and the cycle counter
    always @* begin
        if (reset) begin
            state_next = `OUTPUT_NONE_STATE;
            cycle_counter_next = 8'h00;
        end else begin // if (reset)
            case (state)
                `OUTPUT_NONE_STATE: begin
                    if (cycle_counter == `OUTPUT_NONE_CYCLES) begin
                        state_next = `OUTPUT_A_STATE;
                        cycle_counter_next = 8'h00;
                    end else begin
                        state_next = `OUTPUT_NONE_STATE;
                        cycle_counter_next = cycle_counter + 8'h1;
                    end
                end

                `OUTPUT_A_STATE: begin
                    if (cycle_counter == `OUTPUT_A_CYCLES) begin
                        state_next = `OUTPUT_B_STATE;
                        cycle_counter_next = 8'h00;
                    end else begin
                        state_next = `OUTPUT_A_STATE;
                        cycle_counter_next = cycle_counter + 8'h1;
                    end
                end

                `OUTPUT_B_STATE: begin
                    if (cycle_counter == `OUTPUT_B_CYCLES) begin
                        state_next = `OUTPUT_C_STATE;
                        cycle_counter_next = 8'h00;
                    end else begin
                        state_next = `OUTPUT_B_STATE;
                        cycle_counter_next = cycle_counter + 8'h1;
                    end
                end

                `OUTPUT_C_STATE: begin
                    if (cycle_counter == `OUTPUT_C_CYCLES) begin
                        state_next = `OUTPUT_NONE_STATE;
                        cycle_counter_next = 8'h00;
                    end else begin
                        state_next = `OUTPUT_C_STATE;
                        cycle_counter_next = cycle_counter + 8'h1;
                    end
                end
            endcase // case (state)
        end
    end

    always @(posedge clock) begin
        state <= state_next;
        cycle_counter <= cycle_counter_next;
    end

    // logic for driving the outputs based on the current state
    always @* begin
        out_a = (state == `OUTPUT_A_STATE) ? 1'b1 : 1'b0;
        out_b = (state == `OUTPUT_B_STATE) ? 1'b1 : 1'b0;
        out_c = (state == `OUTPUT_C_STATE) ? 1'b1 : 1'b0;
    end
endmodule


module state_machine_example_testbench();
    reg clock;
    reg reset;

    wire output_a;
    wire output_b;
    wire output_c;

    output_cycler_state_machine fsm(.clock(clock),
                                    .reset(reset),
                                    .out_a(output_a),
                                    .out_b(output_b),
                                    .out_c(output_c));

    always begin
        clock = 1'b0;
        #500;
        clock = 1'b1;
        #500;
    end

    initial begin
        $dumpfile("state_machine_example.vcd");
        $dumpvars(0, state_machine_example_testbench);

        reset = 1'b1;
        #2000;
        reset = 1'b0;

        // just wait for a bit, just long enough to cycle through all the states 2 or 3 times.
        #300000;

        reset = 1'b1;
        #2000;
        reset = 1'b0;

        #400000;

        $finish;
    end
endmodule
