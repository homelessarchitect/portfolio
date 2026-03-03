# Portfolio Project Development Guide
**Homeless Architect — Estándar de Proyectos**

> Este documento define la metodología para integrar proyectos reales al portafolio de forma interactiva. Cada proyecto se muestra con sus pantallas reales replicadas en código, con simulaciones funcionales por feature.

---

## Filosofía

**No hacemos screenshots. Hacemos réplicas.**

Un proyecto no es una imagen — es una historia de decisiones técnicas. El visitante debe poder *operar* la demo, ver el estado cambiar, entender cómo funciona el producto antes de leer una sola línea de texto.

---

## Estructura de Carpetas en el Portafolio

Cada proyecto vive completamente dentro de `lib/src/features/projects/`:

```
lib/src/features/projects/
├── domain/
│   └── project.dart               ← Modelo Project (compartido)
├── data/
│   └── mock_projects.dart         ← Registro de todos los proyectos
├── presentation/
│   ├── project_gallery_screen.dart
│   └── project_detail_view.dart
│
└── catalog/                       ← Un subdirectorio por proyecto
    └── no_preguntes/
        ├── no_preguntes_project.dart   ← Definición del Project (datos + features)
        ├── state/
        │   └── no_preguntes_state.dart ← Estado Riverpod en memoria
        ├── views/                      ← Réplicas de pantallas del proyecto real
        │   ├── home_view_web.dart      ← 🏠 HOME VIEW web
        │   ├── home_view_mobile.dart   ← 🏠 HOME VIEW mobile
        │   ├── orders_board_view.dart
        │   └── menu_view.dart
        └── simulations/               ← Simulaciones interactivas por feature
            ├── login_simulation.dart
            ├── add_order_simulation.dart
            └── realtime_board_simulation.dart
```

---

## Paso a Paso para Integrar un Proyecto

### 1 — Clonar el Repositorio (modo lectura)

Clona el repo real del proyecto **solo como referencia**. No lo integres directamente.

```bash
git clone git@github.com:tu-org/no-preguntes.git /tmp/no-preguntes-ref
```

> El repo de referencia **nunca** entra al portafolio. Es solo para copiar pantallas y entender el flow.

---

### 2 — Separar por Features

Desde el repo de referencia, identifica los features principales del producto. Un **feature** es una unidad de funcionalidad que el usuario entiende (no un archivo técnico).

**Ejemplo — No Preguntes:**

| Feature | Descripción | Plataforma |
|---|---|---|
| `auth` | Login del admin | Mobile |
| `menu` | Menú del día | Web (público) |
| `add_order` | Agregar pedido manualmente | Mobile (admin) |
| `orders_board` | Board de pedidos en tiempo real | Web (público) |
| `order_status` | Cambiar estado de un pedido | Mobile (admin) |

Documenta esta tabla en `no_preguntes_project.dart` como comentario.

---

### 3 — Clonar las Views Principales

De cada feature, extrae **las pantallas principales** como widgets de Flutter dentro de `views/`. Reglas al clonar:

- **Elimina toda dependencia de Firebase** — reemplaza streams de Firestore por el estado Riverpod local.
- **Elimina navegación real** — si la vista tiene `Navigator.push`, reemplázalo por un callback o quítalo.
- **Mantén el 90% del diseño visual** — colores, tipografía, layout. Lo importante es que *se vea* como el producto real.
- **Simplifica la lógica de negocio** — no repliques validaciones complejas, solo el flujo visible.
- **Usa datos mock** — listas de productos, pedidos, usuarios con datos de ejemplo.

```dart
// ✅ Bien — usa el provider local
final orders = ref.watch(noPreguntesProvider);

// ❌ Mal — dependencia externa
final orders = await FirebaseFirestore.instance.collection('orders').get();
```

---

### 4 — Clasificar por Plataforma y Definir HOME VIEWS 🏠

#### Clasificación de proyectos

Todo proyecto tiene una o más plataformas declaradas. Esto determina cuántas Home Views se necesitan:

| Tipo | Plataformas | Home Views |
|---|---|---|
| `web` | Solo web | 1 — `home_view_web.dart` |
| `mobile` | Solo mobile (iOS / Android) | 1 — `home_view_mobile.dart` |
| `web+mobile` | Web + Mobile | 2 — una por plataforma |

#### Reglas de la Home View

> **La Home View es la pantalla más representativa de cada plataforma.** Se usa como miniatura en la `ProjectGalleryScreen`, hero banner en el detail, y preview en el home del portafolio.

1. **Nombre fijo por tipo**: `home_view_web.dart` / `home_view_mobile.dart`
2. Debe ser **autónoma**: datos mock estáticos, sin interacción previa.
3. Representa el **estado más rico** del producto (con datos, no vacía).
4. Renderizada dentro de un **device frame** acorde: browser frame para web, phone frame para mobile.
5. No debe tener scroll ni interacción — es una **foto viva**, no una simulación.

```dart
// Proyecto web+mobile (como No Preguntes):
Project(
  id: 'no_preguntes',
  platforms: [ProjectPlatform.web, ProjectPlatform.mobile],
  homeViews: {
    ProjectPlatform.web:    const NoPreguntesWebHomeView(),
    ProjectPlatform.mobile: const NoPreguntesMobileHomeView(),
  },
)

// Proyecto solo mobile:
Project(
  id: 'otro_proyecto',
  platforms: [ProjectPlatform.mobile],
  homeViews: {
    ProjectPlatform.mobile: const OtroProyectoMobileHomeView(),
  },
)
```

