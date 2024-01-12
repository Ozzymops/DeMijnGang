# Hoe te gebruiken?
Gebruikmakend van de folderstructuur van de suite, plaats fotos van bestandstype `.png`, `.jpg` of `.jpeg` in de `input` folder, start `run.bat` en voer optie 1 uit. De foto's zullen geconverteerd naar `.webp` in de `output` folder terecht moeten komen.
![[Folderstructure.png]]
Extra opties: plaats folders in de `input` folder met de volgende sleutelwoorden in de naam voor extra opties.
- `no_resize`: foto's behouden de originele grootte en worden niet naar een maximum van 1024x1024px vergroot/verkleind

# Code
```
import os
import time
from pathlib import Path
from PIL import Image
from fnmatch import fnmatch

root_input = os.path.abspath('..\\..\\input')
root_output = os.path.abspath('..\\..\\output')

# check if dir is empty
def check_dir_empty(path):
    if len(os.listdir(path)) == 0:
        return False
    return True

# check if images with given extension exist
def check_extension_exists(path, extension):
    for file in os.listdir(path):
        if file.endswith(extension):
            return True
    return False

# input: resize images?
def input_resize():
    print("> Resize to a fixed height of 1080px? Exclude folders from resizing by adding 'no_resize' in the folder name. [Y/N]")
    return input("> ")

# convert files to webp
def convert_image(file, relative_path, resize):
    filename = Path(file).stem + ".webp"
    dir_path = os.path.join(root_output, relative_path)
    file_path = os.path.join(root_output, relative_path, filename)
    
    if not (os.path.isdir(dir_path)):
        os.makedirs(dir_path)

    converted_image = Image.open(file)

    if resize == True:
            if not 'no-resize' in file.lower():
                fixed_height = 1080
                height_percent = (fixed_height / float(converted_image.size[1]))
                width_size = int(float(converted_image.size[0]) * float(height_percent))
                converted_image = converted_image.resize((width_size, fixed_height), Image.NEAREST)

    converted_image.save(file_path, optimize=True, quality=90)
    print(f"> Converted {file} to {filename}")
    global image_amount
    image_amount += 1

# main
def main():
    start_time = time.perf_counter()

    # check if any files exist
    if (check_dir_empty(root_input) == False):
        print("> Input directory is empty. Cancelling...")
        return

    # ask for input
    resize = False
    while True:
        resize_input = input_resize()
        if resize_input.lower() == 'y':
            resize = True
            break
        elif resize_input.lower() == 'n':
            resize = False
            break
        else:
            print("Input is not valid. Try again.")

    # convert images
    for path, subdirs, files in os.walk(root_input):
        for name in files:
            if fnmatch(name, '*.jpg'):
                adjusted_path = os.path.relpath(path).removeprefix("..\\..\\input\\")
                file = os.path.join(root_input, adjusted_path, name)
                convert_image(file, os.path.join(adjusted_path), resize)
            elif fnmatch(name, '*.jpeg'):
                adjusted_path = os.path.relpath(path).removeprefix("..\\..\\input\\")
                file = os.path.join(root_input, adjusted_path, name)
                convert_image(file, os.path.join(adjusted_path), resize)
            elif fnmatch(name, '*.png'):
                adjusted_path = os.path.relpath(path).removeprefix("..\\..\\input\\")
                file = os.path.join(root_input, adjusted_path, name)
                convert_image(file, os.path.join(adjusted_path), resize)

    stop_time = time.perf_counter()
    elapsed_time = stop_time - start_time
    print()
    print(f"> Conversion of {image_amount} images finished in {stop_time - start_time:0.1f} seconds.")

# execute
image_amount = 0
main()
```