`timescale 1ns/100ps

module sum_example();
    ////////////////////////////////////////////////////////////////
    // Circuit

    // [7:0] is just like (7 downto 0) in VHDL. It tells us that the signal 'a' is 8 bits wide, and
    // that it's bits are numbered 0 through 7.
    reg [7:0] a;
    reg [7:0] b;

    // Note that result is one bit wider than a or b so that it can hold the carry.
    reg [8:0] result;

    always @* begin
        // Verilog has some built-in operators like addition, but of course, you could build these
        // operators up from 'nand' gates.
        result = a + b;
    end

    ////////////////////////////////////////////////////////////////
    // Testbench
    integer i;
    initial begin
        $dumpfile("sum_example.vcd");
        $dumpvars(0, sum_example);

        a = 8'hf0;
        b = 8'h0f;
        #10;

        a = 8'h33;
        b = 8'h55;
        #10;

        a = 8'h73;
        b = 8'hba;
        #10;

        a = 8'hff;
        b = 8'hff;
        #10;

        // we can also put a bunch of random integers into our adder
        for (i = 0; i < 50; i = i + 1) begin
            a = $random;
            b = $random;
            #10;
        end

        $finish;
    end
endmodule
