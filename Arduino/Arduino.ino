// Includes the Servo library
#include <Servo.h>

// Defines Trigger (trig) and Echo pins of the Ultrasonic Sensor
const int trig = 12;
const int echo = 13;

// Defines LED pins
const int LED1 = 8;
const int LED2 = 7;
const int LED3 = 3;
const int LED4 = 5;
const int LED5 = 4;

// Defines the buzzer pin
const int buzzerPin = 9;

// Variables for the duration and the distance
long duration;
long distance;
float new_delay = 500;
Servo myServo; // Creates a servo object for controlling the servo motor

void setup() {
  // Initialize pins as INPUT or OUTPUT
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  pinMode(LED4, OUTPUT);
  pinMode(LED5, OUTPUT);
  pinMode(buzzerPin, OUTPUT);
  
  // Initialize Serial communication for debugging
  Serial.begin(9600);
  
  // Attach the servo motor to pin 2
  myServo.attach(2);
}

void loop() {
  // Rotates the servo motor from 0 to 360 degrees
  for (int i = 0; i <= 360; i++) {
    myServo.write(i);
    delay(30);
    distance = calculateDistance(); // Calls a function for calculating the distance measured by the Ultrasonic sensor for each degree
    glow_beep();
    Serial.print(i); // Sends the current degree into the Serial Port
    Serial.print(","); // Sends addition character right next to the previous value needed later in the Processing IDE for indexing
    Serial.print(distance); // Sends the distance value into the Serial Port
    Serial.print("."); // Sends addition character right next to the previous value needed later in the Processing IDE for indexing
  }
  
  // Repeats the previous lines from 360 to 0 degrees
  for (int i = 360; i >= 0; i--) {
    myServo.write(i);
    delay(30);
    distance = calculateDistance();
    glow_beep();
    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
}

// Function for calculating the distance measured by the Ultrasonic sensor
int calculateDistance() {
  digitalWrite(trig, HIGH);
  delayMicroseconds(1000);
  digitalWrite(trig, LOW);
  duration = pulseIn(echo, HIGH);
  distance = (duration / 2) / 28.5;
  return distance;
}

// Function for controlling LEDs and buzzer based on distance
void glow_beep() {
  if (distance >= 1 && distance <= 10) {
    digitalWrite(LED1, HIGH);
    digitalWrite(LED2, HIGH);
    digitalWrite(LED3, HIGH);
    digitalWrite(LED4, HIGH);
    digitalWrite(LED5, HIGH);
    digitalWrite(buzzerPin, HIGH);
    delay(new_delay / 5);
    digitalWrite(buzzerPin, LOW);
  } else {
    digitalWrite(LED5, LOW);
    digitalWrite(buzzerPin, LOW);
  }
  
  if (distance >= 11 && distance <= 20) {
    digitalWrite(LED1, HIGH);
    digitalWrite(LED2, HIGH);
    digitalWrite(LED3, HIGH);
    digitalWrite(LED4, HIGH);
    digitalWrite(buzzerPin, HIGH);
    delay(new_delay / 4);
    digitalWrite(buzzerPin, LOW);
  } else {
    digitalWrite(LED4, LOW);
    digitalWrite(buzzerPin, LOW);
  }
  
  if (distance >= 21 && distance <= 30) {
    digitalWrite(LED1, HIGH);
    digitalWrite(LED2, HIGH);
    digitalWrite(LED3, HIGH);
    digitalWrite(buzzerPin, HIGH);
    delay(new_delay / 3);
    digitalWrite(buzzerPin, LOW);
  } else {
    digitalWrite(LED3, LOW);
    digitalWrite(buzzerPin, LOW);
  }
  
  if (distance >= 31 && distance <= 40) {
    digitalWrite(LED1, HIGH);
    digitalWrite(LED2, HIGH);
    digitalWrite(buzzerPin, HIGH);
    delay(new_delay / 2);
    digitalWrite(buzzerPin, LOW);
  } else {
    digitalWrite(LED2, LOW);
    digitalWrite(buzzerPin, LOW);
  }
  
  if (distance >= 41 && distance <= 50) {
    digitalWrite(LED1, HIGH);
    digitalWrite(buzzerPin, HIGH);
    delay(new_delay);
    digitalWrite(buzzerPin, LOW);
  } else {
    digitalWrite(LED1, LOW);
    digitalWrite(buzzerPin, LOW);
  }
}
