import os
from termcolor import colored
from PIL import Image
import sys

""" python script to optimze images from the assets directory in a flutter app"""


def optimize_image(image_path):
    img = Image.open(image_path)
    img.save(image_path, optimize=True)


def format_size(size):
    # Helper function to format file size in human-readable format
    power = 2**10
    n = 0
    power_labels = {0: '', 1: 'K', 2: 'M', 3: 'G', 4: 'T'}
    while size > power:
        size /= power
        n += 1
    return f"{size:.2f} {power_labels[n]}B"


def find_and_optimize_images():
    current_dir = os.getcwd()
    asset_dir = os.path.join(current_dir, "assets")
    if not os.path.isdir(asset_dir):
        print("No 'assets' directory found in current directory")
        return

    for subdir, dirs, files in os.walk(asset_dir):
        for file in files:
            if file.endswith(('.png', '.jpg', '.jpeg', '.gif')):
                image_path = os.path.join(subdir, file)
                rel_path = os.path.relpath(image_path, asset_dir)

                # Get original file size and format it
                orig_size = os.path.getsize(image_path)
                orig_size_str = format_size(orig_size)

                # Optimize the image and get optimized file size
                optimize_image(image_path)
                opt_size = os.path.getsize(image_path)
                opt_size_str = format_size(opt_size)

                # Print the relative path and file sizes side by side in respective colors
                print(
                    f"{colored(rel_path, 'green')} ({colored(orig_size_str, 'red')} -> {colored(opt_size_str, 'yellow')})")


if __name__ == '__main__':
    find_and_optimize_images()