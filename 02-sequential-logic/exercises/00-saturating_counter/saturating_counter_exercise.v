`timescale 1ns/100ps

/**
 * This counter should behave exactly like the counter in the examples folder, except when it gets
 * to a value of 8'hc7, it should saturate and stop counting up until the counter is reset.
 */
module saturating_counter(input clock,
                          input reset,

                          output reg [7:0] counter);

endmodule

module saturating_counter_exercise_tb();
    reg clock;
    reg reset;
    wire [7:0] counter_out;

    saturating_counter cnt(.clock(clock),
                           .reset(reset),
                           .counter(counter_out));

    // generate 1MHz clock
    always begin
        clock = 1'b0;
        #500;
        clock = 1'b1;
        #500;
    end

    integer i;
    initial begin
        $dumpfile("saturating_counter_exercise.vcd");
        $dumpvars(0, saturating_counter_exercise_tb);

        reset = 1'b1;
        #2500;
        reset <= 1'b0;

        for (i = 0; i < 8'hc7; i = i + 1) begin
            #100;
            if (i !== counter_out) begin
                $display("Test case failed at cycle %d. Check .vcd output for info.", i);
                $finish;
            end
            #900;
        end

        for (i = 0; i < 50; i = i + 1) begin
            #100;
            if (8'hc7 !== counter_out) begin
                $display("Test case failed at cycle %d. Check .vcd output for info.", i + 8'hc7);
                $finish;
            end
            #900;
        end

        reset = 1'b1;
        #2000;
        reset <= 1'b0;

        for (i = 0; i < 8'hc7; i = i + 1) begin
            #100;
            if (i !== counter_out) begin
                $display("Test case failed at cycle %d. Check .vcd output for info.", i);
                $finish;
            end
            #900;
        end

        for (i = 0; i < 50; i = i + 1) begin
            #100;
            if (8'hc7 !== counter_out) begin
                $display("Test case failed at cycle %d. Check .vcd output for info.", i + 8'hc7);
                $finish;
            end
            #900;
        end

        reset = 1'b1;
        #2000;
        reset <= 1'b0;

        for (i = 0; i < 8'd30; i = i + 1) begin
            #100;
            if (i !== counter_out) begin
                $display("Test case failed at cycle %d. Check .vcd output for info.", i);
                $finish;
            end
            #900;
        end

        #100;
        reset = 1'b1;
        #1900;
        reset <= 1'b0;
        for (i = 0; i < 8'd30; i = i + 1) begin
            #100;
            if (i !== counter_out) begin
                $display("Test case failed at cycle %d. Check .vcd output for info.", i);
                $finish;
            end
            #900;
        end

        $finish;
    end

endmodule
