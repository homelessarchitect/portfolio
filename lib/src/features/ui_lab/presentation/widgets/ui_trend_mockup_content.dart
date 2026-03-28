import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/ui_trend.dart';

/// The type of UI screen to render inside the device mockup.
enum UITrendViewType { login, form, cards, carousel }

/// Full scrollable screen content rendered inside a DeviceMockup for a given UITrend.
/// Shared between StylesGalleryFeature and UITrendDetailScreen / UITrendDesignExplorer.
class UITrendMockupContent extends StatelessWidget {
  final UITrend trend;
  final UITrendViewType viewType;

  /// Optional accent color override (used when a palette swatch is selected).
  final Color? accentOverride;

  const UITrendMockupContent({
    super.key,
    required this.trend,
    this.viewType = UITrendViewType.cards,
    this.accentOverride,
  });

  Color get _accent => accentOverride ?? trend.accentColor;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: [
        _buildAppBar(),
        Padding(padding: const EdgeInsets.all(24), child: _buildBody()),
      ],
    );

    if (trend.id == 'lumine_glow' || trend.id == 'holo_glass') {
      final isHolo = trend.id == 'holo_glass';
      return Container(
        color: _bgColor,
        child: Stack(
          children: [
            // Floating accent glow
            Positioned(
              top: isHolo ? 20 : -80,
              right: isHolo ? -100 : -50,
              child: Container(
                width: isHolo ? 300 : 250,
                height: isHolo ? 300 : 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isHolo ? const Color(0xFF00F2FF) : trend.accentColor)
                      .withValues(alpha: 0.12),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                  child: const SizedBox.shrink(),
                ),
              ),
            ),
            if (isHolo)
              Positioned(
                bottom: 80,
                left: -80,
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFF00E5).withValues(alpha: 0.12),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                    child: const SizedBox.shrink(),
                  ),
                ),
              ),
            content,
          ],
        ),
      );
    }

    return Container(
      color: _bgColor,
      child: content,
    );
  }

  // ── Background color ──────────────────────────────────────────────────────
  Color get _bgColor {
    switch (trend.id) {
      case 'glassmorphism':
        return const Color(0xFFF3E5F5);
      case 'tokyo_night':
        return const Color(0xFF16161e);
      case 'neumorphism':
        return const Color(0xFFE0E5EC);
      case 'lumine_glow':
        return const Color(0xFF0A0A0F);
      case 'holo_glass':
        return const Color(0xFF0F172A);
      case 'mono_archive':
        return const Color(0xFFE5E5E5);
      case 'tactile_industrial':
        return const Color(0xFF242424);
      default:
        return Colors.white;
    }
  }

  // ── Body dispatcher ───────────────────────────────────────────────────────
  Widget _buildBody() {
    switch (viewType) {
      case UITrendViewType.login:
        return _buildLoginView();
      case UITrendViewType.form:
        return _buildFormView();
      case UITrendViewType.cards:
        return _buildCardsView();
      case UITrendViewType.carousel:
        return _buildCarouselView();
    }
  }

  // ── App Bar ──────────────────────────────────────────────────────────────
  Widget _buildAppBar() {
    switch (trend.id) {
      case 'glassmorphism':
        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 72,
              color: Colors.white.withValues(alpha: 0.2),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Vitrine',
                    style: TextStyle(
                      color: trend.textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    child: const Icon(Icons.person, size: 18),
                  ),
                ],
              ),
            ),
          ),
        );

      case 'tokyo_night':
        return Container(
          height: 72,
          color: trend.surfaceColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'NightOS',
                style: TextStyle(
                  color: trend.secondaryAccent,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(color: trend.secondaryAccent, blurRadius: 10),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(color: _accent, width: 1.5),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _accent.withValues(alpha: 0.4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Icon(Icons.person_outline, color: _accent, size: 18),
              ),
            ],
          ),
        );

      case 'neumorphism':
        return Container(
          height: 72,
          color: trend.bgColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'SoftView',
                style: TextStyle(
                  color: trend.textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const Spacer(),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: trend.bgColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(-3, -3),
                      blurRadius: 6,
                    ),
                    BoxShadow(
                      color: const Color(0xFFA3B1C6).withValues(alpha: 0.5),
                      offset: const Offset(3, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Icon(Icons.person, color: trend.textColor, size: 20),
              ),
            ],
          ),
        );

      case 'lumine_glow':
        return Container(
          height: 72,
          color: const Color(0xFF0F0F15),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Radiant',
                style: TextStyle(
                  color: trend.accentColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(color: trend.accentColor, blurRadius: 20),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [trend.accentColor, trend.secondaryAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: trend.accentColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 18),
              ),
            ],
          ),
        );

      case 'holo_glass':
        return Container(
          height: 72,
          color: Colors.white.withValues(alpha: 0.05),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 1.5,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF00F2FF),
                        Color(0xFF00FF88),
                        Color(0xFFFFFF00),
                        Color(0xFFFF00E5),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Prisma',
                      style: TextStyle(
                        color: trend.textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF00F2FF).withValues(alpha: 0.5),
                        ),
                      ),
                      child: const Icon(Icons.blur_on, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case 'mono_archive':
        return Container(
          height: 80,
          color: const Color(0xFFCCCCCC),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'ARCHIVE-01',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Structural',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: const Icon(Icons.folder_open, size: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case 'tactile_industrial':
        return Container(
          height: 80,
          color: const Color(0xFF1F1F1F),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF6B00), Colors.transparent],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B00),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFFFF6B00).withValues(alpha: 0.5), blurRadius: 4),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'MODULE_01',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.settings_input_component, color: Color(0xFF606060), size: 18),
                ],
              ),
            ],
          ),
        );

      default: // neo_clean
        return Container(
          height: 72,
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'BRUTALIST',
                style: TextStyle(
                  color: trend.surfaceColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                ),
              ),
              const Spacer(),
              Container(
                width: 36,
                height: 36,
                color: trend.surfaceColor,
                child: const Icon(Icons.person, size: 18, color: Colors.black),
              ),
            ],
          ),
        );
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  VIEW 1 — LOGIN
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildLoginView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        _buildPageTitle('Bienvenido'),
        const SizedBox(height: 8),
        _styledSubtitle('Inicia sesión para continuar'),
        const SizedBox(height: 40),
        _buildField('Correo electrónico', Icons.email_outlined),
        const SizedBox(height: 16),
        _buildField('Contraseña', Icons.lock_outline, isPassword: true),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '¿Olvidaste tu contraseña?',
            style: TextStyle(
              color: _accent,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _buildPrimaryButton('Iniciar sesión', Icons.arrow_forward),
        const SizedBox(height: 24),
        Center(
          child: Text(
            '¿No tienes cuenta? Regístrate',
            style: TextStyle(color: trend.subtleTextColor, fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  VIEW 2 — FORM
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildFormView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        _buildPageTitle('Nuevo Registro'),
        const SizedBox(height: 4),
        _styledSubtitle('Completa los campos requeridos'),
        const SizedBox(height: 32),
        _fieldLabel('Nombre completo'),
        _buildField('Juan García', Icons.person_outline),
        const SizedBox(height: 16),
        _fieldLabel('Correo electrónico'),
        _buildField('correo@ejemplo.com', Icons.email_outlined),
        const SizedBox(height: 16),
        _fieldLabel('Categoría'),
        _buildSelectField('Seleccionar...'),
        const SizedBox(height: 16),
        _fieldLabel('Notas adicionales'),
        _buildTextArea(),
        const SizedBox(height: 32),
        _buildPrimaryButton('Guardar registro', Icons.check),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  VIEW 3 — CARDS (default, same as original)
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildCardsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildPageTitle('Dashboard'),
        _styledSubtitle(_viewSubtitle),
        const SizedBox(height: 32),
        _buildCard(
          title: 'Transaction',
          subtitle: 'Frosted glass effect',
          icon: Icons.bubble_chart,
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'Analytics',
          subtitle: 'Real-time metrics',
          icon: Icons.bar_chart,
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'Settings',
          subtitle: 'Configure your profile',
          icon: Icons.settings_outlined,
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  VIEW 4 — CAROUSEL
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildCarouselView() {
    final items = trend.keywords;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        _buildPageTitle('Explorar'),
        _styledSubtitle('Tendencias de diseño'),
        const SizedBox(height: 32),

        // Horizontal mini-cards
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, i) => _buildCarouselCard(items[i]),
          ),
        ),

        const SizedBox(height: 32),
        _fieldLabel('Destacados'),
        const SizedBox(height: 12),
        _buildCard(
          title: 'Tendencia #1',
          subtitle: items.first,
          icon: Icons.star,
        ),
        const SizedBox(height: 12),
        _buildCard(
          title: 'Tendencia #2',
          subtitle: items.last,
          icon: Icons.trending_up,
        ),
      ],
    );
  }

  // ── Shared builders ───────────────────────────────────────────────────────
  String get _viewSubtitle {
    switch (trend.id) {
      case 'glassmorphism':
        return 'Glassmorphism aesthetics';
      case 'tokyo_night':
        return 'Cyberpunk neon aesthetics';
      case 'neumorphism':
        return 'Soft UI soft-shadow aesthetics';
      case 'lumine_glow':
        return 'Radiant neon glow aesthetics';
      case 'holo_glass':
        return 'Refracted glass aesthetics';
      default:
        return 'Clean & Minimal aesthetics';
    }
  }

  Widget _buildPageTitle(String text) {
    final isNight = trend.id == 'tokyo_night';
    return Text(
      text,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: trend.textColor,
        shadows: isNight ? [Shadow(color: _accent, blurRadius: 10)] : null,
      ),
    );
  }

  Widget _styledSubtitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: trend.subtleTextColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: trend.subtleTextColor,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildField(String hint, IconData icon, {bool isPassword = false}) {
    switch (trend.id) {
      case 'glassmorphism':
        return ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              ),
              child: Row(
                children: [
                  Icon(
                    isPassword ? Icons.lock_outline : icon,
                    color: _accent,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      hint,
                      style: TextStyle(
                        color: trend.subtleTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  if (isPassword)
                    Icon(
                      Icons.visibility_outlined,
                      color: trend.subtleTextColor,
                      size: 16,
                    ),
                ],
              ),
            ),
          ),
        );
      case 'tokyo_night':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accent.withValues(alpha: 0.4), width: 1),
            boxShadow: [
              BoxShadow(color: _accent.withValues(alpha: 0.1), blurRadius: 10),
            ],
          ),
          child: Row(
            children: [
              Icon(
                isPassword ? Icons.lock_outline : icon,
                color: _accent,
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hint,
                  style: TextStyle(color: trend.subtleTextColor, fontSize: 14),
                ),
              ),
              if (isPassword)
                Icon(Icons.visibility_outlined, color: _accent, size: 16),
            ],
          ),
        );
      case 'neumorphism':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: trend.bgColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFA3B1C6).withValues(alpha: 0.4),
                offset: const Offset(3, 3),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Colors.white,
                offset: const Offset(-3, -3),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                isPassword ? Icons.lock_outline : icon,
                color: trend.subtleTextColor,
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hint,
                  style: TextStyle(
                    color: trend.subtleTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
              if (isPassword)
                Icon(
                  Icons.visibility_off_outlined,
                  color: trend.subtleTextColor,
                  size: 16,
                ),
            ],
          ),
        );
      case 'lumine_glow':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A24),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: trend.accentColor.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isPassword ? Icons.lock_outline : icon,
                color: trend.accentColor,
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hint,
                  style: TextStyle(
                    color: trend.subtleTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
              if (isPassword)
                Icon(
                  Icons.remove_red_eye_outlined,
                  color: trend.accentColor,
                  size: 16,
                ),
            ],
          ),
        );

      case 'holo_glass':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 40,
                  height: 1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00F2FF), Color(0xFFFF00E5)],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    isPassword ? Icons.lock_outline : icon,
                    color: const Color(0xFF00F2FF),
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      hint,
                      style: TextStyle(
                        color: trend.subtleTextColor,
                        fontSize: 14,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  if (isPassword)
                    const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Color(0xFFFF00E5),
                      size: 16,
                    ),
                ],
              ),
            ],
          ),
        );
      case 'mono_archive':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    color: Colors.black,
                    child: Text(
                      isPassword ? 'SECURE_KEY' : 'DATA_INPUT',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hint,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: Colors.black45,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(icon, color: Colors.black, size: 18),
            ],
          ),
        );
      case 'tactile_industrial':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            border: Border.all(color: const Color(0xFF404040), width: 1.5),
          ),
          child: Row(
            children: [
              Icon(
                isPassword ? Icons.security : icon,
                color: const Color(0xFFFF6B00),
                size: 18,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      hint.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF808080),
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'READY_STATE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      default: // neo_clean
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(3, 3)),
            ],
          ),
          child: Row(
            children: [
              Icon(
                isPassword ? Icons.lock_outline : icon,
                color: Colors.black,
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hint,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ),
              if (isPassword)
                const Icon(
                  Icons.visibility_outlined,
                  color: Colors.black38,
                  size: 16,
                ),
            ],
          ),
        );
    }
  }

  Widget _buildSelectField(String hint) {
    switch (trend.id) {
      case 'glassmorphism':
        return ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              ),
              child: Row(
                children: [
                  Icon(Icons.category_outlined, color: _accent, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      hint,
                      style: TextStyle(
                        color: trend.subtleTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.expand_more,
                    color: trend.subtleTextColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        );
      case 'tokyo_night':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accent.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Icon(Icons.category_outlined, color: _accent, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hint,
                  style: TextStyle(color: trend.subtleTextColor, fontSize: 14),
                ),
              ),
              Icon(Icons.expand_more, color: _accent, size: 18),
            ],
          ),
        );
      case 'neumorphism':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: trend.bgColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFA3B1C6).withValues(alpha: 0.4),
                offset: const Offset(3, 3),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Colors.white,
                offset: const Offset(-3, -3),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.category_outlined, color: trend.subtleTextColor, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hint,
                  style: TextStyle(color: trend.subtleTextColor, fontSize: 13),
                ),
              ),
              Icon(Icons.expand_more, color: trend.subtleTextColor, size: 18),
            ],
          ),
        );
      case 'lumine_glow':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A24),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: trend.accentColor.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.category_outlined, color: trend.accentColor, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hint,
                  style: TextStyle(color: trend.subtleTextColor, fontSize: 13),
                ),
              ),
              Icon(Icons.expand_more, color: trend.accentColor, size: 18),
            ],
          ),
        );
      case 'holo_glass':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 10,
                right: 10,
                child: Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00F2FF), Color(0xFFFF00E5)],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.blur_on, color: Color(0xFF00F2FF), size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      hint,
                      style: TextStyle(
                        color: trend.subtleTextColor,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Icon(Icons.expand_more, color: Color(0xFFFF00E5), size: 18),
                ],
              ),
            ],
          ),
        );
      case 'mono_archive':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          child: Row(
            children: [
              Text(
                hint,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              const Icon(Icons.unfold_more, color: Colors.black, size: 18),
            ],
          ),
        );
      case 'tactile_industrial':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            border: Border.all(color: const Color(0xFF404040), width: 1.5),
          ),
          child: Row(
            children: [
              const Icon(Icons.tune, color: Color(0xFFFF6B00), size: 18),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  hint.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Color(0xFFFF6B00)),
            ],
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(3, 3)),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.category_outlined,
                color: Colors.black,
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hint,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ),
              const Icon(Icons.expand_more, color: Colors.black, size: 18),
            ],
          ),
        );
    }
  }

  Widget _buildTextArea() {
    switch (trend.id) {
      case 'glassmorphism':
        return ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 80,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              ),
              child: Text(
                'Escribe aquí...',
                style: TextStyle(color: trend.subtleTextColor, fontSize: 13),
              ),
            ),
          ),
        );
      case 'tokyo_night':
        return Container(
          height: 80,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accent.withValues(alpha: 0.4)),
          ),
          child: Text(
            'Escribe aquí...',
            style: TextStyle(color: trend.subtleTextColor, fontSize: 13),
          ),
        );
      case 'neumorphism':
        return Container(
          height: 80,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: trend.bgColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFA3B1C6).withValues(alpha: 0.4),
                offset: const Offset(3, 3),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Colors.white,
                offset: const Offset(-4, -4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Text(
            'Escribe aquí...',
            style: TextStyle(color: trend.subtleTextColor, fontSize: 13),
          ),
        );
      case 'lumine_glow':
        return Container(
          height: 80,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A24),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: trend.accentColor.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Text(
            'Escribe aquí...',
            style: TextStyle(color: trend.subtleTextColor, fontSize: 13),
          ),
        );
      case 'holo_glass':
        return Container(
          height: 100,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 10,
                child: Container(
                  width: 30,
                  height: 1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00F2FF), Color(0xFFFF00E5)],
                    ),
                  ),
                ),
              ),
              Text(
                'Escribe aquí...',
                style: TextStyle(
                  color: trend.subtleTextColor.withValues(alpha: 0.7),
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      case 'mono_archive':
        return Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'LOG_CONTENT_START',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(color: Colors.black, height: 12),
              Text(
                'Ready for input sequence...',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.black.withValues(alpha: 0.6),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        );
      case 'tactile_industrial':
        return Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            border: Border.all(color: const Color(0xFF404040), width: 2),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.terminal, color: Color(0xFFFF6B00), size: 14),
                  SizedBox(width: 8),
                  Text(
                    'CONSOLE_OUTPUT',
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '>> SYSTEM_READY',
                style: TextStyle(
                  color: Color(0xFFFF6B00),
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                '>> LISTENING_FOR_SIGNAL...',
                style: TextStyle(
                  color: Color(0xFFFF6B00),
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        );
      default:
        return Container(
          height: 80,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(3, 3)),
            ],
          ),
          child: const Text(
            'Escribe aquí...',
            style: TextStyle(color: Colors.black38, fontSize: 13),
          ),
        );
    }
  }

  Widget _buildPrimaryButton(String label, IconData icon) {
    switch (trend.id) {
      case 'glassmorphism':
        return ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _accent.withValues(alpha: 0.6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: trend.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(icon, color: trend.textColor, size: 18),
                ],
              ),
            ),
          ),
        );

      case 'tokyo_night':
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: _accent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: _accent.withValues(alpha: 0.5),
                blurRadius: 20,
                spreadRadius: -4,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: Colors.white, size: 18),
            ],
          ),
        );

      case 'neumorphism':
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: trend.bgColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: const Offset(-5, -5),
                blurRadius: 10,
              ),
              BoxShadow(
                color: const Color(0xFFA3B1C6).withValues(alpha: 0.5),
                offset: const Offset(5, 5),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: trend.textColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: trend.textColor, size: 18),
            ],
          ),
        );

      case 'lumine_glow':
        return Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [trend.accentColor, trend.secondaryAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: trend.accentColor.withValues(alpha: 0.4),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: Colors.white, size: 18),
            ],
          ),
        );

      case 'holo_glass':
        return Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              colors: [
                const Color(0xFF00F2FF).withValues(alpha: 0.8),
                const Color(0xFFFF00E5).withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00F2FF).withValues(alpha: 0.3),
                blurRadius: 15,
                spreadRadius: -2,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 2,
                left: 10,
                right: 10,
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(icon, color: Colors.white, size: 18),
                ],
              ),
            ],
          ),
        );

      case 'mono_archive':
        return Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 2,
                top: 2,
                right: 2,
                bottom: 2,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(icon, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ],
          ),
        );

      case 'tactile_industrial':
        return Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B00),
            border: const Border(
              bottom: BorderSide(color: Color(0xFF913D00), width: 4),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6B00).withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(icon, color: Colors.white, size: 20),
              ],
            ),
          ),
        );

      default: // neo_clean
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: trend.accentColor,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(4, 4)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: trend.surfaceColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: trend.surfaceColor, size: 18),
            ],
          ),
        );
    }
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    switch (trend.id) {
      case 'glassmorphism':
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: _accent.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: _accent, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: trend.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: trend.subtleTextColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

      case 'tokyo_night':
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _accent.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(color: _accent.withValues(alpha: 0.05), blurRadius: 10),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: _accent, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: trend.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: trend.subtleTextColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case 'neumorphism':
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: trend.bgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: const Offset(-5, -5),
                blurRadius: 10,
              ),
              BoxShadow(
                color: const Color(0xFFA3B1C6).withValues(alpha: 0.4),
                offset: const Offset(5, 5),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: trend.bgColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(-2, -2),
                      blurRadius: 5,
                    ),
                    BoxShadow(
                      color: const Color(0xFFA3B1C6).withValues(alpha: 0.3),
                      offset: const Offset(2, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Icon(icon, color: trend.textColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: trend.textColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: trend.subtleTextColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case 'lumine_glow':
        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2A),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: trend.accentColor.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: trend.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: trend.accentColor, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: trend.subtleTextColor,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: trend.accentColor.withValues(alpha: 0.5),
              ),
            ],
          ),
        );

      case 'holo_glass':
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF00F2FF), Color(0xFFFF00E5)],
                      ).createShader(bounds),
                      child: Icon(icon, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case 'mono_archive':
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            children: [
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                ),
                child: Row(
                  children: [
                    Container(width: 8, height: 8, color: Colors.black),
                    const SizedBox(width: 8),
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.close, size: 14),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.black, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'META_DATA_REF: 0X4F92',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case 'tactile_industrial':
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF242424),
            border: Border.all(color: const Color(0xFF404040), width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFF6B00), width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(icon, color: const Color(0xFFFF6B00), size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF808080),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Column(
                children: [
                  Icon(Icons.adjust_outlined, color: Color(0xFF404040), size: 12),
                  SizedBox(height: 8),
                  Icon(Icons.adjust_outlined, color: Color(0xFF404040), size: 12),
                ],
              ),
            ],
          ),
        );

      default: // neo_clean
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(4, 4)),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black, size: 24),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    subtitle.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
    }
  }

  Widget _buildCarouselCard(String label) {
    switch (trend.id) {
      case 'glassmorphism':
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 90,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome, color: _accent, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: trend.textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      case 'tokyo_night':
        return Container(
          width: 90,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _accent.withValues(alpha: 0.4)),
            boxShadow: [
              BoxShadow(color: _accent.withValues(alpha: 0.15), blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome, color: _accent, size: 24),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: trend.subtleTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      case 'neumorphism':
        return Container(
          width: 90,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: trend.bgColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: const Offset(-4, -4),
                blurRadius: 8,
              ),
              BoxShadow(
                color: const Color(0xFFA3B1C6).withValues(alpha: 0.4),
                offset: const Offset(4, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome, color: trend.textColor, size: 24),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: trend.textColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      case 'lumine_glow':
        return Container(
          width: 90,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF14141B),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: trend.accentColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: trend.accentColor,
                size: 24,
                shadows: [
                  Shadow(color: trend.accentColor, blurRadius: 10),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      case 'holo_glass':
        return Container(
          width: 90,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.blur_circular,
                color: Color(0xFFFF00E5),
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        );
      case 'mono_archive':
        return Container(
          width: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          child: Column(
            children: [
              Container(
                height: 14,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    label.length > 3 ? label.substring(0, 3).toUpperCase() : label.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 8),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.article_outlined, size: 24),
                      const SizedBox(height: 4),
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case 'tactile_industrial':
        return Container(
          width: 90,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            border: Border.all(color: const Color(0xFF404040), width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.settings_input_component_outlined,
                color: Color(0xFFFF6B00),
                size: 20,
              ),
              const SizedBox(height: 8),
              Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 20,
                height: 2,
                color: const Color(0xFFFF6B00).withValues(alpha: 0.5),
              ),
            ],
          ),
        );
      default:
        return Container(
          width: 90,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(3, 3)),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_awesome, color: Colors.black, size: 24),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );
    }
  }
}
