# Hoe te gebruiken?
Gebruikmakend van de folderstructuur van de suite, plaats bestanden in de `output` folder, start `run.bat` en voer optie 2 uit. Kies eventueel een nummer om vanaf te starten. De bestanden zullen hernoemd worden naar bijvoorbeeld `0001.png`, `0002.png`, etc. en in de `output` folder opnieuw terecht komen.
![[Folderstructure.png]]
Extra opties: plaats folders in de `output` folder met de volgende sleutelwoorden in de naam voor extra opties.
- `no_rename`: foto's behouden de originele naam en worden niet numeriek ingedeeld
# Code
```
import os
import time
from pathlib import Path
from PIL import Image
from fnmatch import fnmatch

root_input = os.path.abspath('..\\..\\output')

# check if dir is empty
def check_dir_empty(path):
    if len(os.listdir(path)) == 0:
        return False
    return True

# rename images with incrementing number
def rename_image(file, relative_path, increment):
    old_filename = file
    new_filename = os.path.join(root_input, relative_path, str(increment).zfill(5) + ".webp")
    os.rename(old_filename, new_filename)

# main
def main():
    start_time = time.perf_counter()

    # check if any files exist
    if (check_dir_empty(root_input) == False):
        print("> Input directory is empty. Cancelling...")
        return

    # rename images 
    increment = 1
    previous_path = ''

    for path, subdirs, files in os.walk(root_input):
        for name in files:
            if fnmatch(name, '*.webp'):       
                adjusted_path = os.path.relpath(path).removeprefix("..\\..\\output\\")
                
                if not 'no-rename' in adjusted_path:               
                    if not previous_path in adjusted_path:
                        increment = 1
                    previous_path = adjusted_path
                    
                    file = os.path.join(root_input, adjusted_path, name)
                    rename_image(file, adjusted_path, increment)
                    global image_amount
                    image_amount += 1                          
                    increment += 1

    stop_time = time.perf_counter()
    elapsed_time = stop_time - start_time
    print()
    print(f"> Conversion of {image_amount} images finished in {stop_time - start_time:0.1f} seconds.")

# execute
image_amount = 0
main()
```