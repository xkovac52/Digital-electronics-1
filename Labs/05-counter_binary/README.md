## Preparation tasks (done before the lab at home)

1. Calculate how many periods of clock signal with ![equation](https://latex.codecogs.com/gif.latex?f_%7Bclk%7D%20%3D%2010%5C%2C%5Ctext%7BkHz%7D) contain time intervals 10&nbsp;ms, 250&nbsp;ms, 500&nbsp;ms, and 1&nbsp;s. Write values in decimal, binary, and hexadecimal forms.

    &nbsp;
    
    ![equation](https://latex.codecogs.com/gif.latex?T_%7Bclk%7D%20%3D%20%5Cfrac%7B1%7D%7Bf_%7Bclk%7D%7D%20%3D) 1/10K = 0,1ms
    
    &nbsp;

    | **Freq** | **Time** | **Number of periods** | **Number of periods in binary** | **Number of periods in hexa** |
    | :-: | :-: | :-: | :-: | :-: |
    | 100&nbsp;Hz | 10&nbsp;ms | 100 | 1100100 | 64 |
    | 4&nbsp;Hz | 250&nbsp;ms | 2500 | 100111000100 | 9C4 |
    | 2&nbsp;Hz | 500&nbsp;ms | 5000 | 1001110001000 | 1388 |
    | 1&nbsp;Hz | 1&nbsp;sec | 10000 | 10011100010000 | 2710 |

2. See how to create a [synchronous operation](https://github.com/tomas-fryza/Digital-electronics-1/wiki/VHDL-cheat-sheet#processes) in the VHDL.
