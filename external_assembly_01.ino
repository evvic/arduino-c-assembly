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

uint8_t get_serial_value() {
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

  Serial.print("Enter players power level: ");
  while (!Serial.available()); // Wait for input
  powerLevel = get_serial_value();
  Serial.println(powerLevel);

  Serial.print("Enter players lives left: ");
  while (!Serial.available()); // Wait for input
  livesLeft = get_serial_value();
  Serial.println(livesLeft);

  int16_t level = PlayerFitness();

  sprintf(stringBuffer, "External Assembly PlayerFitness() = %d", level);
  Serial.println(stringBuffer);

  delay(100);
}
