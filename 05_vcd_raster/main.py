#!/usr/bin/env python3
import argparse
from pathlib import Path

from PIL import Image


def parse_args():
    p = argparse.ArgumentParser(
        description="Render a grayscale image into a VCD waveform (PWM per pixel)."
    )
    p.add_argument("image", help="Input image path")
    p.add_argument("output", help="Output VCD path")
    p.add_argument("--width", type=int, default=64, help="Output width in pixels")
    p.add_argument("--height", type=int, default=64, help="Output height in pixels")
    p.add_argument(
        "--steps",
        type=int,
        default=40,
        help="Time ticks per pixel column (higher = finer toggle spacing)",
    )
    p.add_argument(
        "--timescale",
        default="1ns",
        help="VCD timescale (e.g. 1ns, 10ps)",
    )
    return p.parse_args()


def load_grayscale(path, width, height):
    img = Image.open(path).convert("L")
    img = img.resize((width, height), Image.NEAREST)
    return img


def gray_to_toggles(gray, max_toggles):
    # Darker pixel => more toggles.
    return int(round((255 - gray) * max_toggles / 255.0))


def make_signal_ids(n):
    # VCD identifiers can be any non-whitespace string; use s0, s1, ...
    return [f"s{i}" for i in range(n)]


def build_events(img, steps):
    width, height = img.size
    pixels = img.load()

    ids = make_signal_ids(height)
    current = [0] * height
    events = {}
    max_toggles = max(steps // 2, 1)

    def add_event(t, row, val):
        if current[row] == val:
            return
        current[row] = val
        events.setdefault(t, []).append((row, val))

    for x in range(width):
        base_t = x * steps
        for y in range(height):
            gray = pixels[x, y]
            toggles = gray_to_toggles(gray, max_toggles)
            if toggles <= 0:
                add_event(base_t, y, 0)
                continue

            # Toggle repeatedly within this pixel slice.
            # Spread edges across the slice; darker pixels have more toggles.
            edges = []
            for k in range(1, 2 * toggles + 1):
                t = base_t + int(round(k * steps / (2 * toggles + 1)))
                if t < base_t + steps:
                    edges.append(t)
            edges = sorted(set(edges))

            val = 0
            for t in edges:
                val ^= 1
                add_event(t, y, val)
            add_event(base_t + steps, y, 0)

    return events, ids, width, height


def write_vcd(path, events, ids, timescale):
    with open(path, "w", encoding="ascii") as f:
        f.write("$version vcd_raster.py $end\n")
        f.write(f"$timescale {timescale} $end\n\n")
        f.write("$scope module top $end\n")
        for row, sig_id in enumerate(ids):
            f.write(f"$var wire 1 {sig_id} row{row} $end\n")
        f.write("$upscope $end\n")
        f.write("$enddefinitions $end\n\n")

        # Initialize all signals low at time 0.
        f.write("#0\n")
        for sig_id in ids:
            f.write(f"0{sig_id}\n")

        for t in sorted(events.keys()):
            f.write(f"#{t}\n")
            for row, val in events[t]:
                f.write(f"{val}{ids[row]}\n")


def main():
    args = parse_args()

    if args.width <= 0 or args.height <= 0 or args.steps <= 0:
        raise SystemExit("width, height, and steps must be > 0")

    img = load_grayscale(args.image, args.width, args.height)
    events, ids, width, height = build_events(img, args.steps)

    out_path = Path(args.output)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    write_vcd(out_path, events, ids, args.timescale)

    total_time = width * args.steps
    print(
        f"Wrote {out_path} ({width}x{height}, steps={args.steps}, total_time={total_time})"
    )


if __name__ == "__main__":
    main()
