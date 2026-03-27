import 'package:flutter/material.dart';
import '../domain/lab_feature.dart';
import '../presentation/styles_gallery_feature.dart';

List<LabGroup> get labFeatures => [
  LabGroup(
    id: 'auth',
    title: 'Authentication',
    icon: Icons.lock,
    features: [
      LabFeature(
        id: 'login_password',
        title: 'Login & Password',
        description:
            'Validation with Regex, visibility toggle, and loading/error states.',
        builder: (context) =>
            const Center(child: Text('Login & Password Demo')),
      ),
      LabFeature(
        id: 'social_auth',
        title: 'Social Auth',
        description:
            'Brand buttons (Google, Apple, Facebook) with adaptive design.',
        builder: (context) => const Center(child: Text('Social Auth Demo')),
      ),
      LabFeature(
        id: 'qr_auth',
        title: 'QR Auth',
        description: 'QR generation and "handshake" flow simulation.',
        builder: (context) => const Center(child: Text('QR Auth Demo')),
      ),
      LabFeature(
        id: 'biometric_gateway',
        title: 'Biometric Gateway',
        description:
            'Fallback interface for biometrics and scanning animations.',
        builder: (context) =>
            const Center(child: Text('Biometric Gateway Demo')),
      ),
    ],
  ),
  LabGroup(
    id: 'forms',
    title: 'Forms & Inputs',
    icon: Icons.edit_note,
    features: [
      LabFeature(
        id: 'large_form',
        title: 'Large Form',
        description: 'Scroll-to-error and visual categorization.',
        builder: (context) => const Center(child: Text('Large Form Demo')),
      ),
      LabFeature(
        id: 'stepper_form',
        title: 'Stepper Form',
        description:
            'Memory persistence between steps and animated progress bar.',
        builder: (context) => const Center(child: Text('Stepper Form Demo')),
      ),
      LabFeature(
        id: 'checkout_form',
        title: 'Checkout Form',
        description: 'Credit card input masking and validation.',
        builder: (context) => const Center(child: Text('Checkout Form Demo')),
      ),
      LabFeature(
        id: 'search_filters',
        title: 'Search Filters',
        description: 'Interactive chips for multiple filtering.',
        builder: (context) => const Center(child: Text('Search Filters Demo')),
      ),
    ],
  ),
  LabGroup(
    id: 'tasks_manage',
    title: 'Task Management',
    icon: Icons.task,
    features: [
      LabFeature(
        id: 'kanban_board',
        title: 'Kanban Board',
        description: 'Drag and Drop between columns (To Do, Doing, Done).',
        builder: (context) => const Center(child: Text('Kanban Board Demo')),
      ),
      LabFeature(
        id: 'todo_list',
        title: 'Todo List',
        description: 'Swipe-to-dismiss actions and item reordering.',
        builder: (context) => const Center(child: Text('Todo List Demo')),
      ),
      LabFeature(
        id: 'task_detail',
        title: 'Task Detail',
        description: 'Inline editing and contextual selectors.',
        builder: (context) => const Center(child: Text('Task Detail Demo')),
      ),
    ],
  ),
  LabGroup(
    id: 'feed_lists',
    title: 'Feeds & Lists',
    icon: Icons.list,
    features: [
      LabFeature(
        id: 'infinite_scroll',
        title: 'Infinite Scroll',
        description: 'Async pagination, Shimmer loading, and memory control.',
        builder: (context) => const Center(child: Text('Infinite Scroll Demo')),
      ),
      LabFeature(
        id: 'interactive_cards',
        title: 'Interactive Cards',
        description: 'Hero animations and quick action buttons.',
        builder: (context) =>
            const Center(child: Text('Interactive Cards Demo')),
      ),
      LabFeature(
        id: 'pull_to_refresh',
        title: 'Pull to Refresh',
        description: 'Haptic and visual feedback on refresh.',
        builder: (context) => const Center(child: Text('Pull to Refresh Demo')),
      ),
    ],
  ),
  LabGroup(
    id: 'maps',
    title: 'Maps & Geo',
    icon: Icons.map,
    features: [
      LabFeature(
        id: 'location_picker',
        title: 'Location Picker',
        description: 'Fixed center marker and reverse geocoding.',
        builder: (context) => const Center(child: Text('Location Picker Demo')),
      ),
      LabFeature(
        id: 'poi_navigation',
        title: 'POI Navigation',
        description: 'Bottom sheet expansion and camera animation.',
        builder: (context) => const Center(child: Text('POI Navigation Demo')),
      ),
      LabFeature(
        id: 'real_time_tracking',
        title: 'Real-time Tracking',
        description: 'Marker movement smoothing (interpolation).',
        builder: (context) =>
            const Center(child: Text('Real-time Tracking Demo')),
      ),
    ],
  ),
  LabGroup(
    id: 'billing',
    title: 'Billing & Finance',
    icon: Icons.attach_money,
    features: [
      LabFeature(
        id: 'invoice_history',
        title: 'Invoice History',
        description: 'Filters by date/status and receipt preview.',
        builder: (context) => const Center(child: Text('Invoice History Demo')),
      ),
      LabFeature(
        id: 'subscription_plans',
        title: 'Subscription Plans',
        description: 'Monthly/Annual switch with savings calculation.',
        builder: (context) =>
            const Center(child: Text('Subscription Plans Demo')),
      ),
      LabFeature(
        id: 'payment_methods',
        title: 'Payment Methods',
        description: 'Digital wallet UI and default selection.',
        builder: (context) => const Center(child: Text('Payment Methods Demo')),
      ),
    ],
  ),
  LabGroup(
    id: 'user_profile',
    title: 'User Profile',
    icon: Icons.person,
    features: [
      LabFeature(
        id: 'profile_header',
        title: 'Profile Header',
        description: 'Collapsible SliverAppBar and avatar change.',
        builder: (context) => const Center(child: Text('Profile Header Demo')),
      ),
      LabFeature(
        id: 'account_settings',
        title: 'Account Settings',
        description: 'Sectioned settings with toggles.',
        builder: (context) =>
            const Center(child: Text('Account Settings Demo')),
      ),
    ],
  ),
  LabGroup(
    id: 'trends',
    title: 'UI Trends & Aesthetics',
    icon: Icons.style,
    features: [
      LabFeature(
        id: 'styles_gallery',
        title: 'Styles Gallery',
        description:
            'Glassmorphism, Tokyo Night, and Neo Brutalism explorations.',
        builder: (context) => const StylesGalleryFeature(),
      ),
    ],
  ),
];
