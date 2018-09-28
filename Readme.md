# :moneybag: lottery - draw lottery numbers

This command line program draws lottery numbers for you using
a pseudo-random number generator. It is written in Ada.

## Installation

A makefile and a GNAT GPS project file is provided. Using the makefile,

    make
    make install

will compile the program and install it in `/usr/local/bin/lottery`.

## Usage

`lottery <i> <k>`

Draw i out of k numbers. The flag `-c <n>` will repeat the drawing
`<n>` times.

Good luck!

## Example

`lottery 5 50`

Draws 5 numbers out of the numbers between 1..50 (both inclusive).

## Future Plans

This repository is in final status and no changes are planned unless someone finds a bug.

