`timescale 1ns/1ps

// Testbench: toggle input and watch delayed output.
module tb_delay_chain;
    reg in_sig = 1'b0;
    wire out_sig;

    delay_chain dut (
        .in_sig(in_sig),
        .out_sig(out_sig)
    );

    initial begin
        $dumpfile("delay_chain.vcd");
        $dumpvars(0, tb_delay_chain);

        #5  in_sig = 1'b1;
        #20 in_sig = 1'b0;
        #20 in_sig = 1'b1;
        $display("Final: in=%0d out=%0d", in_sig, out_sig);
        #50 $finish;
    end
endmodule
