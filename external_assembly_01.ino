#include <Arduino.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <avr/pgmspace.h>

using namespace std;


// External functions from assembly
// Declaring as "C" functions instead of C++ due to C++ trying to give the functions unique names
extern "C" int16_t PlayerFitness();

// External values from Assembly
extern volatile uint8_t powerLevel;
extern volatile uint8_t livesLeft;

char stringBuffer[80];

volatile int16_t index = 0;

void setup() {
  // initialize serial port
  Serial.begin(115200);
  Serial.print("\n\rIn Setup()...\n\r");

}

void loop() {

  int16_t level = PlayerFitness();

  sprintf(stringBuffer, "External Assembly PlayerFitness() = %d", level);
  Serial.println(powerLevel);


  Serial.println(stringBuffer);

  delay(1000);
  index++;
}
