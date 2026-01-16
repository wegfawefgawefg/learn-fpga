`timescale 1ns/1ps
// "Hello world" for FPGA: toggle a LED at a slow, visible rate.
module hello (
    // Clock input (e.g., 12 MHz or 100 MHz depending on your board).
    input  wire clk,
    // Synchronous reset: when high, reset all state on the next clock edge.
    input  wire reset,
    // LED output.
    output reg  led
);
    // Divider sets how many clock cycles before toggling the LED.
    // Small value is fast in simulation; real hardware would use a much larger value.
    localparam integer DIVIDER = 5;
    // Counter tracks clock cycles up to DIVIDER-1.
    reg [31:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            // Reset state.
            counter <= 0;
            led <= 1'b0;
        end else begin
            if (counter == DIVIDER - 1) begin
                // Reached the divider: reset counter and flip the LED.
                counter <= 0;
                led <= ~led;
            end else begin
                // Keep counting clock cycles.
                counter <= counter + 1;
            end
        end
    end
endmodule
