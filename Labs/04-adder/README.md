1. A half adder has two inputs A and B and two outputs Carry and Sum. Comlpete the half adder truth table. Draw a logic diagram of both output functions.

    | **B** | **A** | **Carry** | **Sum** |
    | :-: | :-: | :-: | :-: |
    | 0 | 0 | 0 | 0 |
    | 0 | 1 | 0 | 1 |
    | 1 | 0 | 0 | 1 |
    | 1 | 1 | 1 | 0 |

2. A full adder has three inputs and two outputs. The two inputs are A, B, and Carry input. The outputs are Carry output and Sum. Comlpete the full adder truth table and draw a logic diagram of both output functions.

    | **Cin** | **B** | **A** | **Cout** | **Sum** |
    | :-: | :-: | :-: | :-: | :-: |
    | 0 | 0 | 0 | 0 | 0 |
    | 0 | 0 | 1 | 0 | 1 |
    | 0 | 1 | 0 | 0 | 1 |
    | 0 | 1 | 1 | 1 | 0 |
    | 1 | 0 | 0 | 0 | 1 |
    | 1 | 0 | 1 | 1 | 0 |
    | 1 | 1 | 0 | 1 | 0 |
    | 1 | 1 | 1 | 1 | 1 |

3. Find the relationship between half adder and full adder logic diagrams.
The first half of the full adder logic giagram is the same as the half adder diagram.
The first half also looks like the logic diagram for AND (Carry)/EXOR (Sum), the second half is OR/EXNOR.
Also if we the the sum logic diagram we can see that Cin switches between EXOR and EXNOR functionality.
4. See schematic of the [CPLD expansion board](../../Docs/cpld_expansion.pdf) and find out the connection of LEDs, push buttons, and slide switches.
