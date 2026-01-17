# 02 - Combinational Logic + Truth Table

Two inputs (`a`, `b`) drive three outputs: AND, OR, XOR. No clock.

## Truth table
```
a b | and or xor
0 0 |  0  0   0
0 1 |  0  1   1
1 0 |  0  1   1
1 1 |  1  1   0
```

## Files
- `comb.v` - Combinational logic module.
- `tb_comb.sv` - Testbench steps through all 4 input combos.
- `Makefile` - Builds and runs the sim with Verilator.

## Run the simulation
```bash
make sim
```

This produces `comb.vcd` for GTKWave.
