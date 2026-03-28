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
      colors: [const Color(0xFF1a1b26), const Color(0xFF16213e)],
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
  UITrend(
    id: 'neumorphism',
    name: 'Neumorphism',
    tagline: 'Soft shadows, organic depth',
    description:
        'A transition between skeuomorphism and flat design. It relies on '
        'extremely soft, multiple box shadows to create an effect where '
        'elements appear as if they are pushed out from the background '
        'or pressed into it.',
    accentColor: const Color(0xFFD1D9E6),
    secondaryAccent: const Color(0xFFFFFFFF),
    bgColor: const Color(0xFFE0E5EC),
    surfaceColor: const Color(0xFFE0E5EC),
    textColor: const Color(0xFF44474A),
    subtleTextColor: const Color(0xFF707478),
    palette: [
      const Color(0xFFE0E5EC),
      const Color(0xFFFFFFFF),
      const Color(0xFFA3B1C6),
    ],
    keywords: ['soft UI', 'shadows', 'tactile', 'organic', 'minimal'],
    backgroundGradient: const LinearGradient(
      colors: [Color(0xFFE0E5EC), Color(0xFFF0F4F8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  UITrend(
    id: 'lumine_glow',
    name: 'Lumine Glow',
    tagline: 'Radiant intensity through light',
    description:
        'Focuses on back-glow and warm, radiant intensity. Elements '
        'cast vibrant, blurred glows onto the surface behind them, '
        'creating a futuristic "cyber-warm" aesthetic.',
    accentColor: const Color(0xFFFFB347),
    secondaryAccent: const Color(0xFFFFD194),
    bgColor: const Color(0xFF1A1412),
    surfaceColor: const Color(0xFF2D2420),
    textColor: Colors.white,
    subtleTextColor: const Color(0xFFB3A29E),
    palette: [
      const Color(0xFF1A1412),
      const Color(0xFFFFB347),
      const Color(0xFFFFD194),
    ],
    keywords: ['glow', 'amber', 'lighting', 'neon', 'depth'],
    backgroundGradient: const LinearGradient(
      colors: [Color(0xFF1A1412), Color(0xFF2D2420)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
  UITrend(
    id: 'holo_glass',
    name: 'Holo Glass',
    tagline: 'Refracted chromacity on glass',
    description:
        'An evolution of Glassmorphism that adds "Refracted Chromacity." '
        'The edges of glass elements catch light in a holographic or '
        'rainbow spectrum, simulating chromatic aberration.',
    accentColor: const Color(0xFF00F2FF),
    secondaryAccent: const Color(0xFFFF00E5),
    bgColor: const Color(0xFF0F172A),
    surfaceColor: const Color(0x1A64748B),
    textColor: Colors.white,
    subtleTextColor: const Color(0xFF94A3B8),
    palette: [
      const Color(0xFFF8F9FF),
      const Color(0xFF00F2FF),
      const Color(0xFFFF00E5),
    ],
    keywords: ['iridescent', 'holographic', 'refraction', 'glossy'],
    backgroundGradient: const LinearGradient(
      colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  UITrend(
    id: 'mono_archive',
    name: 'Mono Archive',
    tagline: 'Structural retro organization',
    description:
        'A "Dossier-style" aesthetic that prioritizes organization and '
        'data hierarchy through physical metaphors like tab stacks and '
        'file folders. Raw and functional.',
    accentColor: const Color(0xFF000000),
    secondaryAccent: const Color(0xFF808080),
    bgColor: const Color(0xFFD1D1D1),
    surfaceColor: const Color(0xFFF2F2F2),
    textColor: Colors.black,
    subtleTextColor: const Color(0xFF555555),
    palette: [
      const Color(0xFFD1D1D1),
      const Color(0xFF000000),
      const Color(0xFFF2F2F2),
    ],
    keywords: ['archive', 'dossier', 'structural', 'brutalist'],
    backgroundGradient: const LinearGradient(
      colors: [Color(0xFFD1D1D1), Color(0xFFC0C0C0)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
  UITrend(
    id: 'tactile_industrial',
    name: 'Tactile Industrial',
    tagline: 'Mechanical precision hardware',
    description:
        'Inspired by military and industrial hardware. Analog knobs, '
        'sliders, and brushed metal textures focus on clarity and '
        'sensory confirmation.',
    accentColor: const Color(0xFFFF6B00),
    secondaryAccent: const Color(0xFF4A4D50),
    bgColor: const Color(0xFF2B2D31),
    surfaceColor: const Color(0xFF3A3D40),
    textColor: Colors.white,
    subtleTextColor: const Color(0xFFA0A3A6),
    palette: [
      const Color(0xFF3A3D40),
      const Color(0xFFFF6B00),
      const Color(0xFF4A4D50),
    ],
    keywords: ['industrial', 'skeuomorphic', 'tactile', 'mechanical'],
    backgroundGradient: const LinearGradient(
      colors: [Color(0xFF2B2D31), Color(0xFF1F2124)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
];
