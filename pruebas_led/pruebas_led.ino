#include <Adafruit_NeoPixel.h>

#define PIN_NEO_PIXEL  7
#define NUM_PIXELS     6

Adafruit_NeoPixel neoPixel(NUM_PIXELS, PIN_NEO_PIXEL, NEO_GRB + NEO_KHZ800);

void setup() {
  neoPixel.begin(); 
}

void loop() {
  neoPixel.clear();
  neoPixel.setPixelColor(0, neoPixel.Color(0, 255, 0));
  neoPixel.setPixelColor(3, neoPixel.Color(255, 0, 0));
  neoPixel.show();
  delay(500);
  neoPixel.clear();
  delay(500);
  neoPixel.show();
}
