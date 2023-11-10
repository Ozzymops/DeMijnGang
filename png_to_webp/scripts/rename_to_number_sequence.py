import os
from pathlib import Path

# check if dir is empty
def dir_check(path):
    if len(os.listdir(path)) == 0:
        return False
    return True

def main():
    increment = 1
    path_output = os.path.abspath("../../output/")
    
    # check if any files exist
    if (dir_check(path_output) == False):
        print("> Output directory is empty. Cancelling...")
        return
        
    print("> Renaming images...")
    for image in os.listdir(path_output):
        if image.endswith(".webp"):
            old_name = path_output + "\\" + image
            new_name = path_output + "\\" + (str(increment).zfill(5) + ".webp")
            os.rename(old_name, new_name)
            print(f"> Renamed {old_name} -> {new_name}")
            increment += 1
            
    print("> Images successfully renamed.")

main()