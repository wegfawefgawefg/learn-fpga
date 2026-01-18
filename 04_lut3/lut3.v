`timescale 1ns/1ps

// 3-input LUT (lookup table). Output is selected by {a,b,c} index.
module lut3 #(
    // Truth table for Y indexed by {A,B,C} as a 3-bit number.
    // Default example: Y = majority(A,B,C)
    // index:  ABC
    //   0:   000 -> 0
    //   1:   001 -> 0
    //   2:   010 -> 0
    //   3:   011 -> 1
    //   4:   100 -> 0
    //   5:   101 -> 1
    //   6:   110 -> 1
    //   7:   111 -> 1
    parameter [7:0] LUT = 8'b1110_1000
)(
    input  wire a,
    input  wire b,
    input  wire c,
    output wire y
);
    wire [2:0] idx = {a,b,c};
    assign y = LUT[idx];
endmodule
