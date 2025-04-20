# 📒 DriveNotes

Video ->  https://drive.google.com/file/d/1SsxAn8s6yye14GSv4fti60soxyTQj-wO/view?usp=sharing

**DriveNotes** is a Flutter application that allows users to seamlessly create, read, update, and delete text-based notes stored directly in their **Google Drive**. Notes are stored inside a dedicated folder called `DriveNotes`, offering a minimal and cloud-synced alternative to traditional note-taking apps.

With built-in offline support and Google OAuth 2.0 authentication, DriveNotes provides a simple yet powerful way to manage notes that stay with you—whether you're online or not.

---

## ✨ Features

- 📂 Store notes as plain text files inside your Google Drive (`DriveNotes` folder).
- 🔄 Full CRUD support (create, read, update, delete) for notes.
- 🔐 Secure Google Sign-In via **OAuth 2.0**.
- 📡 Offline-first approach — notes are saved locally and automatically synced to Drive on the next login session with internet access.
- 🎨 Dynamic theming — easily switch between light, dark, or system themes.
- 🧱 Clean architecture with **feature-first** modularization.
- 🗂 State management using **Riverpod**.
- 🔧 Dependency injection using **GetIt**.
- 🚦 Navigation using **GoRouter**.
- 🧪 Unit and widget testing with **mocktail**.

---

## 🚧 Limitations

- Currently, **offline support** is partial. Notes are stored locally when offline, and uploaded to Drive during the next authenticated online session.
- Certain **edge cases in synchronization** (e.g. conflicting updates, drive quota issues) are yet to be handled robustly.

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/DriveNotes.git
cd DriveNotes
```

### 2. Install Flutter Packages

```bash
flutter pub get
```

### 3. Run the App

```bash
flutter run
```

---

## 🔐 Firebase & Google Sign-In Setup

To enable native Google Sign-In with OAuth 2.0:

### 1. Create a Firebase Project

- Go to [Firebase Console](https://console.firebase.google.com/)
- Create a new project (e.g., `DriveNotes`)

### 2. Add Android App to Firebase

- Click **"Add App"** > Android
- Provide your Android package name (you can find it in `android/app/src/main/AndroidManifest.xml`)
- Enter the **SHA-1 fingerprint** (see below)
- Download the `google-services.json` file and place it in `android/app/`

### 3. Get SHA-1 Fingerprint

Run the following command from the `android/` directory:

```bash
./gradlew signingReport
```

Copy the SHA-1 listed under `Variant: debug`.

### 4. Enable Google Sign-In

- In Firebase Console:
  - Navigate to **Authentication** > **Sign-in method**
  - Enable **Google** and configure the required fields

---

## 💡 Project Structure

DriveNotes follows a clean architecture structure:

```
lib/
├── features/            # Feature modules (notes, auth, etc.)
├── core/                # Shared utilities and constants
├── services/            # Drive, Auth, and Local DB services
├── theme/               # Theme data and switch logic
├── routing/             # GoRouter setup
├── main.dart            # App entry point
```

---

## 📌 Contribution

Contributions are welcome! Feel free to open issues or submit pull requests.

---

## 📝 License

This project is licensed under the MIT License.
