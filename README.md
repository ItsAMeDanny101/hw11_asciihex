# hw11_asciihex
# CMSC 313 – HW #11: Print Out Data in ASCII Hex

Daniel Jalali  
Spring 2025

---

## What the program does
* This program reads eight hard‑coded bytes in `inputBuf` and then converst each byte to two **uppercase** ASCII hex characters.
* it also puts in a space after every byte except the last and then a newline.

An example run should look like:

```console
$ ./hw11translate2Ascii
83 6A 88 DE 9A C3 54 9A


## How to build & run the program

# Assemble by
nasm -f elf32 hw11_translate2Ascii.asm -o hw11_translate2Ascii.o

# You can then link the object file into an executable
gcc -m32 -nostdlib -o hw11translate2Ascii hw11_translate2Ascii.o

# then to execute and run the program do
./hw11translate2Ascii
