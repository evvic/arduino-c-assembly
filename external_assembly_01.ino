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

volatile int16_t x = 2;
volatile int16_t y = 5;

void setup() {
  // initialize serial port
  Serial.begin(115200);
  Serial.print("\n\rIn Setup()...\n\r");

  // sprintf(stringBuffer, "\nCalling external ASM multiply (%d, %d) = %d", x, y, Multiply(x, y));
  // cannot use printf because there is no connected screen
  // sprintf puts the constructed string into the stringBuffer variable

  // Serial.print(stringBuffer);



}

void loop() {

  TurnLEDOn();
  delay(250);

  TurnLEDOn();
  delay(250);

}
