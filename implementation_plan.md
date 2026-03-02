# Implementation Plan: UI Lab & Personal Portfolio

This plan outlines the development of your Personal Portfolio and UI Lab application. Based on your requirements, the application will serve three main purposes: **Presentation** (Who you are), **Projects** (Your portfolio), and **UI Lab** (A showcase of your advanced UI/UX engineering skills using Flutter).

## 📊 Overview

- **Tech Stack**: **Pure Flutter Web**.
- **Core Structure**:
  1.  **Home Page**: Presentation (Hero) + Projects Section (Portfolio).
  2.  **UI Lab**: A dedicated route (`/lab`) to showcase your advanced UI/UX engineering skills.

---

## 📅 Phases

### Phase 1: Project Setup & Architecture
**Goal**: Initialize the project and establish the routing structure.
- [ ] Initialize Flutter Web project (`flutter create -e .`).
- [ ] structured folders: `lib/src/presentation`, `lib/src/features`, `lib/src/core`.
- [ ] Configure `go_router` for navigation:
    - `/`: Landing Page (Presentation + Featured Project + Featured Lab).
    - `/projects`: Project Gallery.
    - `/projects/:id`: Project Detail (Architecture, Stack, List of Functionalities).
    - `/lab`: UI Lab Gallery (Index of all granular components).
    - `/workbench/:type/:id`: The **Workbench**. This is where `DevicePreview` turns ON.
- [ ] Set up `device_preview` (as per README) to toggle the UI Lab view.

### Phase 2: Design System & Branding (New)
**Goal**: Establish a premium "Google Style" Material 3 visual identity.
- [ ] **Typography**: Use `google_fonts` (Inter or Roboto Flex) for modern, clean readability.
    -   Display Large: Hero sections.
    -   Body Medium: Content.
- [ ] **Color Palette**: 
    -   Primary: Deep Indigo/Violet (Creativity).
    -   Surface: Dark/Light variants with subtle elevation overlays.
- [ ] **Layout Patterns**:
    -   **Bento Grids**: Use staggered grid layouts for the "Featured" section on the landing page.
    -   **Glassmorphism**: Subtle transluency on navigation bars and cards.

### Phase 3: Flow & Navigation (Refined)
**Goal**: Implement the user's specific flow: `Home -> Gallery -> Detail -> Workbench`.
- [ ] **State Management**: Create `devicePreviewProvider` to dynamically enable/disable the device frame.
- [ ] **Navigation Structure**:
    -   `/`: Landing Page (Presentation + Featured Project + Featured Lab).
    -   `/projects`: Project Gallery.
    -   `/projects/:id`: Project Detail (Architecture, Stack, List of Functionalities).
    -   `/lab`: UI Lab Gallery (Index of all granular components).
    -   `/workbench/:type/:id`: The **Workbench**. This is where `DevicePreview` turns ON. It includes:
        -   The Component (Functionality).
        -   Menu Actions (Custom controls for the component).
        -   Device Config (DevicePreview toolbar).

### Phase 4: Screens Implementation
- [ ] **Landing Page**:
    -   **Presentation**: Intro/Hero.
    -   **Featured Project**: Summary card enabling deep dive.
    -   **Featured UI Lab**: Highlighted component (e.g., "Complex Form").
- [ ] **Workbench**: A wrapper widget that activates `device_preview` and renders the selected component with a control panel.
- [ ] **Catalog System**:
    -   Create a registry map that maps IDs (e.g., `auth_login`) to Widgets.
    -   Implement the logic to dynamically load these widgets.

### Phase 5: Implementing UI Lab Features (Granular)
**Goal**: Implement the specific "Granular Features" defined in `ui_lab_menu.md`.
*We will tackle these group by group:*

#### 4.1 Auth & Security
- [ ] `login_password`: Regex validation, visibility toggle.
- [ ] `social_auth`: Brand buttons, responsive design.
- [ ] `qr_auth` & `biometric`: Simulation UI.

#### 4.2 Forms & Input
- [ ] `large_form`: Scroll-to-error implementation (Critical for UX).
- [ ] `stepper_form`: State persistence logic.
- [ ] `search_filters`: Chip interactions.

#### 4.3 Tasks Management
- [ ] `kanban_board`: Drag and drop implementation.
- [ ] `todo_list`: Dismissible list items.

#### 4.4 Feed & Lists
- [ ] `infinite_scroll` & `interactive_cards`: Hero animations, Shimmer loading.

#### 4.5 Maps & Location
- [ ] `location_picker`: UI for picking location (Mocked or Real).
- [ ] `poi_bottom_sheet`: Floating panel logic.

#### 4.6 Billing & Profile
- [ ] `invoice_history` & `subscription_plans`.
- [ ] `profile_header`: SliverAppBar implementation.

### Phase 6: Polish & Deployment
- [ ] **Theming**: Implement a "Premium" Dark/Light mode theme.
- [ ] **Responsiveness**: Ensure Home and Projects look good on Mobile vs Desktop.
- [ ] **SEO**: Add meta tags (if using Jaspr) or Title headers.
- [ ] **Deploy**: GitHub Pages or Firebase Hosting.

---

## 📝 Next Steps for Interaction

1.  **Initialize**: Shall I start by creating the project structure?
2.  **Projects Data**: Do you have a list of projects you want to feature immediately?
3.  **Tech Decision**: Confirm if you want a **Pure Flutter Web** app (Recommended for cohesion) or the **Jaspr + Embedded** approach mentioned in the README.