> En la **gallery card** y el **home preview**, si hay múltiples Home Views, se muestran ambos device frames lado a lado — eso comunica visualmente que es multiplataforma sin leer nada.

---

### 5 — Construir las Simulaciones por Feature

Cada feature del listado del Paso 2 tiene su propia simulación en `simulations/`. Una simulación es:

- Un **widget autónomo** que incluye todo lo necesario para demostrar **un flujo completo**.
- Usa el **estado Riverpod del proyecto** (mismo provider que las views).
- Tiene un `SimulationShell` que provee el layout estándar: título del feature, descripción, y los paneles.

**Anatomía de una simulación:**

```dart
class AddOrderSimulation extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimulationShell(
      title: 'Agregar Pedido',
      description: 'El admin ingresa los datos desde la app mobile.',
      leftPanel: DeviceFrame(
        type: DeviceFrameType.mobile,
        child: MobileAdminOrderFormView(),  // ← réplica de la pantalla real
      ),
      rightPanel: DeviceFrame(
        type: DeviceFrameType.web,
        child: WebOrdersBoardView(),         // ← reacciona al mismo provider
      ),
    );
  }
}
```

**Reglas de simulaciones:**

- Máximo **2 paneles** por simulación (mobile + web, o mobile + mobile, etc.)
- Cada simulación debe tener un **CTA claro**: una instrucción de qué hacer ("Agrega un pedido en la izquierda y míralo aparecer a la derecha").
- Pueden tener un botón **Reset** para re-iniciar el estado de demo.
- El estado es **compartido**: el mismo provider alimenta ambos paneles.

---

### 6 — Registrar el Proyecto

En `<project_id>_project.dart` defines el objeto `Project` completo:

```dart
final noPreguntesProject = Project(
  id: 'no_preguntes',
  title: 'No Preguntes',
  tagline: 'Pedidos del fin de semana, del negocio a la pantalla.',
  platforms: [ProjectPlatform.web, ProjectPlatform.mobile],
  services: ['Firebase Firestore', 'Firebase Hosting', 'Firebase Auth'],
  year: '2024',
  status: ProjectStatus.live,
  homeViews: {
    ProjectPlatform.web:    const NoPreguntesWebHomeView(),
    ProjectPlatform.mobile: const NoPreguntesMobileHomeView(),
  },
  features: [
    ProjectFeature(
      id: 'orders_board',
      title: 'Board de Pedidos en Tiempo Real',
      description: 'Pedidos ingresados desde la app mobile aparecen en segundos en la web pública.',
      simulation: () => const RealtimeBoardSimulation(),
    ),
    ProjectFeature(
      id: 'add_order',
      title: 'Ingreso de Pedidos',
      description: 'El admin registra nombre, ítem y teléfono del cliente en segundos.',
      simulation: () => const AddOrderSimulation(),
    ),
    ProjectFeature(
      id: 'menu',
      title: 'Menú Digital',
      description: 'La web muestra el menú de la semana, actualizable por el admin.',
      simulation: null, // sin simulación interactiva — solo vista
    ),
  ],
);
```

En `mock_projects.dart` solo importas y registras:

```dart
import 'catalog/no_preguntes/no_preguntes_project.dart';

const List<Project> featuredProjects = [
  noPreguntesProject,
];
```

---

## Widget Estándar: `SimulationShell`

Widget reutilizable para todas las simulaciones. Vive en `lib/src/core/presentation/widgets/simulation_shell.dart`.

```
┌──────────────────────────────────────────────────────────┐
│  FEATURE: Board de Pedidos en Tiempo Real            LIVE │
│  "Agrega un pedido en la app → aparece en la web"         │
├──────────────────────────┬───────────────────────────────┤
│  [leftPanel]             │  [rightPanel]                  │
│  DeviceFrame(mobile)     │  DeviceFrame(web)              │
│                          │                                │
└──────────────────────────┴───────────────────────────────┘
│                   [RESET DEMO]                            │
└───────────────────────────────────────────────────────────┘
```

---

## Checklist para Añadir un Nuevo Proyecto

```
[ ] 1. Identificar features principales (tabla)
[ ] 2. Crear carpeta en catalog/<project_id>/
[ ] 3. Crear state/ con Riverpod provider en memoria
[ ] 4. Crear views/ — una Home View por plataforma primero (datos mock, autónomas)
[ ] 5. Crear simulations/ — una por feature clave
[ ] 6. Crear <project_id>_project.dart con el Project completo
[ ] 7. Registrar en mock_projects.dart
[ ] 8. Verificar: Home Views se ven bien en sus device frames
[ ] 9. Verificar: cada simulación el estado cambia entre paneles correctamente
```

---

## Convenciones de Código

| Regla | Detalle |
|---|---|
| Sin Firebase | Reemplazar por Riverpod state local |
| Sin Navigator | Usar callbacks o no-op |
| Datos mock en archivos `_mock_data.dart` | Datos separados del widget |
| `homeViews` siempre definida | Una por plataforma declarada, no es opcional |
| `platforms` usando `ProjectPlatform` enum | `web`, `mobile`, o ambas |
| Simulaciones en `() =>` lazy | Para no instanciarlas hasta que el user navegue |
| Estado reset-able | Siempre proveer método `reset()` en el Notifier |
| Device frame explícito | `DeviceFrameType.web` o `DeviceFrameType.mobile` |
