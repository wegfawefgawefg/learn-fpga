# 01 - Hello (Blinking LED)

This is the FPGA equivalent of "hello world": a single LED toggles on a clock.

## Files
- `hello.v` - The DUT (device under test).
- `tb_hello.sv` - Simple simulation testbench.
- `Makefile` - Builds and runs the sim with Verilator.

## Run the simulation
```bash
make sim
```

This produces `hello.vcd` which you can open with a waveform viewer (e.g. `gtkwave`).

## Clean
```bash
make clean
```
