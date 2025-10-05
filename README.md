# 🚀 FluPilot CLI

**A lightweight and powerful CLI tool to scaffold Flutter projects faster with interactive package selection, auto-generated boilerplate, and clean project setup.**

[![License: ISC](https://img.shields.io/badge/License-ISC-blue.svg)](https://opensource.org/licenses/ISC)
[![GitHub Issues](https://img.shields.io/github/issues/ahmedali109/FluPilot-CLI)](https://github.com/ahmedali109/FluPilot-CLI/issues)
[![GitHub Repo stars](https://img.shields.io/github/stars/ahmedali109/FluPilot-CLI)](https://github.com/ahmedali109/FluPilot-CLI)

## 📖 Overview

FluPilot CLI streamlines Flutter development by providing an interactive command-line interface that automates project setup, package management, and boilerplate code generation. Whether you're building a simple app or a complex enterprise solution, FluPilot CLI helps you get started quickly with industry best practices baked in.

## ✨ Key Features

### 🎯 **Interactive Project Creation**

- **Smart Bundle ID Configuration**: Automated bundle ID setup for seamless deployment
- **Directory Selection**: Choose your project location with an intuitive picker
- **Platform Optimization**: Removes unnecessary platforms (web, desktop) for mobile-focused development

### 📦 **Comprehensive Package Management**

FluPilot CLI supports 150+ popular Flutter packages across multiple categories:

#### **🎨 UI & UX**

- **App Setup**: Icons, splash screens, onboarding flows
- **Animations**: Lottie, animate_do, flutter_animate, animated_text_kit
- **Navigation**: Bottom navigation bars, page indicators, pull-to-refresh
- **Utilities**: Shimmer effects, loading indicators, toast notifications

#### **🏗️ Architecture & State Management**

- **State Management**: BLoC, Provider, Riverpod, Hydrated BLoC
- **Navigation**: GoRouter with auto-generated route configurations
- **Dependency Injection**: GetIt with pre-configured service locator patterns

#### **🌐 Networking & APIs**

- **HTTP Clients**: Dio, Retrofit with interceptors and error handling
- **Code Generation**: JSON serialization, Freezed models, build_runner
- **Connectivity**: Network status monitoring, internet connection checking

#### **💾 Storage Solutions**

- **Local Storage**: SharedPreferences, Hive, SQLite
- **Cloud Services**: Firebase (Auth, Firestore, Analytics), Supabase
- **Caching**: Cached network images, offline-first patterns

#### **🔐 Authentication & Security**

- **Social Login**: Google, Apple, Facebook authentication
- **Biometric Auth**: Fingerprint, Face ID, local authentication
- **Security**: Secure storage, encryption, app lock screens

#### **🌍 Localization & Accessibility**

- **Internationalization**: Easy Localization with auto-generated translations
- **Responsive Design**: Screen utilities, responsive frameworks
- **Accessibility**: Screen readers, semantic labels

#### **📱 Device Integration**

- **Media**: Image/video pickers, audio players, camera integration
- **System**: Device info, package info, URL launcher
- **Notifications**: Local notifications, push messaging, awesome notifications

### 🏗️ **Auto-Generated Architecture**

#### **Clean Architecture Structure**

```plaintext
lib/
├── core/
│   ├── constants/
│   ├── helpers/           # Extensions, spacing, regex utilities
│   ├── networking/        # API services, error handling
│   ├── services/          # Local auth, notifications, storage
│   └── widgets/           # Reusable UI components
├── features/
│   └── auth/              # Feature-based modular structure
│       ├── data/
│       │   ├── models/    # Data models with JSON serialization
│       │   └── repo/      # Repository pattern implementation
│       ├── logic/         # BLoC/Cubit state management
│      
└── main.dart
```

#### **Pre-built Authentication System**

- Complete auth flow with login/register/forgot password
- Social authentication (Google, Apple) integration
- Biometric authentication support
- Password validation with real-time feedback
- Responsive form design with localization

#### **Networking Layer**

- Dio HTTP client with interceptors
- API error handling and result patterns
- Retrofit integration for type-safe API calls
- Network connectivity monitoring

#### **State Management**

- BLoC pattern implementation
- Cubit generators for rapid development
- State persistence with Hydrated BLoC
- Equatable for value comparison

### 🛠️ **Development Tools**

#### **Code Generation**

- JSON serialization with json_annotation
- Freezed for immutable data classes
- Build runner automation
- Retrofit API client generation

#### **Asset Management**

- Automatic asset folder creation
- pubspec.yaml asset configuration
- Image optimization and organization
- Icon and splash screen generation

#### **Platform Configuration**

- iOS Info.plist permissions setup
- Android manifest permissions
- Firebase/Supabase configuration
- Platform-specific optimizations

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK**: Latest stable version
- **Git**: Version control
- **Gum**: Interactive CLI components (auto-installed)
- **Python 3**: For build tools (macOS/Linux) or Python (Windows)

### Installation

#### via npm (Recommended)

```bash
npm install -g flupilot-cli
flupilot-cli
```

#### Manual Installation

```bash
git clone https://github.com/ahmedali109/FluPilot-CLI.git
cd FluPilot-CLI
chmod +x scripts/helper/check_and_install_deps.sh
./scripts/helper/check_and_install_deps.sh
```

### Usage

1. **Run FluPilot CLI**:

   ```bash
   flupilot-cli
   ```

2. **Follow the Interactive Prompts**:

   - Select project directory
   - Enter project name and bundle ID
   - Choose package categories
   - Select specific packages
   - Configure Firebase/Supabase (if selected)

3. **Your Project is Ready!**:
   - All dependencies installed
   - Boilerplate code generated
   - Platform configurations applied
   - Ready to open in your preferred IDE

## 📚 Detailed Workflow

### 1. Project Initialization

```bash
📁 Select project location
📝 Enter Flutter project name
🆔 Configure Bundle ID (com.example.yourapp)
🚀 Create Flutter project with optimized structure
```

### 2. Package Selection

```bash
📦 Choose from 15+ categories:
   ├── App Setup (Icons, Splash, Onboarding)
   ├── UI Components (Animations, Navigation)
   ├── State Management (BLoC, Provider)
   ├── Networking (HTTP, GraphQL)
   ├── Storage (Local, Cloud)
   ├── Authentication (Social, Biometric)
   └── System Integration (Notifications, Device)
```

### 3. Code Generation

```bash
🛠️ Generate boilerplate for selected packages
📄 Create service classes and utilities
🏗️ Set up architecture patterns
⚙️ Configure platform-specific settings
```

### 4. Final Setup

```bash
🔧 Run build_runner (if needed)
🎯 Open project in preferred IDE
✅ Ready for development!
```

## 🎯 Use Cases

### **MVP Development**

Quick prototype creation with essential features:

- Authentication system
- Basic UI components
- Local storage
- API integration

### **Enterprise Applications**

Production-ready setup with:

- Clean architecture
- State management
- Comprehensive testing structure
- CI/CD configurations

### **Learning Projects**

Educational setup with:

- Best practices implementation
- Modern Flutter patterns
- Code organization examples
- Documentation templates

## 🛠️ Available Commands

### CLI Flags

```bash
--help, -h     Show help information
--version, -v  Display version information
```

## 📋 Package Categories

### 🎨 UI & Visual (35+ packages)

- **Animations**: Lottie, animate_do, flutter_animate, animated_text_kit
- **Indicators**: Progress bars, loading spinners, shimmer effects
- **Navigation**: Bottom nav bars, page indicators, sliding panels
- **Utilities**: Toast notifications, dialogs, overlays

### 🏗️ Architecture (20+ packages)

- **State Management**: BLoC, Provider, Riverpod, GetX
- **Navigation**: GoRouter, AutoRoute, Navigator 2.0
- **Dependency Injection**: GetIt, Injectable, Kiwi
- **Code Generation**: Build runner, JSON serialization, Freezed

### 🌐 Networking (15+ packages)

- **HTTP**: Dio, Retrofit, HTTP interceptors
- **GraphQL**: GraphQL Flutter, Ferry
- **Connectivity**: Network monitoring, offline support
- **Caching**: Image caching, data persistence

### 💾 Storage (12+ packages)

- **Local**: SharedPreferences, Hive, SQLite, Secure Storage
- **Cloud**: Firebase, Supabase, AWS Amplify
- **Caching**: Cache management, offline-first patterns

### 🔐 Authentication (10+ packages)

- **Social**: Google, Apple, Facebook, Twitter sign-in
- **Biometric**: Fingerprint, Face ID, local authentication
- **Security**: JWT handling, secure storage, encryption

## 🔧 Configuration Examples

### Firebase Setup

```yaml
# Automatically configured
firebase_core: ^latest
firebase_auth: ^latest
cloud_firestore: ^latest
firebase_analytics: ^latest
```

### BLoC State Management

```dart
// Auto-generated cubit structure
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String email, String password) {
    // Implementation generated
  }
}
```

### Networking with Dio

```dart
// Auto-configured API service
class ApiService {
  final Dio _dio = DioFactory.getDio();

  Future<Response> getData() {
    // Type-safe API calls
  }
}
```

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### **🐛 Bug Reports**

- Use the [issue tracker](https://github.com/ahmedali109/FluPilot-CLI/issues)
- Provide detailed reproduction steps
- Include system information

### **💡 Feature Requests**

- Suggest new packages or integrations
- Propose architecture improvements
- Share use case scenarios

### **🔧 Development**

```bash
# Fork the repository
git clone https://github.com/yourusername/FluPilot-CLI.git
cd FluPilot-CLI

# Create feature branch
git checkout -b feature/amazing-feature

# Make your changes and test
./scripts/helper/check_and_install_deps.sh

# Submit pull request
```

### **📚 Documentation**

- Improve README sections
- Add code examples
- Create tutorial content
- Translate documentation

## 📈 Roadmap

### **🔜 Coming Soon**

- [ ] **Template System**: Custom project templates
- [ ] **Plugin Architecture**: Third-party integrations
- [ ] **Testing Setup**: Unit, widget, and integration tests
- [ ] **CI/CD Templates**: GitHub Actions, GitLab CI

### **🎯 Future Plans**

- [ ] **Web Support**: Web-specific packages and setup
- [ ] **Desktop Support**: Windows, macOS, Linux configurations

## 📜 License

This project is licensed under the **ISC License** - see the [LICENSE](LICENSE) file for details.

---

### Made with ❤️ by Ahmed Ali

**_Made with ❤️ by Ahmed Ali_**

[⭐ Star this repo](https://github.com/ahmedali109/FluPilot-CLI) &#124; [🐛 Report Bug](https://github.com/ahmedali109/FluPilot-CLI/issues) &#124; [💡 Request Feature](https://github.com/ahmedali109/FluPilot-CLI/issues/new)

</div>
