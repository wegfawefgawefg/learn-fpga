# 05 - VCD Raster (Image -> Waveform)

This script turns a grayscale image into a VCD waveform. Each image row is a
signal, and each pixel column is a time slice. Pixel brightness maps to a
toggle count within the slice (darker pixels toggle more).

## Install
```bash
uv sync
```

## Run
```bash
uv run main.py images/cow.jpg out.vcd --width 64 --height 64 --steps 40
```

- `--steps` controls the time ticks per pixel column.
- `--timescale` controls VCD time units (default `1ns`).

Open `out.vcd` in GTKWave. Signals `row0..rowN` correspond to image rows.
