
### 📂 Catálogo Granular de Features & Soluciones

#### 1. `auth` (Autenticación y Seguridad)

* **Feature:** `login_password`
* **Solution:** Validación con Regex, botón de visibilidad de contraseña y manejo de estados `loading/error/success`.


* **Feature:** `social_auth`
* **Solution:** Botones de marca (Google, Apple, Facebook) con diseño adaptativo y simulación de tokens de terceros.


* **Feature:** `qr_auth`
* **Solution:** Interfaz de escaneo, generación de QR y flujo de "espera de apretón de manos" (Handshake) con el servidor.


* **Feature:** `biometric_gateway`
* **Solution:** Interfaz de fallback cuando la biometría falla y animaciones de "escaneando".



#### 2. `forms` (Entrada de Datos Compleja)

* **Feature:** `large_form`
* **Solution:** **Scroll-to-error** (foco automático en el error) y segmentación de campos por categorías visuales.


* **Feature:** `stepper_form`
* **Solution:** Persistencia de memoria entre pasos y barra de progreso animada.


* **Feature:** `checkout_form`
* **Solution:** Enmascaramiento de tarjeta de crédito (input masking), validación de fecha de expiración y CVV.


* **Feature:** `search_filters`
* **Solution:** Chips interactivos para filtrado múltiple y limpieza de filtros global.



#### 3. `tasks_manage` (Gestión de Tareas y Estados)

* **Feature:** `kanban_board`
* **Solution:** Arrastrar y soltar (**Drag and Drop**) entre columnas de estado (To Do, Doing, Done).


* **Feature:** `todo_list`
* **Solution:** Acciones rápidas mediante `Dismissible` (deslizar para borrar/completar) y reordenamiento de ítems.


* **Feature:** `task_detail`
* **Solution:** Edición en línea (inline editing) y selectores de fecha/prioridad contextuales.



#### 4. `feed_lists` (Visualización de Contenido)

* **Feature:** `infinite_scroll`
* **Solution:** Paginación asíncrona, esqueletos de carga (**Shimmer**) y control de memoria para listas masivas.


* **Feature:** `interactive_cards`
* **Solution:** Expansión de tarjetas con animaciones de héroe (`Hero` widget) y botones de acción rápida integrados.


* **Feature:** `pull_to_refresh`
* **Solution:** Feedback háptico y visual al actualizar contenido manualmente.



#### 5. `maps` (Geolocalización y Rutas)

* **Feature:** `location_picker`
* **Solution:** Marcador central fijo que devuelve coordenadas al mover el mapa e inversa de geocodificación (dirección).


* **Feature:** `poi_navigation`
* **Solution:** Panel inferior (Bottom Sheet) que se expande al tocar un marcador y anima la cámara del mapa.


* **Feature:** `real_time_tracking`
* **Solution:** Suavizado de movimiento de marcadores (Interpolación) para seguir una ruta en vivo.



#### 6. `billing` (Finanzas y Facturación)

* **Feature:** `invoice_history`
* **Solution:** Filtros por fecha/estado y generación de vista previa de recibo.


* **Feature:** `subscription_plans`
* **Solution:** Switch de facturación mensual/anual con cálculo dinámico de ahorro.


* **Feature:** `payment_methods`
* **Solution:** Gestión de billetera digital (Wallet UI) y selección de método predeterminado.



#### 7. `user_profile` (Gestión de Identidad)

* **Feature:** `profile_header`
* **Solution:** Efecto de colapso con `SliverAppBar` y cambio de avatar con previsualización inmediata.


* **Feature:** `account_settings`
* **Solution:** Organización por secciones con toggles para notificaciones, privacidad y modo oscuro.



---

### Ejemplo de cómo se vería una entrada en tu código:

```dart
// Ruta sugerida para el UI-Lab
// features/forms/solutions/large_form_scroll_to_error.dart

class LargeFormSolution extends StatelessWidget {
  // Aquí implementas el ScrollController y la lógica de foco
}

```
