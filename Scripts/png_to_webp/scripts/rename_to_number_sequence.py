import os
from pathlib import Path

# check if dir is empty
def dir_check(path):
    if len(os.listdir(path)) == 0:
        return False
    return True

# ask to start from 0 or later number
def give_input():
    print("> Start from beginning or from specific number? [1/#]")
    return input("> ")

def main():
    increment = 1
    path_output = os.path.abspath("../../output/")
    
    # check if any files exist
    if (dir_check(path_output) == False):
        print("> Output directory is empty. Cancelling...")
        return
        
    # ask for input
    input_given = False
    while input_given == False:
        input = give_input()
        
        try:
            int(input)
        except ValueError:
            print("Input is not valid. Try again.")
               
        input_given = True
        if int(input) > 1:
            increment = int(input)
        
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