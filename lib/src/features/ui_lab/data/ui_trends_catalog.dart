import 'package:flutter/material.dart';
import '../domain/ui_trend.dart';

final List<UITrend> uiTrendsCatalog = [
  UITrend(
    id: 'glassmorphism',
    name: 'Glassmorphism',
    tagline: 'Frosted light through soft dimensions',
    description:
        'Glassmorphism uses backdrop blur and semi-transparent surfaces '
        'to create a sense of depth, layering translucent panels over '
        'vibrant gradients. Heavy on whites and pastels with subtle '
        'borders that catch the light.',
    accentColor: const Color(0xFF9B59B6),
    secondaryAccent: const Color(0xFF3498DB),
    bgColor: const Color(0xFFE0C3FC),
    surfaceColor: Colors.white,
    textColor: const Color(0xFF1A1A2E),
    subtleTextColor: const Color(0xFF555577),
    palette: [
      const Color(0xFFE0C3FC),
      const Color(0xFF8EC5FC),
      const Color(0xFFFFFFFF),
      const Color(0xFF9B59B6),
      const Color(0xFF3498DB),
    ],
    keywords: ['blur', 'translucent', 'frosted', 'pastel', 'depth', 'light'],
    backgroundGradient: const LinearGradient(
      colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  UITrend(
    id: 'tokyo_night',
    name: 'Tokyo Night',
    tagline: 'Neon rain on midnight streets',
    description:
        'Inspired by the cyberpunk skylines of Tokyo after dark. '
        'Ultra-dark backgrounds with vivid neon accents in magenta, '
        'cyan and violet create an atmospheric and immersive feeling. '
        'High contrast, glowing shadows and dramatic typography.',
    accentColor: const Color(0xFFff007c),
    secondaryAccent: const Color(0xFF00e5ff),
    bgColor: const Color(0xFF1a1b26),
    surfaceColor: const Color(0xFF24283b),
    textColor: Colors.white,
    subtleTextColor: const Color(0xFF7aa2f7),
    palette: [
      const Color(0xFF1a1b26),
      const Color(0xFF24283b),
      const Color(0xFFff007c),
      const Color(0xFF00e5ff),
      const Color(0xFF7aa2f7),
    ],
    keywords: ['neon', 'dark', 'cyberpunk', 'glow', 'contrast', 'night'],
    backgroundGradient: LinearGradient(
      colors: [
        const Color(0xFF1a1b26),
        const Color(0xFF16213e),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
  UITrend(
    id: 'neo_clean',
    name: 'Neo Clean',
    tagline: 'Brutal clarity, intentional noise',
    description:
        'Neo-Brutalism strips away digital ornamentation to expose '
        'raw structure. Hard blacks, clean whites, thick borders and '
        'stark drop shadows make every element feel decisive and '
        'intentional. Influenced by Swiss typography and DIY zines.',
    accentColor: const Color(0xFF000000),
    secondaryAccent: const Color(0xFFFF3B30),
    bgColor: const Color(0xFFF5F5F5),
    surfaceColor: Colors.white,
    textColor: Colors.black,
    subtleTextColor: const Color(0xFF555555),
    palette: [
      const Color(0xFFF5F5F5),
      Colors.white,
      Colors.black,
      const Color(0xFFFF3B30),
      const Color(0xFFFFCC00),
    ],
    keywords: ['brutalism', 'bold', 'raw', 'swiss', 'stark', 'minimal'],
    backgroundGradient: const LinearGradient(
      colors: [Color(0xFFF5F5F5), Color(0xFFEEEEEE)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
];
