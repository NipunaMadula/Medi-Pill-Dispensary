#include <Servo.h>
#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>
#include <ArduinoJson.h>

// Firebase project credentials
#define FIREBASE_HOST "medipill-87485-default-rtdb.firebaseio.com" // Replace with your Firebase project URL
#define FIREBASE_AUTH "thLtei5K7rBv8EqYhEjHSGHwQCANRDJO7mFppsNx"   // Replace with your Firebase database secret

// Wi-Fi credentials
#define WIFI_SSID "Samsung"        // Replace with your Wi-Fi SSID
#define WIFI_PASSWORD "12344321"   // Replace with your Wi-Fi password

// Create servo objects to control the servos
Servo servo1; // Panadol
Servo servo2; // Aspirin
Servo servo3; // Azee

// Initial position
int currentPos1 = 0;
int currentPos2 = 0;
int currentPos3 = 0;

void setup() {
  Serial.begin(9600); // Start Serial communication at 9600 baud rate

  // Connect to Wi-Fi
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.println("Connected to Wi-Fi");

  // Initialize Firebase
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);

  // Attach each servo to a specific GPIO pin on the NodeMCU
  servo1.attach(D1); // Connect servo1 to D1 (Panadol)
  servo2.attach(D2); // Connect servo2 to D2 (Aspirin)
  servo3.attach(D3); // Connect servo3 to D3 (Azee)

  // Move to initial position
  servo1.write(currentPos1);
  servo2.write(currentPos2);
  servo3.write(currentPos3);
}

void loop() {
  // Fetch medicine counts from Firebase
  if (Firebase.getInt("/Panadol")) {
    int panadolCount = Firebase.getInt("/Panadol");
    controlServo(servo1, panadolCount, currentPos1);
    Firebase.setInt("/Panadol", 0); // Reset count to 0 in Firebase
  }
  if (Firebase.getInt("/Aspirin")) {
    int aspirinCount = Firebase.getInt("/Aspirin");
    controlServo(servo2, aspirinCount, currentPos2);
    Firebase.setInt("/Aspirin", 0); // Reset count to 0 in Firebase
  }
  if (Firebase.getInt("/Azee")) {
    int azeeCount = Firebase.getInt("/Azee");
    controlServo(servo3, azeeCount, currentPos3);
    Firebase.setInt("/Azee", 0); // Reset count to 0 in Firebase
  }
  delay(5000); // Delay to reduce Firebase read frequency
}

void controlServo(Servo servo, int count, int &currentPos) {
  int angle = 0; // Default angle for 0 pills
  if (count > 0 && count <= 4) {
    angle = count * 45; // Set angle to 45, 90, 135, or 180 degrees based on count
  }

  if (currentPos < angle) {
    // Move servo to desired angle clockwise
    for (int pos = currentPos; pos <= angle; pos++) {
      servo.write(pos);
      delay(30); // Increased delay to allow slower servo movement
    }
  } else if (currentPos > angle) {
    // Move servo to desired angle counterclockwise
    for (int pos = currentPos; pos >= angle; pos--) {
      servo.write(pos);
      delay(30); // Increased delay to allow slower servo movement
    }
  }

  // Update current position
  currentPos = angle;

  delay(1000); // Allow servo to stay at the position for a moment

  // Move servo back to 0 position in the opposite direction
  if (currentPos > 0) {
    for (int pos = currentPos; pos >= 0; pos--) {
      servo.write(pos);
      delay(30); // Increased delay to allow slower servo movement
    }
    // Update current position
    currentPos = 0;
  }
}
