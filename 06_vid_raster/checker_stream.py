#!/usr/bin/env python3
import argparse
import sys
import time


def parse_args():
    p = argparse.ArgumentParser(
        description="Emit a moving checkerboard using PIX/HSYNC/VSYNC."
    )
    p.add_argument("--width", type=int, default=64, help="Frame width")
    p.add_argument("--height", type=int, default=64, help="Frame height")
    p.add_argument("--tile", type=int, default=8, help="Checker tile size")
    p.add_argument("--fps", type=float, default=10.0, help="Frames per second")
    p.add_argument("--frames", type=int, default=0, help="0 = run forever")
    return p.parse_args()


def emit_frame(width, height, tile, offset_x, offset_y, out):
    lines = []
    for y in range(height):
        for x in range(width):
            tx = (x + offset_x) // tile
            ty = (y + offset_y) // tile
            on = (tx + ty) % 2 == 0
            if on:
                lines.append("PIX 255 255 255\n")
            else:
                lines.append("PIX 0 0 0\n")
        lines.append("HSYNC 1\n")
        lines.append("HSYNC 0\n")
    lines.append("VSYNC 1\n")
    lines.append("VSYNC 0\n")
    out.write("".join(lines))
    out.flush()


def main():
    args = parse_args()
    if args.width <= 0 or args.height <= 0 or args.tile <= 0:
        raise SystemExit("width, height, and tile must be > 0")
    if args.fps < 0:
        raise SystemExit("fps must be >= 0")

    frame = 0
    delay = 0.0 if args.fps == 0 else 1.0 / args.fps
    while args.frames == 0 or frame < args.frames:
        offset = frame % (args.tile * 2)
        emit_frame(args.width, args.height, args.tile, offset, offset, sys.stdout)
        frame += 1
        if delay > 0:
            time.sleep(delay)


if __name__ == "__main__":
    main()
