#!/usr/bin/env python3
"""
Image Stitch - Combine multiple images into one composite image.
"""

import argparse
import sys
from pathlib import Path
from PIL import Image


def parse_color(color_str: str) -> tuple:
    """Parse color string to RGB tuple."""
    color_str = color_str.strip()
    if color_str.startswith('#'):
        # Hex color
        hex_str = color_str.lstrip('#')
        if len(hex_str) == 6:
            return tuple(int(hex_str[i:i+2], 16) for i in (0, 2, 4))
        elif len(hex_str) == 3:
            return tuple(int(hex_str[i]*2, 16) for i in range(3))
    # Try named colors
    try:
        from PIL import ImageColor
        return ImageColor.getrgb(color_str)
    except:
        pass
    # Default to white
    return (255, 255, 255)


def stitch_vertical(images, spacing=0, align='center', background=(255, 255, 255)):
    """Stitch images vertically."""
    # Find max width
    max_width = max(img.width for img in images)
    total_height = sum(img.height for img in images) + spacing * (len(images) - 1)

    # Create result image
    result = Image.new('RGB', (max_width, total_height), background)

    # Paste images
    y_offset = 0
    for img in images:
        # Calculate x position based on alignment
        if align == 'left':
            x_offset = 0
        elif align == 'right':
            x_offset = max_width - img.width
        else:  # center
            x_offset = (max_width - img.width) // 2

        result.paste(img, (x_offset, y_offset))
        y_offset += img.height + spacing

    return result


def stitch_horizontal(images, spacing=0, align='center', background=(255, 255, 255)):
    """Stitch images horizontally."""
    # Find max height
    max_height = max(img.height for img in images)
    total_width = sum(img.width for img in images) + spacing * (len(images) - 1)

    # Create result image
    result = Image.new('RGB', (total_width, max_height), background)

    # Paste images
    x_offset = 0
    for img in images:
        # Calculate y position based on alignment
        if align == 'top':
            y_offset = 0
        elif align == 'bottom':
            y_offset = max_height - img.height
        else:  # center
            y_offset = (max_height - img.height) // 2

        result.paste(img, (x_offset, y_offset))
        x_offset += img.width + spacing

    return result


def main():
    parser = argparse.ArgumentParser(description='Stitch multiple images together')
    parser.add_argument('output', help='Output file path')
    parser.add_argument('inputs', nargs='+', help='Input image files')
    parser.add_argument('--direction', choices=['vertical', 'horizontal'], default='vertical',
                        help='Stitch direction (default: vertical)')
    parser.add_argument('--spacing', type=int, default=0,
                        help='Pixels between images (default: 0)')
    parser.add_argument('--align', choices=['left', 'center', 'right', 'top', 'bottom'],
                        default='center',
                        help='Alignment: left/center/right for vertical, top/center/bottom for horizontal')
    parser.add_argument('--background', default='#FFFFFF',
                        help='Background color for spacing area (default: #FFFFFF)')

    args = parser.parse_args()

    # Validate alignment matches direction
    if args.direction == 'vertical' and args.align in ['top', 'bottom']:
        print(f"Warning: '{args.align}' alignment is for horizontal stitching. Using 'center' instead.", file=sys.stderr)
        args.align = 'center'
    elif args.direction == 'horizontal' and args.align in ['left', 'right']:
        print(f"Warning: '{args.align}' alignment is for vertical stitching. Using 'center' instead.", file=sys.stderr)
        args.align = 'center'

    # Load images
    images = []
    for input_path in args.inputs:
        try:
            img = Image.open(input_path)
            # Convert to RGB if necessary (handles RGBA, grayscale, etc.)
            if img.mode != 'RGB':
                img = img.convert('RGB')
            images.append(img)
        except Exception as e:
            print(f"Error loading {input_path}: {e}", file=sys.stderr)
            sys.exit(1)

    # Parse background color
    background = parse_color(args.background)

    # Stitch images
    if args.direction == 'vertical':
        result = stitch_vertical(images, args.spacing, args.align, background)
    else:
        result = stitch_horizontal(images, args.spacing, args.align, background)

    # Save result
    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    result.save(output_path)

    print(f"Saved stitched image to {output_path}")
    print(f"Size: {result.width}x{result.height}")


if __name__ == '__main__':
    main()
