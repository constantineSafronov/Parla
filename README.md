# Parla 🇮🇹

![SwiftUI](https://img.shields.io/badge/SwiftUI-Orange?style=flat-square&logo=swift) ![SwiftTesting](https://img.shields.io/badge/SwiftTesting-Orange?style=flat-square&logo=swift) ![iOS](https://img.shields.io/badge/iOS-Blue?style=flat-square&logo=apple) ![Combine](https://img.shields.io/badge/Combine-Red?style=flat-square) ![SwiftData](https://img.shields.io/badge/SwiftData-LightBlue?style=flat-square)

**Parla** is an iOS application for learning Italian vocabulary, designed as a portfolio project to demonstrate modern iOS development practices, clean architecture, and a focus on user experience.

The app allows users to create custom word sets, add Italian words using dictionary-based suggestions, and practice vocabulary through an interactive card-based learning flow inspired by swipeable decks.

---

## ✨ Features

- 📚 **Custom Word Sets**
  - Create and manage your own vocabulary sets
  - Add, edit, and organize Italian words

- 🔍 **Smart Word Suggestions**
  - Add new words using a local dictionary
  - Real-time suggestions with a selectable hint interface

- 🃏 **Card-Based Learning**
  - Swipeable card deck for vocabulary training
  - Focused, distraction-free learning experience

- ⌚ **Apple Watch Support**
  - Lightweight companion app
  - Minimal functionality for quick word review on the go

- 🧪 **Test Coverage**
  - Swift Tests included to ensure core logic reliability

---

## 🧱 Architecture

Parla is built using the **MVVM** architectural pattern with a strong separation of concerns:

- **Model** — SwiftData entities and business logic  
- **View** — SwiftUI views with a declarative UI approach  
- **ViewModel** — Presentation logic using the Observation framework  

This structure ensures scalability, testability, and maintainability.

---

## 🛠 Technologies & Tools

- **SwiftUI** — Declarative UI framework
- **SwiftData** — Persistent storage
- **Observation Framework** — Modern state observation
- **MVVM** — Clean architectural pattern
- **Swift Tests** — Unit testing
- **Apple Watch support**
- **iOS 26**

---

## 📱 Platform Support

- iPhone (iOS 26+)
- Apple Watch (minimal companion functionality)
- Interface language: **English**

---

## 🎯 Purpose

This project was created as a **portfolio application** to showcase:
- Modern SwiftUI development
- Practical usage of SwiftData and Observation
- Clean MVVM architecture
- Attention to UX in educational apps
- Apple ecosystem integration

---

## Screenshots 🖼️

  <td><img src="https://github.com/user-attachments/assets/c0a438de-6fc0-4008-9ec0-94fdbdb2e656" alt="Word Set List" width="200"/></td>
  <td><img src="https://github.com/user-attachments/assets/93e0b305-ffe9-4a8e-aead-58f8caff3a2c" alt="Emoji Set" width="200"/></td>
  <td><img src="https://github.com/user-attachments/assets/35412538-12c3-4dbe-ab65-ef0572606027" alt="Learning" width="200"/></td>
  <td><img src="https://github.com/user-attachments/assets/72ae2de9-7d3e-40f3-9fa9-316b67136b7a" alt="Word List" width="200"/></td>
  <td><img src="https://github.com/user-attachments/assets/bfda3a4d-5360-49ea-a9bd-2fdd8cd13084" alt="Word Creation" width="200"/></td>
  <td><img src="https://github.com/user-attachments/assets/3c2c75d7-3008-4e88-a292-f65da77dbc51" alt="Dark Theme" width="200"/></td>
  <td><img src="https://github.com/user-attachments/assets/03648370-123c-4276-93b8-b77b3e6e4479" alt="Set List" width="200 height="514"/></td>
  <td><img src="https://github.com/user-attachments/assets/8595b742-ba11-475f-bac6-bc63b258efd2" alt="Word Card" width="200 height="514"/></td>
</tr>
</tr>
</table>

---

## Installation 🚀

Clone the repo:

```bash
git clone https://github.com/constantineSafronov/parla.git
cd parla
```

Open `Parla.xcodeproj` in Xcode and build for iOS Simulator or device.

---

## Testing ✅

Unit tests are included for key components:

```bash
Cmd + U
```

---

## License 📄

MIT License – feel free to explore, learn, and adapt!
