# Clinic Management App

The Clinic Management App is a modern, user-friendly Flutter application designed to simplify patient registration and billing processes for medical clinics. It features a clean medical-themed UI using Google Fonts, intuitive workflows, and dynamically generated QR codes for seamless patient check-in and data sharing.

## App Features

- **Home Page**: A welcoming landing screen with the clinic's logo, a tagline ("Fast and Easy Clinic Management"), and clear navigation buttons to access registration and billing.
- **Registration Page**: A robust patient registration form that collects essential details (Name, Age, Gender, Contact, Address). Upon submission, a unique QR code containing the patient's data is automatically generated.
- **Billing Page**: Allows clinic staff to retrieve patient details quickly, input specific charges (Doctor's Fee, Medicine Charges), and automatically calculates the total amount owed.
- **Payment Page**: Displays the total calculated amount and allows the user to select from multiple payment methods (Cash, Card, E-wallet) to complete the transaction.
- **Receipt Page**: Provides a clear, detailed breakdown of the transaction including patient details, individual charges, payment method, date/time, and options to print or download the receipt.

## Built With

- **Flutter & Dart**: Cross-platform application framework.
- **Material Design**: UI component library.
- **Google Fonts**: Custom typography using 'Poppins' and 'Roboto'.
- **QR Flutter**: Library used for on-the-fly generation of QR codes.

## Project Structure

```text
lib/
  main.dart                           App entry point, route setup, and global theme
  pages/
    home_page.dart                    Landing page with navigation
    registration_page.dart            Patient registration form and QR code display
    billing_page.dart                 Patient search and dynamic fee calculation
    payment_page.dart                 Payment method selection
    receipt_page.dart                 Final transaction receipt display
pubspec.yaml                          Package metadata and Flutter dependencies
android/                              Android native configuration
ios/                                  iOS native configuration
web/                                  Web build configuration
macos/                                macOS native configuration
windows/                              Windows native configuration
linux/                                Linux native configuration
```

## Getting Started

Ensure you have Flutter installed, then fetch the project dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## Development Notes

- **Theming**: The app uses a customized Material 3 theme defined in `lib/main.dart` with a color scheme matching light blue (`#4A90E2`), teal (`#50C9C3`), and a white/light blue background.
- **State Management**: The current implementation leverages local state management utilizing standard Flutter widgets (e.g., `setState`, `TextEditingController`).
- **Data Flow**: Data such as patient information and billing amounts are passed between pages using Flutter's `Navigator` arguments.

## About CouldAI

This app was generated with [CouldAI](https://could.ai), the AI app builder for cross-platform apps. CouldAI turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications.

Use CouldAI at [could.ai](https://could.ai) to build and iterate cross-platform apps with AI.
