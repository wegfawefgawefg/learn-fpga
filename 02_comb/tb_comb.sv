`timescale 1ns/1ps

// Testbench: step through all input combinations and dump waves.
module tb_comb;
    reg a = 1'b0;
    reg b = 1'b0;
    wire y_and;
    wire y_or;
    wire y_xor;

    comb dut (
        .a(a),
        .b(b),
        .y_and(y_and),
        .y_or(y_or),
        .y_xor(y_xor)
    );

    task show;
        $display("a=%0d b=%0d | and=%0d or=%0d xor=%0d", a, b, y_and, y_or, y_xor);
    endtask

    initial begin
        $dumpfile("comb.vcd");
        $dumpvars(0, tb_comb);

        a = 0; b = 0; #5; show();
        a = 0; b = 1; #5; show();
        a = 1; b = 0; #5; show();
        a = 1; b = 1; #5; show();

        $finish;
    end
endmodule
