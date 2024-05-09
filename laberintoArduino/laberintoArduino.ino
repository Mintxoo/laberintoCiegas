#include <Adafruit_NeoPixel.h>

const int PIN_NEO_PIXEL_1 = 7;
const int PIN_NEO_PIXEL_2 = 11;
const int NUM_LEDS = 6;

const float SoundSpeed = 340.0;
const int NUM_SENSORS = 4;
const int PIN_ECHO[NUM_SENSORS] = {2, 4, 8, 13};
const int PIN_TRIGGER[NUM_SENSORS] = {5, 6, 10, 11};

Adafruit_NeoPixel ledStrip1(NUM_LEDS+2, PIN_NEO_PIXEL_1, NEO_GRB + NEO_KHZ800);
Adafruit_NeoPixel ledStrip2(NUM_LEDS+2, PIN_NEO_PIXEL_2, NEO_GRB + NEO_KHZ800);

int intensity = 50, r = 0, g = 0, b = 0; // 0-255
float distance[NUM_SENSORS];
int ledArray[NUM_LEDS*2];

void setup() {
  ledStrip1.begin();
  ledStrip1.begin();

  Serial.begin(9600);
  for (int i = 0; i < NUM_SENSORS; i++) {
    pinMode(PIN_ECHO[i], INPUT);
    pinMode(PIN_TRIGGER[i], OUTPUT);
  }

  ledStrip1.clear();
  ledStrip2.clear();
  ledStrip1.show();
  ledStrip2.clear();
}

void loop() {
  for (int i = 0; i < NUM_SENSORS; i++) {
      measureDistance(i);
      delay(100);
    }
    printer(distance);

    char ledChar[12];
    Serial.readBytesUntil('\n', ledChar, sizeof(ledChar));
    for (int i = 0; i < sizeof(ledChar); i++) {
      if (ledChar[i] == '1') {
        ledArray[i] = 1;
      } else if (ledChar[i] == '0') {
        ledArray[i] = 0;
      }
    }

  changeLeds();

  delay(600);
}

void changeLeds(){
  ledStrip1.clear();
  ledStrip2.clear();

  for (int led = 0; led < NUM_LEDS; led++) {
    //Serial.println(ledArray[led]);
    if(ledArray[led] == 0){
      r = 0;
      g = intensity;
    }else{
      r = intensity;
      g = 0;
    }
    ledStrip1.setPixelColor(led, ledStrip1.Color(r, g, b));
  }
  for (int led = 6; led < NUM_LEDS*2; led++) {
    if(ledArray[led] == 0){
      r = 0;
      g = intensity;
    }else{
      r = intensity;
      g = 0;
    }
    ledStrip2.setPixelColor(led, ledStrip2.Color(r, g, b));
  }

  ledStrip1.show();
  ledStrip2.show();
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