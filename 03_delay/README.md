# 03 - Artificial Propagation Delay

This demo uses explicit `#1` delays on a chain of NOT gates so you can *see* a signal arrive later in the waveform. This is for teaching only; real FPGA delays come from placement/routing, not `#` delays in synthesizable code.

## Files
- `delay_chain.v` - 10-stage inverter chain with 1 ns delay per stage.
- `tb_delay_chain.sv` - Toggles input and dumps a VCD.
- `Makefile` - Builds and runs the sim with Verilator.

## Run
```bash
make sim
```

Open `delay_chain.vcd` in GTKWave and compare `in_sig` vs `out_sig`.
