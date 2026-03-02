# 🚀 Flutter UI-Lab & Portfolio

This is my professional development ecosystem. It's not just a portfolio; it's a **technical laboratory** where I document engineering challenges, advanced UX solutions, and scalable architecture patterns.

Built with **Flutter Web** 3.x, featuring a unified codebase for Presentation, Projects, and the UI Laboratory.

---

## 🏗️ Architecture: Feature-First + Riverpod

To ensure maintainability and apply **SOLID** principles, the project is organized by **Features**. Each functionality is an independent module encapsulating its own logic.

### Layers:

* **Presentation (UI):** Flutter Widgets. The UI is "dumb"; it only reacts to the state provided by the ViewModel/Notifier.
* **Notifier (Logic):** The brain of the feature. Handles technical UX: scroll controllers, complex validations, and state flows using `flutter_riverpod`.
* **Data / Domain:** Repositories abstracting data sources, facilitating testing and API simulation.

---

## 🔬 The UI Lab (Powered by Device Preview)

The heart of this portfolio is the **Feature Library**. I use `device_preview` so you can test my solutions on different devices (iOS, Android, Tablet) directly from the browser.

### Granular Solutions Catalog

| Feature | Group | UX / Engineering Solution |
| --- | --- | --- |
| **Login & Password** | Auth | Validation with Regex, visibility toggle, loading/error states. |
| **Large Form** | Forms | **Scroll-to-Error:** `GlobalKey` & `ScrollController` for auto-scroll to validation errors. |
| **Kanban Board** | Tasks | Drag and Drop between columns (To Do, Doing, Done). |
| **infinite_scroll** | Feeds | Async pagination, Shimmer loading, and memory control. |
| **Interactive POI** | Maps | **Contextual Camera:** `MapController` handling with smooth transitions. |
| **Invoice History** | Billing | Filters by date/status and receipt preview generation. |
| **Sliver Header** | Profile | Collapsible `SliverAppBar` with avatar management. |

---

## ✍️ DevLog: Programmer's Journal

This space is my combat log. Here I document:

* **Technical Challenges:** Complex problems and how I conquered them.
* **Refactoring:** Why I changed a code pattern for a more efficient one.
* **Experimentation:** Testing new libraries and Dart/Flutter versions.

---

## 🛠️ Tech Stack

* **Framework:** Flutter Web (Stable)
* **State Management:** Riverpod (NotifierProvider)
* **Routing:** GoRouter
* **Interactive Simulation:** [Device Preview](https://pub.dev/packages/device_preview)
* **CI/CD:** GitHub Actions (Planned)

---

## 🚀 Getting Started

1.  **Clone:** `git clone ...`
2.  **Install:** `flutter pub get`
3.  **Run:** `flutter run -d chrome`

> *"Don't ask how it works, test it in the simulator."*
