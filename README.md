# IMPORTANT NOTE :
I am archiving this repository as of now as the main api(NASA Mars Rover API) I used to develop this project is not availabe on the NASA api portal.
In future I will look into the project and will update the project with new features.

# CosmosPedia - Space Exploration App

![CosmosPedia Logo](assets/logo.png) <!-- Add your logo path here if available -->

CosmosPedia is a comprehensive Flutter application that brings the wonders of space exploration to your fingertips. Leveraging NASA's public APIs, this app provides real-time astronomical data, stunning imagery, and detailed information about celestial events and space missions.

## Table of Contents
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Configuration](#configuration)
- [API Usage](#api-usage)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

## Features

### 1. Home Screen
- **Latest Space News**: Curated content from NASA's APIs
- **Featured Images**: Astronomy Picture of the Day (APOD) with detailed explanations
- **Refreshable Content**: Pull-to-refresh for latest updates

### 2. Mars Rover Explorer
- **Rover Selection**: Browse images from Curiosity, Opportunity, and Spirit rovers
- **Photo Gallery**: View high-resolution Mars surface photos
- **Filtering**: Filter by date and camera type
- **Photo Details**: View detailed information about each image

### 3. Asteroids Tracker
- **Near-Earth Objects**: Real-time data about asteroids approaching Earth
- **Hazard Indicators**: Visual indicators for potentially hazardous asteroids
- **Detailed Views**: Orbit data, size comparisons, and close approach information

### 4. Space Weather Dashboard
- **Coronal Mass Ejections (CMEs)**: Track solar eruptions and their potential impact
- **Visual Analytics**: Interactive charts showing CME statistics
- **Real-time Data**: Current space weather conditions

### 5. User Profile
- **Personalization**: Customizable display name
- **Help Center**: Comprehensive FAQs and support
- **Legal Information**: Terms, conditions, and privacy policy

### 6. Authentication
- **Secure Sign-In**: Firebase Authentication
- **Account Management**: Password reset functionality
- **Profile Customization**: Update personal information

## Technology Stack

### Frontend
- **Flutter**: Cross-platform framework (supports Android and iOS)
- **State Management**: Flutter Bloc for predictable state management
- **UI Components**: Custom reusable widgets with Material 3 design
- **Localization**: Multi-language support (currently English)

### Backend & APIs
- **Firebase**: Authentication and user management
- **NASA APIs**:
    - Astronomy Picture of the Day (APOD)
    - Mars Rover Photos
    - Near-Earth Object Web Service (NeoWs)
    - Space Weather Database Of Notifications, Knowledge, Information (DONKI)

### Additional Packages
- `firebase_core`: Firebase integration
- `flutter_bloc`: State management
- `intl`: Date/number formatting
- `photo_view`: Image zooming capability
- `table_calendar`: Date picker for rover photos
- `fl_chart`: Data visualization for space weather

## Project Structure

```
lib/
├── app.dart                # Main app configuration
├── main.dart               # App entry point with Bloc/Repository providers
├── blocs/                  # Business logic components
├── config/
│   ├── routes.dart         # App navigation routes
│   └── theme.dart          # Light/dark theme configurations
├── data/                   # Data models and repositories
├── l10n/                   # Localization files
└── ui/
    ├── components/         # Reusable UI components
    └── screens/            # App feature screens
        ├── asteroids_screen/       # Asteroid tracking
        ├── home_screen/            # Main dashboard
        ├── my_profile/             # User settings
        ├── news_screen/            # Space news
        ├── rover_screen/           # Mars rover explorer
        ├── sign_in_screen/         # Authentication
        ├── sign_up_screen/         # User registration
        └── space_weather/          # Solar activity monitoring
```

## Installation

1. **Prerequisites**:
    - Flutter SDK (latest stable version)
    - Dart SDK
    - Android Studio/Xcode (for emulators)
    - Firebase account (for authentication)

2. **Setup**:
   ```bash
   git clone https://github.com/your-username/cosmospedia.git
   cd cosmospedia
   flutter pub get
   ```

3. **Firebase Configuration**:
    - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files
    - Enable Email/Password authentication in Firebase Console

4. **Run the app**:
   ```bash
   flutter run
   ```

## Configuration

### Environment Variables
Create a `.env` file in the root directory with your NASA API key:
```
NASA_API_KEY=your_api_key_here
```

### Firebase Setup
1. Create a new Firebase project
2. Add Android and iOS apps to your Firebase project
3. Download the configuration files and place them in the appropriate directories:
    - Android: `android/app/google-services.json`
    - iOS: `ios/Runner/GoogleService-Info.plist`

## API Usage

CosmosPedia uses several NASA APIs:

1. **APOD API**: For daily astronomy images
    - Endpoint: `https://api.nasa.gov/planetary/apod`

2. **Mars Rover Photos API**: For Mars surface images
    - Endpoint: `https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos`

3. **NeoWs API**: For asteroid data
    - Endpoint: `https://api.nasa.gov/neo/rest/v1/feed`

4. **DONKI API**: For space weather data
    - Endpoint: `https://api.nasa.gov/DONKI/CME`

All API keys should be managed through Firebase Environment Configurations for security.

## Screenshots

<!-- Add your screenshots here with descriptions -->
![Home Screen](screenshots/home.png)
*Home screen with featured space images and news*

![Mars Rover](screenshots/rover.png)
*Mars rover photo gallery with filtering options*

![Asteroids](screenshots/asteroids.png)
*Asteroid tracking with hazard indicators*

![Space Weather](screenshots/weather.png)
*Space weather analytics dashboard*

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

---

**CosmosPedia** - Explore the universe from your pocket. Developed with ❤️ for space enthusiasts.
