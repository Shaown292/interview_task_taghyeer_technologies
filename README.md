

# Interview Task - Taghyeer Technologies

This is a **Flutter application** created as part of an interview task for **Taghyeer Technologies**. The app demonstrates a simple **login functionality** using a **dummy API**.

## Table of Contents

* [Overview](#overview)
* [Features](#features)
* [Tech Stack](#tech-stack)
* [Getting Started](#getting-started)
* [Usage](#usage)
* [Project Structure](#project-structure)
* [API](#api)
* [License](#license)

## Overview

This Flutter application allows users to log in using predefined credentials provided by a dummy API. It follows a simple architecture pattern and demonstrates API integration, state management, and UI design for a login screen.

## Features

* Login with **username and password**
* Simple and clean **UI/UX**
* **API integration** with dummy endpoints
* **State management** using clean architecture principles

## Tech Stack

* **Flutter**
* **Dart**
* **Dio** for API calls
* **Bloc / Provider** (whichever you implemented) for state management

## Getting Started

### Prerequisites

* Flutter SDK installed
* Android Studio / VS Code
* Internet connection (to access dummy API)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Shaown292/interview_task_taghyeer_technologies.git
   ```
2. Navigate to the project directory:

   ```bash
   cd interview_task_taghyeer_technologies
   ```
3. Get dependencies:

   ```bash
   flutter pub get
   ```
4. Run the app:

   ```bash
   flutter run
   ```

## Usage

1. Open the app on an emulator or physical device.
2. Enter the dummy credentials (for testing, see API section below).
3. Press **Login** to authenticate.
4. On successful login, you will see a welcome screen (or home page if implemented).

## Project Structure

```
lib/
├── data/
│   └── data_sources/    # Remote API calls
├── domain/
│   └── entities/        # Business entities
├── presentation/
│   └── screens/         # UI screens
└── main.dart            # Entry point
```

## API

This app uses the **Dummy JSON API** for login functionality.

* **Endpoint:** `https://dummyjson.com/auth/login`
* **Method:** POST
* **Request Body:**

  ```json
  {
    "username": "kminchelle",
    "password": "0lelplR"
  }
  ```
* **Response Example:**

  ```json
  {
    "id": 1,
    "username": "kminchelle",
    "email": "kminchelle@mail.com",
    "token": "some-jwt-token"
  }
  ```

## License

This project is for **educational purposes / interview task** and is **not licensed for commercial use**.



