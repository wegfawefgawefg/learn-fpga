`timescale 1ns/1ps

module tb_lut3;
    reg a = 0;
    reg b = 0;
    reg c = 0;
    wire y;

    lut3 dut(.a(a), .b(b), .c(c), .y(y));

    integer i;

    initial begin
        $dumpfile("lut3.vcd");
        $dumpvars(0, tb_lut3);

        for (i = 0; i < 8; i = i + 1) begin
            {a,b,c} = i[2:0];
            #10;
            $display("ABC=%b%b%b idx=%0d y=%b", a, b, c, i, y);
        end

        $finish;
    end
endmodule
