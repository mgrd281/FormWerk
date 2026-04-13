<div align="center">

<br />

<h1>🏋️ FormWerk</h1>

**Dein intelligenter Begleiter für Gesundheit, Fitness & Gewichtsmanagement**

<br />

[![Flutter](https://img.shields.io/badge/Flutter-3.29+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.2+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![iOS](https://img.shields.io/badge/iOS-16+-000000?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com/ios/)
[![Android](https://img.shields.io/badge/Android-7+-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://developer.android.com)
[![License](https://img.shields.io/badge/License-MIT-6E40C9?style=for-the-badge)](LICENSE)

<br />

[🇩🇪 Deutsch](#-über-formwerk) · [🇸🇦 العربية](#-الدعم-العربي) · [🚀 Schnellstart](#-schnellstart) · [🍎 Xcode](#-in-xcode-öffnen) · [❓ FAQ](#-häufige-probleme)

</div>

---

## 📱 Über FormWerk

FormWerk ist eine Premium-Flutter-App für ganzheitliches Gesundheitsmanagement. Sie verbindet Gewichtsverfolgung, Ernährungsplanung, Trainingsprotokollierung und Habit-Tracking in einer eleganten, intuitiven Oberfläche – mit vollständiger **Deutsch-** und **Arabisch-Unterstützung**.

### ✨ Hauptfunktionen

| Bereich | Features | |
|---------|----------|-|
| 🏠 **Dashboard** | Tagesübersicht mit Fortschrittsring, BMI-Skala, Kalorien- & Wasser-Tracker | `Premium UI` |
| ⚖️ **Gewicht** | Gewichtsverfolgung mit Verlauf, BMI-Berechnung & Zielgewicht | `Kernfunktion` |
| 📏 **Messungen** | Körpermaße dokumentieren & vergleichen (Taille, Brust, etc.) | `Tracking` |
| 🍽️ **Ernährung** | Mahlzeiten erfassen, Kalorien & Makronährstoffe tracken | `Tracking` |
| 💧 **Wasser** | Tägliche Trinkmenge mit Zielfortschritt im Blick behalten | `Tracking` |
| 🏃 **Training** | Workouts protokollieren – Dauer, Intensität & Kalorienverbrauch | `Tracking` |
| ✅ **Gewohnheiten** | Tägliche Habits tracken, Streaks aufbauen & motiviert bleiben | `Motivation` |
| 📊 **Analyse** | Smarte Insights, Trends & Statistiken auf einen Blick | `Insights` |
| 👤 **Profil** | Persönliche Daten, Ziele & Einstellungen verwalten | `Einstellungen` |

### 🎨 Design-Highlights

- **Material 3** Design System mit Custom Color Palette
- **Dark & Light Mode** vollständig unterstützt
- **RTL-Support** für Arabisch (Right-to-Left)
- **Premium Cards** mit Schatten, Gradients & abgerundeten Ecken
- **Animationen** für flüssige Übergänge & Interaktionen

---

## 🚀 Schnellstart

### Voraussetzungen

| Tool | Version | Hinweis |
|------|---------|---------|
| **Flutter SDK** | ≥ 3.29.0 | [Installationsanleitung](https://docs.flutter.dev/get-started/install) |
| **Dart SDK** | ≥ 3.2.0 | Wird mit Flutter installiert |
| **Xcode** | ≥ 16.0 | Nur für iOS-Entwicklung (macOS) |
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

### Auf dem iPhone starten

```bash
# Verbundene Geräte anzeigen
flutter devices

# Auf einem bestimmten Gerät starten
flutter run -d <device-id>

# Release-Modus (empfohlen für Performance-Tests)
flutter run -d <device-id> --release
```

---

## 🍎 In Xcode öffnen

> ⚠️ **Wichtig:** GitHub zeigt den „Open with Xcode"-Button **nur** bei nativen iOS-Projekten an. Bei Flutter-Projekten funktioniert dieser Button nicht – das ist ein GitHub-Limit, kein Fehler im Projekt.

So öffnest du FormWerk korrekt in Xcode:

### Methode 1: Über das Terminal (Empfohlen ✅)

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
2. **File → Open** (⌘O)
3. Zum Ordner `FormWerk/ios/` navigieren
4. **`Runner.xcworkspace`** auswählen ⚠️ **nicht** `.xcodeproj`

> **Wichtig:** Immer die `.xcworkspace`-Datei öffnen, da sie die CocoaPods-Integration enthält.

### Auf dem iPhone ausführen (über Xcode)

1. iPhone per USB oder WLAN mit dem Mac verbinden
2. In Xcode das Team unter **Signing & Capabilities** auswählen
3. Bundle Identifier ggf. anpassen (`de.gewichtskompass.app`)
4. Gerät auswählen und **▶ Run** drücken (⌘R)

---

## 📂 Projektstruktur

```
lib/
├── main.dart                    # App-Einstiegspunkt (GewichtsKompassApp)
├── config/
│   ├── firebase/                # Firebase-Konfiguration (Placeholder)
│   ├── localization/            # Internationalisierung (DE, AR)
│   ├── router/                  # Navigation & Routing (GoRouter + ShellRoute)
│   └── theme/                   # Design-System (Colors, Typography, Spacing)
├── core/
│   ├── constants/               # App-Konstanten
│   ├── errors/                  # Fehlerbehandlung
│   ├── extensions/              # Dart-Erweiterungen
│   ├── network/                 # Netzwerk-Utilities
│   ├── providers/               # Riverpod State-Management Provider
│   ├── utils/                   # Hilfsfunktionen
│   └── widgets/                 # Wiederverwendbare Widgets
├── data/
│   ├── datasources/             # Datenquellen (lokal/remote)
│   ├── mappers/                 # DTO-Mapper
│   ├── models/                  # Datenmodelle
│   └── repositories/            # Repository-Implementierungen
├── domain/
│   ├── entities/                # Domänen-Entitäten (Equatable)
│   ├── repositories/            # Repository-Interfaces
│   └── usecases/                # Geschäftslogik (BMI, Kalorien, etc.)
├── features/
│   ├── splash/                  # Startbildschirm
│   ├── onboarding/              # Einführung
│   ├── auth/                    # Anmeldung & Registrierung
│   ├── home/                    # Dashboard mit Fortschrittsringen
│   ├── weight/                  # Gewichtsverfolgung
│   ├── measurements/            # Körpermaße
│   ├── meals/                   # Ernährung & Kalorien
│   ├── water/                   # Wasser-Tracking
│   ├── workout/                 # Training
│   ├── habits/                  # Gewohnheiten & Streaks
│   ├── analytics/               # Analyse & Insights
│   ├── progress/                # Fortschrittsdiagramme
│   ├── log/                     # Aktivitätsprotokoll
│   ├── profile/                 # Benutzerprofil
│   ├── settings/                # Einstellungen (Sprache, Theme, etc.)
│   └── static/                  # Impressum, Datenschutz, AGB
└── l10n/
    ├── app_de.arb               # Deutsche Übersetzung
    └── app_ar.arb               # Arabische Übersetzung
```

---

## 🌍 Internationalisierung

FormWerk unterstützt mehrere Sprachen mit vollständiger Lokalisierung:

| Sprache | Code | Status | Richtung |
|---------|------|--------|----------|
| 🇩🇪 Deutsch | `de` | ✅ Vollständig | LTR |
| 🇸🇦 العربية | `ar` | ✅ Vollständig | RTL |

Neue Übersetzungen in `lib/l10n/app_XX.arb` hinzufügen.

### 🇸🇦 الدعم العربي

يدعم التطبيق اللغة العربية بالكامل مع واجهة من اليمين لليسار (RTL). لتغيير اللغة:
- في الإعدادات: Sprache → العربية
- أو عبر Provider: `localeProvider`

---

## 🛠️ Technologie-Stack

| Kategorie | Technologie | Hinweis |
|-----------|-------------|---------|
| **Framework** | Flutter 3.29+ | Cross-Platform |
| **Sprache** | Dart 3.2+ | Null-Safety |
| **State Management** | Riverpod | flutter_riverpod + riverpod_annotation |
| **Navigation** | GoRouter | ShellRoute mit BottomNav |
| **Lokale DB** | Hive | Lokale Datenspeicherung |
| **Charts** | FL Chart | Fortschrittsdiagramme |
| **Architektur** | Clean Architecture | Domain → Data → Presentation |
| **Design** | Material 3 | Custom Design System |
| **Backend** | Firebase *(optional)* | Aktuell deaktiviert – kann aktiviert werden |

### Firebase aktivieren

Firebase ist aktuell deaktiviert. So aktivierst du es:

1. In `pubspec.yaml` die Firebase-Pakete entkommentieren
2. `flutterfire configure` ausführen
3. `GoogleService-Info.plist` in `ios/Runner/` ablegen
4. `flutter pub get` und `cd ios && pod install`

---

## 📦 Build

### iOS (Release)

```bash
flutter build ios --no-codesign
```

### Android (Release)

```bash
flutter build apk --release
# oder für Play Store:
flutter build appbundle --release
```

### Build bereinigen

```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
```

---

## ❓ Häufige Probleme

### „No provider was found" beim iOS-Deploy

Stelle sicher, dass:
- Das iPhone per USB verbunden ist (WLAN-Debugging kann instabil sein)
- In Xcode ein Signing-Team ausgewählt ist
- Der Bundle Identifier eindeutig ist

### App stürzt mit SIGKILL ab (Debug-Modus)

Wenn die App im Debug-Modus mit `SIGKILL` beendet wird:

1. Alte Version auf dem iPhone löschen (lange tippen → App entfernen)
2. Projekt bereinigen:
   ```bash
   flutter clean && flutter pub get && cd ios && pod install && cd ..
   ```
3. Neu installieren: `flutter run --release`
4. Alternativ: In Xcode **Product → Clean Build Folder** (⇧⌘K) und neu starten

### „CocoaPods could not find compatible versions"

```bash
cd ios && pod repo update && pod install && cd ..
```

### „Xcode is taking longer than expected"

```bash
# Alle Flutter-Prozesse beenden
pkill -9 -f flutter && pkill -9 -f dart

# Neu starten
flutter run --release
```

### Flutter-Version prüfen

```bash
flutter doctor -v
```

---

## 🤝 Mitwirken

Beiträge sind willkommen! So kannst du helfen:

1. Repository forken
2. Feature-Branch erstellen (`git checkout -b feature/amazing-feature`)
3. Änderungen committen (`git commit -m 'Add amazing feature'`)
4. Branch pushen (`git push origin feature/amazing-feature`)
5. Pull Request erstellen

---

## 📄 Lizenz

Dieses Projekt steht unter der MIT-Lizenz. Siehe [LICENSE](LICENSE) für Details.

---

<div align="center">

<br />

**FormWerk** – Dein Körper, dein Kompass. 🧭

<br />

[⬆ Nach oben](#️-formwerk)

</div>