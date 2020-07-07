`timescale 1ns/100ps

/**
 * You might be familiar with "switch bouncing": when you press a physical pushbutton, because of
 * the elasticity of the metal contacts, instead of going cleanly from 'open' to 'closed', the
 * switch mechanism with snap shut and then vibrate, causing a few milliseconds of rapid
 * oscillations between 'open' and 'closed'. This is impreceptable to humans, but will cause
 * issues in edge-triggered digital applications (because multiple rising and falling edges will
 * be generated for a single button-press)
 *
 * Info on switch bounce can be found here (https://en.wikipedia.org/wiki/Switch#Contact_bounce).
 *
 * You should make a state machine that will output a '1' if the input has been at a stable '1'
 * for the last 63-ish clock cycles, and will output a '0' if the input has been at a stable '0' for
 * the last 63-ish cycles. If the switch has bounced between a '1' and a '0' sometime in the last 63-ish
 * cycles, you should keep the debounced output unchanged.
 *
 * (63-ish: anywhere from like, 60 to 65 clock cycles is fine. The button might change mid-clock
 *  cycle, so that requirement is lax).
 *
 * My testbench will give your module a 'reset' signal at the very beginning.
 */

module button_debouncer(input clock,
                        input reset,
                        input button,

                        output reg debounced_button);
    //----------------------------------------------------------------
    // your code here
    //----------------------------------------------------------------
endmodule

module button_debouncer_exercise_tb();
    reg clock;
    reg reset;
    reg button_bouncy;
    wire debounced_button;

    button_debouncer bd(.clock(clock),
                        .reset(reset),
                        .button(button_bouncy),
                        .debounced_button(debounced_button));

    always begin
        clock = 1'b0;
        #500;
        clock = 1'b1;
        #500;
    end

    integer i, j, k, rando;
    reg button_bouncy_start;
    initial begin
        $dumpfile("button_debouncer_exercise.vcd");
        $dumpvars(0, button_debouncer_exercise_tb);

        reset = 1'b1;
        button_bouncy = 1'b0;
        #2000;
        reset <= 1'b0;

        // specific test cases
        #64000;
        #100;
        if (debounced_button !== 1'b0) begin
            $display("Test case failed. Check .vcd output for info");
            $finish;
        end
        #900;

        button_bouncy = 1'b1;
        #32000;
        if (debounced_button !== 1'b0) begin
            $display("Test case failed. Check .vcd output for info");
            $finish;
        end
        #35000;
        if (debounced_button !== 1'b1) begin
            $display("Test case failed. Check .vcd output for info");
            $finish;
        end

        button_bouncy = 1'b0;
        #5000;
        button_bouncy = 1'b1;
        #100;
        if (debounced_button !== 1'b1) begin
            $display("Test case failed. Check .vcd output for info");
            $finish;
        end
        #900;

        // generate 100 random tests
        for (i = 0; i < 100; i = i + 1) begin
            button_bouncy_start = button_bouncy;

            for (j = 0; j < 6; j = j + 1) begin
                button_bouncy = ~button_bouncy;
                rando = ($urandom % 20) + 2;
                for (k = 0; k < rando; k = k + 1) begin
                    #100;
                    if (debounced_button !== button_bouncy_start) begin
                        $display("Test case failed. Check .vcd output for info");
                        $finish;
                    end
                    #900;
                end
            end
            button_bouncy = ~button_bouncy_start;
            for (k = 0; k < 60; k = k + 1) begin
                #100;
                if (debounced_button !== button_bouncy_start) begin
                    $display("Test case failed. Check .vcd output for info");
                    $finish;
                end
                #900;
            end
            #6000;
            #100;
            if (debounced_button !== button_bouncy) begin
                $display("Test case failed. Check .vcd output for info");
                $finish;
            end
            #900;
            #60000;
        end
        $finish;
    end
endmodule
