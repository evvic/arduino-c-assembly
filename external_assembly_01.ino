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

volatile int16_t index = 0;

void setup() {
  // initialize serial port
  Serial.begin(115200);
  Serial.print("\n\rIn Setup()...\n\r");

}

void loop() {
  index = index % 16;

  int8_t prime = PrimeNth(index);

  sprintf(stringBuffer, "Assembly PrimeNth(%d) = %d", index, prime);

  Serial.println(stringBuffer);

  index++;

  delay(500);
}
