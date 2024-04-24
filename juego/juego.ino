#include <FastLED.h>

// How many leds in your strip?
#define NUM_LEDS 11

#define DATA_PIN 3

const float SoundSpeed = 34000.0; // Sound speed constant in cm/s
const int PIN_TRIGGER = 3;
const int PIN_ECHO = 2;
float distance;
 
void setup(){
  Serial.begin(9600);
  pinMode(PIN_TRIGGER, OUTPUT);
  pinMode(PIN_ECHO, INPUT);
}

void loop(){
  startTrigger();
  
  unsigned long time = pulseIn(PIN_ECHO, HIGH);
  
  distance = time * 0.000001 * SoundSpeed / 2.0;
  Serial.print(distance);
  Serial.print("cm");
  Serial.println();
  delay(1000);
}
 
void startTrigger(){
  digitalWrite(PIN_TRIGGER, LOW); //Trigger LOW and wait 2 ms 
  delayMicroseconds(2);
  
  digitalWrite(PIN_TRIGGER, HIGH); //Trigger HIGH and wait 10ms
  delayMicroseconds(10);
  
  digitalWrite(PIN_TRIGGER, LOW);  //Trigger starts LOW
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