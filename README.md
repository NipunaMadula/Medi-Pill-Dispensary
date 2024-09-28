# Medi_Pill_Dispensary

Medi_Pill_Dispensary is a smart pill distribution system designed to streamline medication management by ensuring efficient and accurate medication dispensing. This project leverages Flutter for mobile app development, a web interface for management, and Arduino for hardware control, allowing real-time inventory tracking and enhanced supply chain management. Firebase is used for real-time database management, connecting both the mobile app and the web interface to the Arduino hardware for seamless communication.

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Tech Stack](#tech-stack)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Screenshots](#screenshots)
7. [Video Demo](#video-demo)
8. [Future Enhancements](#future-enhancements)
9. [Challenges](#challenges)
10. [Lessons Learned](#lessons-learned)
11. [Contributing](#contributing)
12. [License](#license)
13. [Contact](#contact)

---

## Overview
Medi_Pill_Dispensary aims to reduce errors in medication dispensing while improving the efficiency of managing medical supplies. The system integrates:

- **Mobile Application**: Developed with Flutter, it allows patients and caregivers to track medication schedules and communicate with the system.
- **Web Interface**: Provides administrative control over inventory, medication details, and user accounts. This interface is also connected to Firebase for real-time updates.
- **Firebase Database**: Handles real-time data exchange between the mobile app, the web interface, and the Arduino hardware.
- **Arduino**: Controls the hardware to dispense pills based on scheduled times and commands received from the Firebase database.

---

## Features
- **Real-time Inventory Tracking**: Tracks and updates medication stock automatically via Firebase, accessible from both mobile and web platforms.
- **Automated Pill Dispensing**: Ensures accurate and timely distribution of medication.
- **Mobile Notifications**: Sends reminders to patients and caregivers regarding medication schedules.
- **Web-based Management**: Provides admins with control over medication stock, distribution logs, and real-time updates, all connected through Firebase.
- **Data Encryption**: Ensures that sensitive medical data is securely handled.
- **Firebase-Connected System**: Both the mobile app and web interface use Firebase to pass values to the Arduino hardware for accurate dispensing.

---

## Tech Stack
- **Mobile Application**: Flutter (Dart)
- **Backend**: PHP, MySQL (for the web interface)
- **Frontend**: HTML, CSS, JavaScript
- **Hardware**: Arduino (with Firebase integration)
- **Database**: Firebase (for real-time data exchange between mobile, web, and Arduino)
- **Version Control**: Git

---

## Installation

### Prerequisites
- Flutter installed ([Flutter Installation Guide](https://flutter.dev/docs/get-started/install)).
- PHP and MySQL installed on your local machine.
- Firebase project set up ([Firebase Setup Guide](https://firebase.google.com/docs/web/setup)).
- Arduino IDE for programming the hardware components.

### Steps
1. Clone the repository:
    ```bash
    git clone https://github.com/NipunaMadula/Medi_Pill_Dispensary.git
    ```
2. Navigate to the project directory:
    ```bash
    cd Medi_Pill_Dispensary
    ```
3. Install the Flutter dependencies:
    ```bash
    flutter pub get
    ```
4. Set up Firebase:
    - Create a Firebase project and add the necessary configuration files (google-services.json for Android, GoogleService-Info.plist for iOS).
    - Configure Firebase Realtime Database and set up rules for both mobile and web access.
5. Set up the database for the web interface:
    - Import the `db.sql` file into your MySQL database.
    - Configure the database credentials in the `config.php` file.
6. Connect the Arduino to Firebase:
    - Upload the Arduino code from the `Arduino Code` directory, which contains Firebase configuration to connect with both the mobile app and web interface.

---

## Usage

### Mobile App:
- Open the app on your mobile device to monitor medication schedules, receive notifications, and communicate with the Arduino system via Firebase.
- Register and log in to access your personalized dashboard.

### Web Interface:
- Admins can manage medication stocks, track user activity, and set dispensing schedules through the web interface. The interface is connected to Firebase for real-time updates and data sync.

### Hardware (Arduino):
- The Arduino will communicate with Firebase to receive commands for dispensing pills based on the schedule set from the mobile app or web interface.

---

Got it! Here’s the specific section for the screenshots formatted as you requested:

---

## Screenshots

- **Mobile Interfaces**:  
  <div style="display: flex; flex-wrap: wrap;">
      <img src="https://github.com/NipunaMadula/Medi-Pill-Dispensary/blob/main/Screenshots/ss5.png?raw=true" alt="Register Form" width="150" style="margin-right: 5px; margin-bottom: 20px;" />
      <img src="https://github.com/NipunaMadula/Medi-Pill-Dispensary/blob/main/Screenshots/ss2.png?raw=true" alt="Login Form" width="150" style="margin-right: 5px; margin-bottom: 20px;" />
      <img src="https://github.com/NipunaMadula/Medi-Pill-Dispensary/blob/main/Screenshots/ss3.png?raw=true" alt="Order" width="150" style="margin-right: 5px; margin-bottom: 20px;" />
      <img src="https://github.com/NipunaMadula/Medi-Pill-Dispensary/blob/main/Screenshots/ss9.png?raw=true" alt="Bill" width="150" />
  </div>

- **Web Interfaces**:  
 <div>
    <div style="margin-bottom: 20px;">
        <img src="https://github.com/NipunaMadula/Medi-Pill-Dispensary/blob/main/Screenshots/ss6.png?raw=true" alt="Register Form" width="500" />  <!-- Adjusted width -->
    </div>
    <div style="margin-bottom: 20px;">
        <img src="https://github.com/NipunaMadula/Medi-Pill-Dispensary/blob/main/Screenshots/ss7.png?raw=true" alt="Login Form" width="500" />  <!-- Adjusted width -->
    </div>
    <div>
        <img src="https://github.com/NipunaMadula/Medi-Pill-Dispensary/blob/main/Screenshots/ss8.png?raw=true" alt="Order" width="500" />  <!-- Adjusted width -->
    </div>
</div>



---

## Video Demo
- A demonstration video showcasing the full functionality of the Medi_Pill_Dispensary system can be found at: [Video Demo Link](https://youtu.be/4kR7lVQ4qes)
---

## Future Enhancements
- **Advanced Analytics**: Incorporating machine learning algorithms for predictive analysis based on user data, such as medication adherence trends and inventory needs.
- **Voice Commands Integration**: Adding voice commands to allow patients to interact with the system using smart home devices like Google Home or Alexa.
- **Medication Identification**: Introducing a feature where users can scan a QR code on medication bottles to verify details via the mobile app.

---

## Challenges
- **Real-time Sync Issues**: Maintaining real-time synchronization between the mobile app, web interface, and Arduino hardware through Firebase was a challenging aspect.
- **Hardware Constraints**: Balancing between software implementation and hardware constraints, especially in ensuring timely dispensing of pills by the Arduino device.
- **Error Handling in Multi-platform Integration**: Ensuring smooth communication between the mobile app, web interface, and Arduino, handling potential errors and connection drops effectively.

---

## Lessons Learned
- **Firebase Integration**: Gained a deeper understanding of integrating Firebase with both mobile and web applications for real-time updates.
- **Cross-Platform Development**: Learned how to ensure that both the mobile app (Flutter) and the web interface communicate efficiently with a single backend system.
- **Hardware-Software Interface**: Enhanced skills in integrating software with hardware systems like Arduino for real-time automation and control.

---

## Contributing
Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a new branch:
    ```bash
    git checkout -b feature/your-feature-name
    ```
3. Commit your changes:
    ```bash
    git commit -m "Add your message"
    ```
4. Push to the branch:
    ```bash
    git push origin feature/your-feature-name
    ```
5. Open a Pull Request.

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

## Contact
For any inquiries or further information, feel free to reach out:

- **Name**: Nipuna Madula
- **Email**: [nipunamadula2001@gmail.com](mailto:nipunamadula2001@gmail.com)
- **LinkedIn**: [Nipuna Madula on LinkedIn](https://www.linkedin.com/in/nipunamadula/)
