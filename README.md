# Pokedex App

A Flutter-based Pokedex application with clean architecture and REST API integration.

![Flutter Version](https://img.shields.io/badge/flutter-3.6.1-blue)
![Dart Version](https://img.shields.io/badge/dart-3.6.1-blue)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

## 📱 App Screenshots

[Screenshots will be added here]

## 🌟 Features

- Display Pokemon list with infinite scrolling
- Detailed information for each Pokemon
- Visualization of Pokemon base statistics
- Detailed Pokemon information (height, weight, and more)
- Modern and responsive UI
- Support for light and dark themes

## 📚 Technology & Architecture

This application is built using:

- **Flutter & Dart**: Main framework and programming language
- **Clean Architecture**: Separating code into data, domain, and presentation layers
- **BLoC Pattern**: State management using flutter_bloc
- **Dependency Injection**: Using get_it
- **API Integration**: Using [dart_pokedex](https://github.com/ThiDinh21/dart_pokedex) package for accessing Pokemon data
- **Testing**: Unit testing using flutter_test and mocktail

### Project Structure

```
lib/
├── core/           # Code used throughout the application
│   ├── common/     # Common widgets and views
│   ├── enums/      # Enums used throughout the application
│   ├── errors/     # Exceptions and failures
│   ├── extensions/ # Extension methods
│   ├── res/        # Resources such as colors, strings, and media
│   ├── services/   # Service layer
│   ├── themes/     # App theme configuration
│   ├── usecases/   # Base use case classes
│   └── utils/      # Utility functions and constants
│
├── src/            # Application features
│   ├── pokemon/            # Pokemon list feature
│   ├── pokemon_detail/     # Pokemon detail feature
│   ├── pokemon_about/      # Pokemon information feature
│   └── pokemon_base_stats/ # Pokemon base statistics feature
│
└── main.dart       # Application entry point
```

## 🚀 How to Run

### Prerequisites

- Flutter SDK (version 3.6.1 or higher)
- Dart SDK (version 3.6.1 or higher)
- IDE: Visual Studio Code, Android Studio, or IntelliJ IDEA

### Steps

1. Clone this repository:

   ```bash
   git clone [repository-url]
   ```

2. Navigate to the project directory:

   ```bash
   cd pokedex_app
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:
   ```bash
   flutter run
   ```

## 🧪 Testing

This application comes with comprehensive unit tests. To run the tests:

```bash
flutter test
```

## 📄 License

[License will be added here]

## 🙏 Acknowledgements

- [PokeAPI](https://pokeapi.co/) for providing Pokemon data
- [dart_pokedex](https://github.com/ThiDinh21/dart_pokedex) for the API wrapper used in the project
- [very_good_analysis](https://pub.dev/packages/very_good_analysis) for providing lint rules and code quality standards
- Flutter team for the amazing framework
- Open source community for the packages used in this project
