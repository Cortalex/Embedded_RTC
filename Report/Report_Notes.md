# Lab 1
## Ex 1
We found out that the diagonal of the matrix of the keypad goes from '*' to 'A' instead of going from '1' to 'D'. We used the same I2C protocol for both slaves. We saved in 2 different areas of memory the values of the registers of the keypad.
## Ex 2
We used the switch case because it was the fastest method to handle the situation. We worked with the indices of the matrix.
## Ex 3
Same i2c line, change address for the line sensor
## Ex 4
We simply used the structure of the polling to implement the interrupt. as deafult and if it's pressed a key that is not a number, we chosed to used a frequency of 1hz, a period of 1 s
## Ex 5
We used the same loop of the lab0. we have the pin which turns o, delay, turns of, delay. we impement a switch case that convert what we read form the keypad into a period in milliseconds.

# Lab2
