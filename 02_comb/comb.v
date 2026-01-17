`timescale 1ns/1ps
// Combinational logic demo: two inputs drive three outputs.
module comb (
    input  wire a,
    input  wire b,
    output wire y_and,
    output wire y_or,
    output wire y_xor
);
    // Combinational logic updates immediately when inputs change.
    assign y_and = a & b;
    assign y_or  = a | b;
    assign y_xor = a ^ b;
endmodule
