#include <Arduino.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <avr/pgmspace.h>

using namespace std;


// External functions from assembly
// Declaring as "C" functions instead of C++ due to C++ trying to give the functions unique names
extern "C"
{
  int16_t Multiply(int16_t x, int16_t y);
  void DigitalSetASM(int8_t port, int8_t bit);
  void DigitalClrASM(int8_t port, int8_t bit);
  void TurnLEDOn();
  void TurnLEDOff();
  void SetLED(int8_t state);
  int8_t PrimeNth(int8_t number);
  int16_t PlayerFitness();
}

char stringBuffer[80];

volatile int16_t x = 1;
volatile int16_t y = 1;

int16_t get_serial_value() {
  String inputString = "";
  delay(100); // need to delay because the while loop will finish before receiving the end of the buffer

  while (Serial.available()) {
    char inChar = Serial.read();
    if (inChar >= '0' && inChar <= '9') {
      inputString += inChar;
    } else if (inChar == '\n') {
      // Serial.println("Received line feed");
      break; // End of input
    } else {
      Serial.println("Invalid input. Please enter a 1-byte integer.");
      inputString = "";
      break;
    }
  }

  return inputString.toInt();
}

void setup() {
  // initialize serial port
  Serial.begin(115200);
  Serial.print("\n\rIn Setup()...\n\r");

}

void loop() {
  Serial.print("\n\r");

  Serial.print("Enter multiplicand: ");
  while (!Serial.available()); // Wait for input
  x = get_serial_value();
  Serial.println(x);

  Serial.print("Enter multiplier: ");
  while (!Serial.available()); // Wait for input
  y = get_serial_value();
  Serial.println(y);
  
  int16_t product = Multiply(x, y);
  sprintf(stringBuffer, "ASM Mulitply: %d x %d = %d", x, y, product);
  Serial.println(stringBuffer);
}
