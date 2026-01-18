# 06 - Video Raster (Scanout Prototype)

Goal: simulate a VGA-style scanout path and later drive it from FPGA logic.

Current state:
- `screenbuf/` is a tiny viewer that reads a text protocol from stdin.
- We can feed it scanline-style data (`PIX`, `HSYNC`, `VSYNC`) from Python.

Planned next steps:
- Add real VGA timing (porches + sync widths) and lock to a pixel clock.
- Replace text protocol with a faster binary stream.
- Drive the stream from a Verilog simulation to mimic an FPGA scanout core.

## Quick demo (checkerboard stream)

In one terminal:
```bash
cd /home/vega/Coding/Training/learn-fpga/06_vid_raster/screenbuf
cargo run --release
```

In another terminal:
```bash
cd /home/vega/Coding/Training/learn-fpga/06_vid_raster
python3 checker_stream.py --width 64 --height 64 --tile 8 --fps 10
```

This sends a moving checkerboard using the VGA-like text protocol.
