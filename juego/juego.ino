/*#include <FastLED.h>

// How many leds in your strip?
#define NUM_LEDS 11

#define DATA_PIN 3*/

const float SoundSpeed = 340.0; // Velocidad del sonido en metros por segundo
const int NUM_SENSORS = 4;
const int PIN_ECHO[NUM_SENSORS] = {2, 4, 8, 13}; // Pines de los sensores de eco
const int PIN_TRIGGER[NUM_SENSORS] = {5, 6, 10, 11}; // Pines de los sensores de trigger

float distance[NUM_SENSORS];

void setup() {
  Serial.begin(9600);
  for (int i = 0; i < NUM_SENSORS; i++) {
    pinMode(PIN_ECHO[i], INPUT);
    pinMode(PIN_TRIGGER[i], OUTPUT);
  }
}

void loop() {
  for (int i = 0; i < NUM_SENSORS; i++) {
    measureDistance(i);
    printer(i + 1, distance[i]);
    delay(100); // Espera entre mediciones para evitar interferencias
  }
  delay(1000);
  Serial.println("");
}

void measureDistance(int sensorIndex) {
  digitalWrite(PIN_TRIGGER[sensorIndex], LOW);
  delayMicroseconds(2);
  digitalWrite(PIN_TRIGGER[sensorIndex], HIGH);
  delayMicroseconds(10);
  digitalWrite(PIN_TRIGGER[sensorIndex], LOW);
  unsigned long duration = pulseIn(PIN_ECHO[sensorIndex], HIGH);
  distance[sensorIndex] = duration * 0.5 * SoundSpeed / 10000.0; // Convertir a centímetros
}

void printer(int sensor, float dist) {
  Serial.print(sensor);
  Serial.print(": ");
  Serial.print(dist);
  Serial.println(" cm");
}

/*#include <Servo.h>

Servo servo;  // Crea un objeto de tipo Servo para controlar el servo
int pinServo = 5;

#include <Adafruit_NeoPixel.h>

#define PIN_NEO_PIXEL  2   // Arduino pin that connects to NeoPixel
#define NUM_PIXELS     10  // The number of LEDs (pixels) on NeoPixel
#define DELAY_INTERVAL 500

Adafruit_NeoPixel neoPixel(NUM_PIXELS, PIN_NEO_PIXEL, NEO_GRB + NEO_KHZ800);

void setup() {
  neoPixel.begin(); // INITIALIZE NeoPixel strip object (REQUIRED)
  servo.attach(pinServo);
}

void loop() {
  neoPixel.clear(); // set all pixel colors to 'off'. It only takes effect if pixels.show() is called
  // turn pixels to green one by one with delay between each pixel
  for (int pixel = 0; pixel < NUM_PIXELS; pixel++) { // for each pixel
    

    servo.write((pixel)*(180/NUM_PIXELS));
    neoPixel.setPixelColor(pixel, neoPixel.Color(0, 255, 0)); // it only takes effect if pixels.show() is called
    neoPixel.show();   // send the updated pixel colors to the NeoPixel hardware.

    delay(DELAY_INTERVAL); // pause between each pixel
  }

  for (int pixel = NUM_PIXELS-1; pixel >= 0; pixel--) { // for each pixel
    
    servo.write((pixel)*(180/NUM_PIXELS));
    neoPixel.setPixelColor(pixel, neoPixel.Color(255, 0, 0)); // it only takes effect if pixels.show() is called
    neoPixel.show();   // send the updated pixel colors to the NeoPixel hardware.

    delay(DELAY_INTERVAL); // pause between each pixel
  }

  pixel = 0
  for (int pixel = 0; pixel < NUM_PIXELS; pixel++) {
  pixel++
  // turn off all pixels for two seconds
  neoPixel.clear();
  neoPixel.show(); // send the updated pixel colors to the NeoPixel hardware.
    
}*/