# 🏋️ FormWerk

> **Dein intelligenter Begleiter für Gesundheit, Fitness & Gewichtsmanagement**

[![Flutter](https://img.shields.io/badge/Flutter-3.41-02569B?logo=flutter)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-green)](https://github.com/mgrd281/FormWerk)
[![License](https://img.shields.io/badge/License-MIT-blue)](LICENSE)

---

## 📱 Über FormWerk

FormWerk ist eine Premium-Flutter-App für ganzheitliches Gesundheitsmanagement. Sie verbindet Gewichtsverfolgung, Ernährungsplanung, Trainingsprotokollierung und Habit-Tracking in einer eleganten, intuitiven Oberfläche.

### ✨ Hauptfunktionen

| Bereich | Features |
|---------|----------|
| 🏠 **Dashboard** | Tagesübersicht, Fortschritt, Schnellzugriff |
| ⚖️ **Gewicht** | Gewichtsverfolgung, BMI-Berechnung, Verlauf |
| 📏 **Messungen** | Körpermaße dokumentieren & vergleichen |
| 🍽️ **Ernährung** | Mahlzeiten erfassen, Kalorien & Makros |
| 💧 **Wasser** | Tägliche Trinkmenge im Blick behalten |
| 🏃 **Training** | Workouts protokollieren, Dauer & Intensität |
| ✅ **Gewohnheiten** | Tägliche Habits tracken, Streaks aufbauen |
| 📊 **Analyse** | Smarte Insights, Trends & Statistiken |
| 👤 **Profil** | Persönliche Daten, Ziele & Einstellungen |

---

## 🚀 Schnellstart

### Voraussetzungen

| Tool | Version | Hinweis |
|------|---------|---------|
| **Flutter SDK** | ≥ 3.29.0 | [Installationsanleitung](https://docs.flutter.dev/get-started/install) |
| **Dart SDK** | ≥ 3.2.0 | Wird mit Flutter installiert |
| **Xcode** | ≥ 16.0 | Nur für iOS-Entwicklung |
| **CocoaPods** | ≥ 1.16.0 | Nur für iOS-Entwicklung |
| **Android Studio** | Aktuell | Nur für Android-Entwicklung |

### Projekt einrichten

```bash
# 1. Repository klonen
git clone https://github.com/mgrd281/FormWerk.git
cd FormWerk

# 2. Abhängigkeiten installieren
flutter pub get

# 3. iOS Pods installieren (nur macOS)
cd ios && pod install && cd ..

# 4. App starten
flutter run
```

---

## 🍎 In Xcode öffnen

> **Hinweis:** GitHub unterstützt den „Open with Xcode"-Button **nur** für native iOS-Projekte. Bei Flutter-Projekten funktioniert dieser Button nicht.

So öffnest du FormWerk in Xcode:

### Methode 1: Über das Terminal (Empfohlen)

```bash
cd FormWerk
open ios/Runner.xcworkspace
```

### Methode 2: Über Flutter

```bash
flutter build ios --no-codesign   # Projekt vorbereiten
open ios/Runner.xcworkspace       # In Xcode öffnen
```

### Methode 3: Manuell in Xcode

1. Xcode öffnen
2. **File → Open**
3. Zum Ordner `FormWerk/ios/` navigieren
4. `Runner.xcworkspace` auswählen ⚠️ **nicht** `.xcodeproj`

> **Wichtig:** Immer die `.xcworkspace`-Datei öffnen, da sie die CocoaPods-Integration enthält.

### Auf dem iPhone ausführen (über Xcode)

1. iPhone per USB oder WLAN mit dem Mac verbinden
2. In Xcode das Team unter **Signing & Capabilities** auswählen
3. Bundle Identifier ggf. anpassen (`de.gewichtskompass.app`)
4. Gerät auswählen und **▶ Run** drücken

---

## 📂 Projektstruktur

```
lib/
├── main.dart                    # App-Einstiegspunkt
├── config/
│   ├── localization/            # Internationalisierung (DE, AR)
│   ├── router/                  # Navigation & Routing (GoRouter)
│   └── theme/                   # Design-System (Colors, Typography, Spacing)
├── core/
│   ├── constants/               # App-Konstanten
│   ├── errors/                  # Fehlerbehandlung
│   ├── extensions/              # Dart-Erweiterungen
│   ├── network/                 # Netzwerk-Utilities
│   ├── providers/               # State-Management Provider
│   ├── utils/                   # Hilfsfunktionen
│   └── widgets/                 # Wiederverwendbare Widgets
├── data/
│   ├── datasources/             # Datenquellen
│   ├── mappers/                 # DTO-Mapper
│   ├── models/                  # Datenmodelle
│   └── repositories/            # Repository-Implementierungen
├── domain/
│   ├── entities/                # Domänen-Entitäten
│   ├── repositories/            # Repository-Interfaces
│   └── usecases/                # Geschäftslogik
├── features/
│   ├── splash/                  # Startbildschirm
│   ├── onboarding/              # Einführung
│   ├── auth/                    # Anmeldung & Registrierung
│   ├── home/                    # Hauptbildschirm
│   ├── weight/                  # Gewichtsverfolgung
│   ├── measurements/            # Körpermaße
│   ├── meals/                   # Ernährung
│   ├── water/                   # Wasser-Tracking
│   ├── workout/                 # Training
│   ├── habits/                  # Gewohnheiten
│   ├── analytics/               # Analyse & Insights
│   ├── progress/                # Fortschritt
│   ├── log/                     # Aktivitätsprotokoll
│   ├── profile/                 # Benutzerprofil
│   ├── settings/                # Einstellungen
│   └── static/                  # Statische Seiten
└── l10n/
    ├── app_de.arb               # Deutsche Übersetzung
    └── app_ar.arb               # Arabische Übersetzung
```

---

## 🌍 Internationalisierung

FormWerk unterstützt mehrere Sprachen:

| Sprache | Code | Status |
|---------|------|--------|
| 🇩🇪 Deutsch | `de` | ✅ Vollständig |
| 🇸🇦 العربيّة | `ar` | ✅ Vollständig |

Neue Übersetzungen in `lib/l10n/app_XX.arb` hinzufügen.

---

## 🛠️ Technologie-Stack

| Kategorie | Technologie |
|-----------|-------------|
| **Framework** | Flutter 3.41+ |
| **Sprache** | Dart 3.2+ |
| **State Management** | Riverpod |
| **Navigation** | GoRouter |
| **Lokale DB** | Sqflite |
| **Architektur** | Clean Architecture (Domain → Data → Presentation) |
| **Design** | Material 3, Custom Design System |

---

## 📦 Build

### iOS (Release)

```bash
flutter build ios --no-codesign
```

### Android (Release)

```bash
flutter build apk --release
# oder
flutter build appbundle --release
```

---

## ❓ Häufige Probleme

### „No provider was found" beim iOS-Deploy

Stelle sicher, dass:
- Das iPhone per USB verbunden ist (WLAN-Debugging kann instabil sein)
- In Xcode ein Signing-Team ausgewählt ist
- Der Bundle Identifier eindeutig ist

### „CocoaPods could not find compatible versions"

```bash
cd ios && pod repo update && pod install && cd ..
```

### Flutter-Version prüfen

```bash
flutter doctor
```

---

## 🤝 Mitwirken

1. Repository forken
2. Feature-Branch erstellen (`git checkout -b feature/amazing-feature`)
3. Änderungen committen (`git commit -m 'Add amazing feature'`)
4. Branch pushen (`git push origin feature/amazing-feature`)
5. Pull Request erstellen

---

## 📄 Lizenz

Dieses Projekt steht unter der MIT-Lizenz. Siehe [LICENSE](LICENSE) für Details.

---

## 👨‍💻 Autor

**mgrd281** – [GitHub](https://github.com/mgrd281)

---

<div align="center">

**FormWerk** – Dein Körper, dein Kompass. 🧭

</div>