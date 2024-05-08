#include <Adafruit_NeoPixel.h>

const int PIN_NEO_PIXEL_1 = 7;
const int PIN_NEO_PIXEL_2 = 11;
const int NUM_LEDS = 12;

const float SoundSpeed = 340.0;
const int NUM_SENSORS = 4;
const int PIN_ECHO[NUM_SENSORS] = {2, 4, 8, 13};
const int PIN_TRIGGER[NUM_SENSORS] = {5, 6, 10, 11};

Adafruit_NeoPixel neoPixel(NUM_LEDS, PIN_NEO_PIXEL_1, NEO_GRB + NEO_KHZ800);
int intensity = 50, r = 0, g = 0, b = 0; // 0-255
float distance[NUM_SENSORS];
int ledArray[NUM_LEDS];

void setup() {
  neoPixel.begin();

  Serial.begin(9600);
  for (int i = 0; i < NUM_SENSORS; i++) {
    pinMode(PIN_ECHO[i], INPUT);
    pinMode(PIN_TRIGGER[i], OUTPUT);
  }
}

void loop() {
  for (int i = 0; i < NUM_SENSORS; i++) {
      measureDistance(i);
      delay(100);
    }
    printer(distance);

    char ledChar[24];
    Serial.readBytesUntil('\n', ledChar, sizeof(ledChar));
    String ledString = String(ledChar);

    for (int i = 0; i < ledString.length(); i = i + 2) {
      ledArray[i/2] = ledString.charAt(i);
    }

  changeLeds();

  delay(600);
}

void changeLeds(){
  neoPixel.clear();
  for (int led = 0; led < NUM_LEDS; led++) {
    if(ledArray[led] == 0){
      r = 0;
      g = intensity;
    }else{
      r = intensity;
      g = 0;
    }
    neoPixel.setPixelColor(led, neoPixel.Color(r, g, b));
  }
  neoPixel.show();
}

void measureDistance(int sensorIndex) {
  digitalWrite(PIN_TRIGGER[sensorIndex], LOW);
  delayMicroseconds(2);
  digitalWrite(PIN_TRIGGER[sensorIndex], HIGH);
  delayMicroseconds(8);
  digitalWrite(PIN_TRIGGER[sensorIndex], LOW);
  unsigned long duration = pulseIn(PIN_ECHO[sensorIndex], HIGH);
  distance[sensorIndex] = duration * 0.5 * SoundSpeed / 10000.0;
}

void printer(float dist[]) {
  Serial.print(dist[0]);
  Serial.print(",");
  Serial.print(dist[1]);
  Serial.print(",");
  Serial.print(dist[2]);
  Serial.print(",");
  Serial.println(dist[3]);
}