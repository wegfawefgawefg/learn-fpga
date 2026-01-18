# 04 - 3-Input LUT

A LUT (lookup table) stores the truth table in a constant bit-vector.
The inputs form a 3-bit index into the table.

## Default truth table (majority)
```
a b c | y
0 0 0 | 0
0 0 1 | 0
0 1 0 | 0
0 1 1 | 1
1 0 0 | 0
1 0 1 | 1
1 1 0 | 1
1 1 1 | 1
```

## Files
- `lut3.v` - LUT module with a parameterized truth table.
- `tb_lut3.sv` - Testbench prints all 8 cases and dumps a VCD.
- `Makefile` - Builds and runs the sim with Verilator.

## Run
```bash
make sim
```

Open `lut3.vcd` in GTKWave to see the signals.
