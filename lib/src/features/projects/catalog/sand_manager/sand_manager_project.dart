import 'package:flutter/material.dart';
import '../../domain/project.dart';
import 'views/sand_manager_mobile_home_view.dart';
import 'views/sand_manager_web_home_view.dart';

import 'simulations/sand_manager_cashbox_simulation.dart';
import 'simulations/sand_manager_sale_simulation.dart';
import 'simulations/sand_manager_cubicate_simulation.dart';
import 'simulations/sand_manager_auth_simulation.dart';
import 'simulations/sand_manager_clients_simulation.dart';
import 'simulations/sand_manager_inventory_simulation.dart';
import 'simulations/sand_manager_invoices_simulation.dart';
import 'simulations/sand_manager_products_simulation.dart';
import 'simulations/sand_manager_transporters_simulation.dart';
import 'views/sand_manager_web_admin_wrapper.dart';

final sandManagerProject = Project(
  id: 'sand_manager',
  title: 'Sand Manager',
  tagline: 'Gestión integral de caja y ventas para areneras.',
  description:
      'Un sistema multi-plataforma para manejar el inventario, ventas y flujo de caja de forma instantánea.',
  platforms: [ProjectPlatform.web, ProjectPlatform.mobile],
  services: ['Firebase Firestore', 'Riverpod', 'Cloud Functions'],
  year: '2024',
  status: ProjectStatus.live,
  logoUrl:
      'lib/src/features/projects/catalog/sand_manager/sand_manager_logo.png',
  homeViews: const {
    ProjectPlatform.web: SandManagerWebHomeView(),
    ProjectPlatform.mobile: SandManagerMobileHomeView(),
  },
  features: [
    ProjectFeature(
      id: 'cashbox',
      title: 'Flujo de Caja Real-Time',
      description:
          'Registra un gasto operativo y observa cómo se actualiza tu flujo de caja.',
      targetPlatform: FeatureTargetPlatform.mobile,
      simulationScreens: [
        SimulationScreen(
          label: 'Formulario',
          builder: () => const CashboxFormScreen(),
        ),
        SimulationScreen(
          label: 'Dashboard',
          builder: () => const CashboxMobileDashboardScreen(),
        ),
      ],
      helpSteps: [
        HelpStep(
          stepNumber: 1,
          title: 'Ingresa el monto',
          description: 'Escribe el valor del gasto operativo.',
          top: 0.18,
          left: 0.08,
        ),
        HelpStep(
          stepNumber: 2,
          title: 'Selecciona el método',
          description: 'Elige Efectivo, Nequi o Daviplata.',
          top: 0.42,
          left: 0.08,
        ),
        HelpStep(
          stepNumber: 3,
          title: 'Confirma el gasto',
          description: 'Presiona para registrar.',
          top: 0.65,
          left: 0.08,
        ),
        HelpStep(
          stepNumber: 4,
          title: 'Observa el dashboard',
          description: 'El saldo se actualiza en tiempo real.',
          top: 0.15,
          left: 0.55,
        ),
      ],
      guide:
          '1. Abre la caja registradora.\n2. Registra un gasto de combustible.\n3. Observa cómo el saldo total se actualiza instantáneamente en el dashboard.',
    ),
    ProjectFeature(
      id: 'sales',
      title: 'Ventas Rápidas en Terreno',
      description:
          'Crea una nueva venta de material y comprueba su registro instantáneo.',
      targetPlatform: FeatureTargetPlatform.mobile,
      simulationScreens: [
        SimulationScreen(
          label: 'Formulario',
          builder: () => const SaleFormScreen(),
        ),
        SimulationScreen(
          label: 'Listado',
          builder: () => const SaleListScreen(),
        ),
      ],
      helpSteps: [
        HelpStep(
          stepNumber: 1,
          title: 'Ingresa el cliente',
          description: 'Nombre del comprador o "Público General".',
          top: 0.18,
          left: 0.08,
        ),
        HelpStep(
          stepNumber: 2,
          title: 'Ingresa el total',
          description: 'Valor total de la venta en COP.',
          top: 0.35,
          left: 0.08,
        ),
        HelpStep(
          stepNumber: 3,
          title: 'Selecciona estado',
          description: 'Pagado, Crédito o Parcial.',
          top: 0.52,
          left: 0.08,
        ),
        HelpStep(
          stepNumber: 4,
          title: 'Registra la venta',
          top: 0.70,
          left: 0.08,
        ),
        HelpStep(
          stepNumber: 5,
          title: 'Verifica en la lista',
          description: 'La venta aparece instantáneamente.',
          top: 0.20,
          left: 0.55,
        ),
      ],
      guide:
          '1. Selecciona un material (Arena Fina/Gruesa).\n2. Ingresa la cantidad en metros cúbicos.\n3. Confirma la venta y revisa el ticket generado.',
    ),
    ProjectFeature(
      id: 'cubicate',
      title: 'Herramienta de Cubicación',
      description:
          'Calcula las dimensiones de carga para obtener el volumen exacto.',
      targetPlatform: FeatureTargetPlatform.mobile,
      simulationScreens: [
        SimulationScreen(
          label: 'Calculadora',
          builder: () => const SandManagerCubicateSimulation(),
        ),
      ],
      helpSteps: [
        HelpStep(
          stepNumber: 1,
          title: 'Selecciona el modo',
          description: 'Capacidad o Altura.',
          top: 0.08,
          left: 0.10,
        ),
        HelpStep(
          stepNumber: 2,
          title: 'Ingresa dimensiones',
          description: 'Largo, Ancho y Alto del vehículo.',
          top: 0.30,
          left: 0.10,
        ),
        HelpStep(
          stepNumber: 3,
          title: 'Lee el resultado',
          description: 'El volumen se calcula automáticamente.',
          top: 0.60,
          left: 0.10,
        ),
      ],
      guide:
          '1. Ingresa las dimensiones del vehículo (Largo, Ancho, Alto).\n2. Ajusta el factor de compactación según el material.\n3. Obtén el volumen de carga preciso para el despacho.',
    ),
    ProjectFeature(
      id: 'inventory',
      title: 'Inventario & Traslados',
      description:
          'Control de stock por bodegas y gestión de traslados de material.',
      targetPlatform: FeatureTargetPlatform.mobile,
      simulationScreens: [
        SimulationScreen(
          label: 'Stock Actual',
          builder: () => const SandManagerInventorySimulation(),
        ),
      ],
      helpSteps: [
        HelpStep(
          stepNumber: 1,
          title: 'Estado de stock',
          description: 'Barras de progreso indican niveles críticos.',
          top: 0.25,
          left: 0.08,
        ),
        HelpStep(
          stepNumber: 2,
          title: 'Filtra por bodega',
          description: 'Visualiza materiales en Patio Norte o Sur.',
          top: 0.12,
          left: 0.55,
        ),
      ],
      guide:
          '1. Revisa el stock disponible de cada material.\n2. Identifica niveles bajos con las alertas visuales.\n3. Registra traslados entre patios para mantener el control.',
    ),
    ProjectFeature(
      id: 'clients',
      title: 'Gestión de Clientes',
      description: 'Directorio completo con seguimiento de carteras y deudas.',
      targetPlatform: FeatureTargetPlatform.mobile,
      simulationScreens: [
        SimulationScreen(
          label: 'Directorio',
          builder: () => const SandManagerClientsSimulation(),
        ),
      ],
      helpSteps: [
        HelpStep(
          stepNumber: 1,
          title: 'Busca un cliente',
          description: 'Encuentra constructores o independientes.',
          top: 0.12,
          left: 0.55,
        ),
        HelpStep(
          stepNumber: 2,
          title: 'Revisa deudas',
          description: 'El saldo pendiente se resalta en rojo.',
          top: 0.35,
          left: 0.65,
        ),
      ],
      guide:
          '1. Accede al directorio de clientes.\n2. Visualiza el estado de cuenta y deudas pendientes.\n3. Registra abonos o nuevos créditos de forma instantánea.',
    ),
    ProjectFeature(
      id: 'invoices',
      title: 'Facturación Electrónica',
      description:
          'Emisión de facturas válidas ante la DIAN directamente desde el terreno.',
      targetPlatform: FeatureTargetPlatform.mobile,
      simulationScreens: [
        SimulationScreen(
          label: 'Facturación',
          builder: () => const SandManagerInvoicesSimulation(),
        ),
      ],
      helpSteps: [
        HelpStep(
          stepNumber: 1,
          title: 'Historial',
          description: 'Listado de facturas emitidas y pendientes.',
          top: 0.30,
          left: 0.08,
        ),
        HelpStep(
          stepNumber: 2,
          title: 'Emitir DIAN',
          description: 'Botón rápido para sincronizar con el ente fiscal.',
          top: 0.75,
          left: 0.50,
        ),
      ],
      guide:
          '1. Selecciona una venta pendiente de facturar.\n2. Verifica los datos del cliente y montos.\n3. Presiona "Emitir" para enviar la factura electrónica instantáneamente.',
    ),
  ],
  imageUrl: 'assets/images/placeholder_portfolio.png',
  tags: ['Sand Management', 'Retail', 'Logistics'],

  // New Fields
  category: 'RETAIL & LOGISTICS',
  backgroundUrl:
      'lib/src/features/projects/catalog/sand_manager/assets/sand_manager_bg.mp4',
  isBackgroundVideo: true,
  concept:
      'Sand Manager es una solución 360° diseñada para digitalizar la operación de areneras y canteras, eliminando la dependencia del papel y proporcionando control total sobre las ventas y el flujo de caja desde cualquier lugar.',
  problem:
      'La falta de visibilidad en tiempo real de los flujos de caja y ventas en las areneras genera pérdidas operativas y errores en el despacho de materiales.',
  solution:
      'Una plataforma centralizada que permite el registro instantáneo de ventas y gastos, con dashboards dinámicos y herramientas de cubicación precisas.',
  storytelling:
      'Imagina una arenera donde cada metro cúbico cuenta. Sand Manager nació de la necesidad de transformar procesos manuales y lentos en una experiencia digital fluida y confiable, optimizando cada transacción desde el terreno hasta la administración.',

  conceptImageUrl:
      'lib/src/features/projects/catalog/sand_manager/assets/concept.png',
  historyImageUrl:
      'lib/src/features/projects/catalog/sand_manager/assets/history.png',
  problemSolutionImageUrl:
      'lib/src/features/projects/catalog/sand_manager/assets/problem_solution.png',

  styleDescription:
      'Diseño industrial minimalista con énfasis en legibilidad y contraste. Utilizamos superficies de vidrio (glassmorphism) sobre fondos oscuros para resaltar la información crítica, con una paleta de colores técnica y herramientas visuales intuitivas.',
  designScreens: [
    // --- MOBILE SCREENS ---
    SimulationScreen(
      label: 'Home Mobile',
      builder: () => const SandManagerMobileHomeView(),
      platform: ProjectPlatform.mobile,
    ),
    SimulationScreen(
      label: 'Ventas (Form)',
      builder: () => const SaleFormScreen(),
      platform: ProjectPlatform.mobile,
    ),
    SimulationScreen(
      label: 'Caja (Gasto)',
      builder: () => const CashboxFormScreen(),
      platform: ProjectPlatform.mobile,
    ),
    SimulationScreen(
      label: 'Inventario (Mobile)',
      builder: () => const SandManagerInventorySimulation(),
      platform: ProjectPlatform.mobile,
    ),
    SimulationScreen(
      label: 'Clientes (Mobile)',
      builder: () => const SandManagerClientsSimulation(),
      platform: ProjectPlatform.mobile,
    ),
    SimulationScreen(
      label: 'Facturación (Mobile)',
      builder: () => const SandManagerInvoicesSimulation(),
      platform: ProjectPlatform.mobile,
    ),
    SimulationScreen(
      label: 'Cubicación (Mobile)',
      builder: () => const SandManagerCubicateSimulation(),
      platform: ProjectPlatform.mobile,
    ),

    // --- WEB ADMIN SCREENS ---
    SimulationScreen(
      label: 'Dashboard Admin',
      builder: () => const SandManagerWebHomeView(),
      platform: ProjectPlatform.web,
    ),
    SimulationScreen(
      label: 'Login Admin',
      builder: () => const SandManagerWebAdminWrapper(
        title: 'AUTENTICACIÓN',
        child: SandManagerAuthSimulation(showAppBar: false),
      ),
      platform: ProjectPlatform.web,
    ),
    SimulationScreen(
      label: 'Clientes Admin',
      builder: () => const SandManagerWebAdminWrapper(
        title: 'CLIENTES',
        child: SandManagerClientsSimulation(showAppBar: false),
      ),
      platform: ProjectPlatform.web,
    ),
    SimulationScreen(
      label: 'Inventario Admin',
      builder: () => const SandManagerWebAdminWrapper(
        title: 'INVENTARIO',
        child: SandManagerInventorySimulation(showAppBar: false),
      ),
      platform: ProjectPlatform.web,
    ),
    SimulationScreen(
      label: 'Facturas Admin',
      builder: () => const SandManagerWebAdminWrapper(
        title: 'FACTURACIÓN',
        child: SandManagerInvoicesSimulation(showAppBar: false),
      ),
      platform: ProjectPlatform.web,
    ),
    SimulationScreen(
      label: 'Productos Admin',
      builder: () => const SandManagerWebAdminWrapper(
        title: 'PRODUCTOS',
        child: SandManagerProductsSimulation(showAppBar: false),
      ),
      platform: ProjectPlatform.web,
    ),
    SimulationScreen(
      label: 'Transportadores Admin',
      builder: () => const SandManagerWebAdminWrapper(
        title: 'TRANSPORTADORES',
        child: SandManagerTransportersSimulation(showAppBar: false),
      ),
      platform: ProjectPlatform.web,
    ),
  ],
  primaryColor: const Color(0xFFF39C12), // Deep yellow/amber
  onPrimaryColor: const Color(
    0xFF1E1E1E,
  ), // Dark contrasting color for text on primary
  technicalModules: const [
    TechnicalModule(
      name: 'Auth & Multi-role',
      isImplementedInMock: true,
      description: 'Login y gestión de roles.',
    ),
    TechnicalModule(
      name: 'Clients Management',
      isImplementedInMock: true,
      description: 'Directorio y deudas de clientes.',
    ),
    TechnicalModule(
      name: 'Inventory & Transfers',
      isImplementedInMock: true,
      description: 'Control de stock y bodegas.',
    ),
    TechnicalModule(
      name: 'Invoices',
      isImplementedInMock: true,
      description: 'Facturación electrónica.',
    ),
    TechnicalModule(
      name: 'Menu (Public Web)',
      isImplementedInMock: false,
      description: 'Catálogo público de materiales.',
    ),
    TechnicalModule(
      name: 'Products Management',
      isImplementedInMock: true,
      description: 'Creación y edición de materiales.',
    ),
    TechnicalModule(
      name: 'Transporters',
      isImplementedInMock: true,
      description: 'Gestión de conductores y vehículos.',
    ),
    TechnicalModule(
      name: 'Purchase History',
      isImplementedInMock: false,
      description: 'Historial de pagos a proveedores.',
    ),
    TechnicalModule(
      name: 'Sales (POS)',
      isImplementedInMock: true,
      description: 'Ventas en terreno e impresión de tickets.',
    ),
    TechnicalModule(
      name: 'Cashbox & Finances',
      isImplementedInMock: true,
      description: 'Flujo de caja y conciliación diaria.',
    ),
    TechnicalModule(
      name: 'Admin Dashboard',
      isImplementedInMock: true,
      description: 'Panel y gráficas administrativas.',
    ),
  ],
);
