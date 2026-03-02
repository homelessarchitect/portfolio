
---

# 🚀 Flutter UI-Lab & Portfolio

Este es mi ecosistema de desarrollo profesional. No es solo un portafolio; es un **laboratorio técnico** donde documento retos de ingeniería, soluciones de UX avanzada y patrones de arquitectura escalables.

Desarrollado con **Jaspr** para el core web y **Flutter** para las experiencias interactivas embebidas mediante `device_preview`.

---

## 🏗️ Arquitectura: Feature-First + MVVM

Para garantizar la mantenibilidad y aplicar los principios **SOLID**, el proyecto está organizado por **Features**. Cada funcionalidad es un módulo independiente que encapsula su propia lógica, evitando el "espagueti" de código.

### Capas del Proyecto:

* **Presentation (UI):** Widgets de Flutter y componentes Jaspr. La UI es "tonta"; solo reacciona al estado que le entrega el ViewModel.
* **ViewModel (Logic):** El cerebro de la feature. Maneja la **UX técnica**: controladores de scroll, validaciones complejas y flujos de estado.
* **Data / Domain:** Repositorios que abstraen la procedencia de los datos, facilitando el testing y la simulación de APIs.

---

## 🔬 El UI-Lab (Powered by Device Preview)

El corazón de este portafolio es la **Biblioteca de Features**. Aquí utilizo `device_preview` para que puedas probar mis soluciones en diferentes dispositivos (iOS, Android, Tablet) directamente desde el navegador.

### Catálogo de Soluciones Técnicas

| Feature | Tipo | Solución de UX / Ingeniería |
| --- | --- | --- |
| **Forms** | Large Form | **Scroll-to-Error:** Uso de `GlobalKey` y `ScrollController` para auto-scroll hacia campos con errores de validación. |
| **Forms** | Multi-step | **Memory Persist:** Persistencia de estado entre steps para no perder datos en recargas accidentales. |
| **Auth** | Password | **Strength Meter:** Validación con Regex en tiempo real y feedback visual de seguridad. |
| **Auth** | QR Login | **Stream Auth:** Simulación de flujos reactivos mediante *Streams* para autenticación remota. |
| **Social** | Infinite Feed | **Sliver Optimization:** Manejo eficiente de memoria en listas con `CustomScrollView` y `Slivers`. |
| **Maps** | Interactive POI | **Contextual Camera:** Manejo de `MapController` con transiciones suaves basadas en el contexto del usuario. |
| **Billing** | Invoices | **Skeleton Feedback:** Implementación de *Shimmer effect* para mejorar la experiencia de carga asíncrona. |

---

## 🛠️ Tech Stack

* **Web Framework:** [Jaspr](https://jaspr.site/)
* **Mobile Engine:** Flutter Web (Embedded)
* **State Management:** Riverpod / BLoC
* **Interactive Simulation:** [Device Preview](https://pub.dev/packages/device_preview)
* **CI/CD:** GitHub Actions

---

> *"No preguntes cómo funciona, mejor pruébalo en el simulador."*

---