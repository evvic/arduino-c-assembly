# arduino-c-assembly
C++ and assembly for working with an Arduino Uno R3
> [ARDUINO UNO R3 DOCUMENTATION](https://docs.arduino.cc/hardware/uno-rev3/)

### Connector Pinouts
![Arduino Uno R3 Connector Pinouts Image](assets/connector-pinouts.png)

## Multiplication program
- The git branch **MULTIPLICATION** shows how to use external assembly with C++ to write a multiplication program

## Assembly `Multiply` Function
- The function is defined in [`external_assembly_01.ino`](external_assembly_01.ino) as:
```C++
int16_t Multiply(int16_t x, int16_t y);
```
- Multiply takes 2 16-bit parameters, and returns a 16-bit value
    - The Arduino Uno registers size are 8 bits, therefore the parameters will take up 2 (adjacent) registers