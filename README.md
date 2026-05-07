# SAFECORE

**SAFECORE - Real-World Emergency Assistant**

A fully offline Flutter + GetX mobile application designed to provide essential emergency information, AI-powered assistance, and preparedness tools when you need them most — even without an internet connection.

## 📋 Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Modules](#modules)
- [Local AI](#local-ai)
- [Data Layer](#data-layer)
- [Themes & Design](#themes--design)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Build & Run](#build--run)
- [State Management](#state-management)

## ✨ Features

- **Offline-First**: All core data and AI capabilities work without internet connectivity
- **Emergency Mode**: Quick-access emergency procedures with step-by-step guidance
- **Disaster Information**: Comprehensive natural disaster database with detailed information
- **Medical Emergency**: Medical emergency guides and health information at your fingertips
- **AI Assistant**: On-device AI assistant powered by local model inference
- **Preparedness Checklist**: Interactive checklist for emergency preparedness
- **Dark Theme**: Modern dark UI optimized for low-light conditions
- **Responsive Design**: Adaptive layout for various screen sizes

## 🛠 Tech Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter ^3.9.2 |
| Language | Dart ^3.9.2 |
| State Management | GetX ^4.6.5 |
| Local Storage | Hive ^2.2.3 + hive_flutter |
| Preferences | shared_preferences ^2.2.0 |
| Notifications | flutter_local_notifications ^17.1.0 |
| Internationalization | intl ^0.19.0 |
| Icons | font_awesome_flutter ^11.0.0 |

## 🏗 Architecture

SAFECORE follows a modular architecture pattern with clear separation of concerns:

```
lib/
├── main.dart                 # Application entry point
├── modules/                  # Feature modules
│   ├── home/
│   ├── medical/
│   ├── disaster/
│   ├── emergency/
│   ├── preparation/
│   ├── ai_assistant/
│   └── settings/
├── core/                     # Core infrastructure
│   ├── themes/               # App theming system
│   ├── data/                 # Data layer (models, repositories)
│   ├── navigation/           # Navigation controller & shell
│   └── ai_local/             # Local AI service
└── routes/                   # Route definitions
```

### Module Structure

Each module follows a consistent pattern:
- `views/` - UI components and screens
- Models and controllers are co-located within the module or in `core/`

## 📦 Modules

### Home
Main dashboard providing quick access to all emergency features, displayed as a grid of action cards.

### Medical Emergency
Comprehensive medical emergency guides including:
- First aid procedures
- Common medical emergencies
- Step-by-step treatment guides
- Searchable medical information

### Disaster Information
Natural disaster database covering:
- Earthquakes and tsunamis
- Volcanic eruptions
- Floods and landslides
- Fire hazards
- Detailed prevention and response guides

### Emergency Mode
Simplified emergency interface with:
- One-tap emergency access
- Guided step-by-step procedures
- Visual emergency indicators
- Optimized for high-stress situations

### Preparedness
Interactive preparedness tools:
- Emergency checklist
- Supply list management
- Family communication plan
- Customizable preparedness levels

### AI Assistant
On-device AI assistant that provides:
- Natural language emergency queries
- Context-aware recommendations
- Offline AI inference
- Conversational emergency guidance

### Settings
Application configuration:
- Theme customization
- Notification preferences
- Data management
- Language settings

## 🤖 Local AI

SAFECORE includes a built-in AI assistant that operates fully offline:

```
lib/core/ai_local/
├── ai_local.dart              # Module exports
├── config/
│   └── ai_model_config.dart   # Model configuration
├── controllers/
│   └── ai_controller.dart     # AI state management
├── models/
│   ├── ai_context.dart        # AI conversation context
│   ├── ai_response.dart       # AI response structure
│   └── emergency_step.dart    # Emergency step model
├── services/
│   ├── local_ai_service.dart  # Local inference service
│   └── ai_prompt_builder.dart # Prompt generation
├── widgets/
│   └── ai_bottom_sheet.dart   # AI chat UI component
└── bindings/
    └── llama_ffi_bindings.dart # FFI bindings for local model
```

## 💾 Data Layer

SAFECORE uses Hive as its primary NoSQL database:

```
lib/core/data/
├── data.dart                   # Module exports
├── models/
│   ├── disaster_model.dart     # Disaster data model
│   ├── medical_model.dart      # Medical data model
│   └── checklist_model.dart    # Checklist data model
└── repositories/
    └── data_repository.dart    # Centralized data access
```

### Data Features
- **Hive Boxes**: Organized by feature domain
- **Repository Pattern**: Centralized data access layer
- **Pre-loaded Data**: Essential data bundled with the app
- **Extensible**: Easy to add new data sources

## 🎨 Themes & Design

Comprehensive theming system with consistent design tokens:

```
lib/core/themes/
├── app_theme.dart              # Theme configuration
├── themes.dart                 # Theme exports
├── colors.dart                 # Color palette
├── typography.dart             # Text styles
├── widgets/
│   ├── app_button.dart         # Consistent button styles
│   ├── app_card.dart           # Card component styles
│   ├── app_icon.dart           # Icon styling
│   └── app_text.dart           # Text widget helpers
```

### Design Principles
- **Dark-first**: Default dark theme optimized for emergency use
- **High Contrast**: Accessible color combinations
- **Consistent Spacing**: Unified spacing scale
- **Material 3**: Modern Material Design components

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2
- Android Studio / XCode (for mobile development)
- VS Code with Flutter extension (optional)

### Installation

```bash
# Clone the repository
git clone https://github.com/JooAndriano/safecore.git
cd safecore

# Install dependencies
flutter pub get

# Run the app
flutter run

# Run on specific platform
flutter run -d android        # Android device/emulator
flutter run -d chrome         # Web browser
```

### Build

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📁 Project Structure

```
safecore/
├── android/                  # Android platform files
├── assets/                   # Static assets
│   ├── fonts/               # Custom fonts (Roboto)
│   ├── icons/               # App icons
│   ├── images/              # Image assets
│   ├── models/              # AI model files
│   └── *.html               # HTML documentation pages
├── ios/                     # iOS platform files
├── lib/                     # Source code
│   ├── main.dart            # Entry point
│   ├── core/                # Core infrastructure
│   ├── modules/             # Feature modules
│   └── routes/              # Route definitions
├── test/                    # Unit and widget tests
├── pubspec.yaml             # Dart/Flutter dependencies
└── README.md                # This file
```

## 📱 State Management

SAFECORE uses **GetX** for state management, providing:

- **Reactive State**: Automatic UI updates on state changes
- **Dependency Injection**: Lightweight and efficient DI container
- **Route Management**: Typed navigation with parameters
- **Middleware**: Built-in middleware support
- **Performance**: Minimal boilerplate with maximum control

### GetX Usage Patterns

```dart
// Controller definition
class MyController extends GetxController {
  var counter = 0.obs;
  
  void increment() => counter++;
}

// Dependency injection
Get.put(MyController());

// Navigation with parameters
Get.toNamed('/route-name', arguments: {'key': 'value'});
```

## 📄 License

This project is published as `publish_to: 'none'` and can be used freely.

## 🔗 Links

- [Flutter Documentation](https://docs.flutter.dev/)
- [GetX Documentation](https://pub.dev/packages/get)
- [Hive Database](https://pub.dev/packages/hive)

---

**SAFECORE** — Stay prepared. Stay safe. Stay connected.