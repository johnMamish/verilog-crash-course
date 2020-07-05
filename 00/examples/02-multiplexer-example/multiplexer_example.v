`timescale 1ns/100ps

module multiplexer_example();
    ////////////////////////////////////////////////////////////////
    // Circuit
    reg [7:0] a, b, c, d;
    reg [1:0] select;

    reg [7:0] mux_out;

    always @* begin
        // In Verilog, combinational logic can be expressed with the help of 'if else' statements.
        // These statements will ultimately result in something like a multiplexer being generated
        // in the actual hardware.
        if (select == 2'b00) begin
            mux_out = a;
        end else if (select == 2'b01) begin
            mux_out = b;
        end else if (select == 2'b10) begin
            mux_out = c;
        end else if (select == 2'b11) begin
            mux_out = d;
        end

        // It's worth pointing out that there are other, more idiomatic ways to do what I did above,
        // like with a case statement, for instance:
        //
        // case(select)
        //     2'b00: begin
        //         mux_out = a;
        //     end
        //
        //     2'b01: begin
        //         mux_out = b;
        //     end
        //
        //     2'b10: begin
        //         mux_out = c;
        //     end
        //
        //     2'b11: begin
        //         mux_out = d;
        //     end
        // endcase
        //
        // I just chose to use the 'if' statements to demonstrate how to use them.
    end

    ////////////////////////////////////////////////////////////////
    // Testbench
    integer i;
    initial begin
        $dumpfile("multiplexer_example.vcd");
        $dumpvars(0, multiplexer_example);

        // set up some default values as inputs to our mux.
        a = 8'haa;
        b = 8'hbb;
        c = 8'hcc;
        d = 8'hdd;

        // what a happy accident that 'a', 'b', 'c', and 'd' are all hexidecimal digits!

        select = 2'b00;
        #10;

        select = 2'b01;
        #10;

        select = 2'b10;
        #10;

        select = 2'b11;
        #10;

        #100;
        // we don't need to specify the values of select manually... we can also use a for loop!
        for (i = 0; i < 4; i = i + 1) begin
            #10;
            select = select + 2'b01;
        end

        $finish;
    end
endmodule
