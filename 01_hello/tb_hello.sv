`timescale 1ns/1ps

// Testbench: creates a fake clock and reset, then watches the LED toggle.
module tb_hello;
    // Clock and reset are "regs" in a testbench because we drive them.
    reg clk = 1'b0;
    reg reset = 1'b1;
    // LED is a wire because it's driven by the DUT.
    wire led;

    // 100 MHz clock (10 ns period). Every 5 ns, invert the clock.
    always #5 clk <= ~clk;

    // Instantiate the design under test (DUT).
    hello dut (
        .clk(clk),
        .reset(reset),
        .led(led)
    );

    initial begin
        // Tell the simulator to write a waveform file.
        $dumpfile("hello.vcd");
        $dumpvars(0, tb_hello);

        // Hold reset for a few clock cycles.
        repeat (3) @(posedge clk);
        reset = 1'b0;

        // Run for a bit so we can see LED toggles in the waveform.
        repeat (30) @(posedge clk);
        $display("Done. led=%0d", led);
        $finish;
    end
endmodule
