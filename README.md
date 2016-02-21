# TIgameoflife
John Conway's Game of a life for TI-83+ series calculators.
![screenshot](/screenshots/screenshot000.gif)

## Compilation
The source code for this program is hosted on [github](https://github.com/mortonsc/TIgameoflife "mortonsc/TIgameoflife").
To compile the program, you will need the following software:
* [SDCC](http://sdcc.sourceforge.net/ "SDCC") (Small Device C Compiler): compiler/assembler/linker
* [hex2bin](http://hex2bin.sourceforge.net/ "hex2bin"): converts output from SDCC to binary file
* [binpac8x.py](http://www.ticalc.org/archives/files/fileinfo/429/42915.html "binpac8x"): packages binary file into executable for the calculator

The included Makefile assumes all these programs are in your system path. On Linux, it may also be necessary to change the permissions
of binpac8x.py so you can execute it: `chmod +x binpac8x.py`.

### Linux
To compile:

    git clone https://github.com/mortonsc/TIgameoflife.git
    make
That's it!

### Windows
All the required software is available for Windows, but I haven't put together a compile script.
You'll have to either download a Windows port of make, and follow the Linux instructions,
or translate the Makefile to a batch script.

## Installation
Currently the only way to obtain an executable is to follow the compilation process above.
Once you've done that, upload `tigol.8xp` to your favorite emulator.
This project is still in development, so I wouldn't recommend running it on an actual calculator.
If you do, be warned that the program temporarily disables automatic power down,
so if you leave your calculator unattended while it is running it will keep going till it runs out of battery.

## How to Play
The program is called CONWAY on the calculator. To run, use the `Asm(` command (found in the catalog):

    Asm(prgmCONWAY
The program does not offer any way to edit the screen; the contents of your graph screen at the time you run the program
are used as the initial state. If you want to quickly create an interesting screen, you can use the `Draw->Text(` command
to print text to the screen.

When the program starts, it is paused. There are 3 possible actions:
* `Clear`: quits the program
* `-`: advances the game one step
* `+`: starts the game running

While the game is running, pressing `Enter` will pause it again. You will probably have to hold the button for a second
before the game pauses.
