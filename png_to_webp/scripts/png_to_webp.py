import os
import time
from pathlib import Path
from PIL import Image

# check if dir is empty
def dir_check(path):
    if len(os.listdir(path)) == 0:
        return False
    return True

# check if files with extension exist
def extension_check(path, extension):
    for file in os.listdir(path):
        if file.endswith(extension):
            return True
    return False

# convert given images to .webp
def convert_to_webp(input, output):
    for image in input:
        new_filename = image.with_suffix(".webp").name
        destination = output + "\\" + str(new_filename)
        converted_image = Image.open(image)
        converted_image.save(destination, format="webp")
        print(f"> Converted {image.name} to {new_filename}")
        global image_amount
        image_amount += 1
       
def main():
    start_time = time.perf_counter()
    path_input = os.path.abspath("../../input/")
    path_output = os.path.abspath("../../output/")

    # check if any files exist
    if (dir_check(path_input) == False):
        print("> Input directory is empty. Cancelling...")
        return

    # .jpg
    if (extension_check(path_input, ".jpg")):
        print("> Starting conversion of images with file extension .jpg")
        path = Path(path_input).glob("**/*.jpg")
        convert_to_webp(path, path_output)
    else:
        print("> No images with file extension .jpg found, continuing...")
    
    # .png
    if (extension_check(path_input, ".png")):
        print()
        print("> Starting conversion of images with file extension .png")
        path = Path(path_input).glob("**/*.png")
        convert_to_webp(path, path_output)
    else:
        print("> No images with file extension .png found, continuing...")
    
    stop_time = time.perf_counter()
    elapsed_time = stop_time - start_time
    print()
    print(f"> Conversion of {image_amount} images finished in {stop_time - start_time:0.1f} seconds.")

# Execute
image_amount = 0
main()