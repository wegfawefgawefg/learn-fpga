`timescale 1ns/1ps
// Artificial delay chain to visualize propagation in a sim.
module delay_chain (
    input  wire in_sig,
    output wire out_sig
);
    // 10 stages, each with 1 ns delay.
    wire [10:0] stage;
    assign stage[0] = in_sig;

    assign #1 stage[1]  = ~stage[0];
    assign #1 stage[2]  = ~stage[1];
    assign #1 stage[3]  = ~stage[2];
    assign #1 stage[4]  = ~stage[3];
    assign #1 stage[5]  = ~stage[4];
    assign #1 stage[6]  = ~stage[5];
    assign #1 stage[7]  = ~stage[6];
    assign #1 stage[8]  = ~stage[7];
    assign #1 stage[9]  = ~stage[8];
    assign #1 stage[10] = ~stage[9];

    assign out_sig = stage[10];
endmodule
