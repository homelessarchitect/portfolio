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
    return Container(
      color: _bgColor,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildAppBar(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  // ── Background color ──────────────────────────────────────────────────────
  Color get _bgColor {
    switch (trend.id) {
      case 'glassmorphism':
        return const Color(0xFFF3E5F5);
      case 'tokyo_night':
        return const Color(0xFF16161e);
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
                      border: Border.all(color: Colors.white.withValues(alpha: 0.7)),
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
                  shadows: [Shadow(color: trend.secondaryAccent, blurRadius: 10)],
                ),
              ),
              const Spacer(),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(color: _accent, width: 1.5),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: _accent.withValues(alpha: 0.4), blurRadius: 8)],
                ),
                child: Icon(Icons.person_outline, color: _accent, size: 18),
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
            style: TextStyle(
              color: trend.subtleTextColor,
              fontSize: 12,
            ),
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
        _buildCard(title: 'Transaction', subtitle: 'Frosted glass effect', icon: Icons.bubble_chart),
        const SizedBox(height: 16),
        _buildCard(title: 'Analytics', subtitle: 'Real-time metrics', icon: Icons.bar_chart),
        const SizedBox(height: 16),
        _buildCard(title: 'Settings', subtitle: 'Configure your profile', icon: Icons.settings_outlined),
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
        _buildCard(title: 'Tendencia #1', subtitle: items.first, icon: Icons.star),
        const SizedBox(height: 12),
        _buildCard(title: 'Tendencia #2', subtitle: items.last, icon: Icons.trending_up),
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
        shadows: isNight
            ? [Shadow(color: _accent, blurRadius: 10)]
            : null,
      ),
    );
  }

  Widget _styledSubtitle(String text) {
    return Text(
      text,
      style: TextStyle(color: trend.subtleTextColor, fontWeight: FontWeight.w500),
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
                  Icon(isPassword ? Icons.lock_outline : icon,
                      color: _accent, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(hint,
                        style: TextStyle(color: trend.subtleTextColor, fontSize: 14)),
                  ),
                  if (isPassword)
                    Icon(Icons.visibility_outlined,
                        color: trend.subtleTextColor, size: 16),
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
              Icon(isPassword ? Icons.lock_outline : icon, color: _accent, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(hint,
                    style: TextStyle(color: trend.subtleTextColor, fontSize: 14)),
              ),
              if (isPassword)
                Icon(Icons.visibility_outlined, color: _accent, size: 16),
            ],
          ),
        );
      default: // neo_clean
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(3, 3))],
          ),
          child: Row(
            children: [
              Icon(isPassword ? Icons.lock_outline : icon, color: Colors.black, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(hint, style: const TextStyle(color: Colors.black54, fontSize: 14)),
              ),
              if (isPassword)
                const Icon(Icons.visibility_outlined, color: Colors.black38, size: 16),
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
              child: Row(children: [
                Icon(Icons.category_outlined, color: _accent, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(hint, style: TextStyle(color: trend.subtleTextColor, fontSize: 14)),
                ),
                Icon(Icons.expand_more, color: trend.subtleTextColor, size: 18),
              ]),
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
          child: Row(children: [
            Icon(Icons.category_outlined, color: _accent, size: 18),
            const SizedBox(width: 10),
            Expanded(child: Text(hint, style: TextStyle(color: trend.subtleTextColor, fontSize: 14))),
            Icon(Icons.expand_more, color: _accent, size: 18),
          ]),
        );
      default:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(3, 3))],
          ),
          child: Row(children: [
            const Icon(Icons.category_outlined, color: Colors.black, size: 18),
            const SizedBox(width: 10),
            Expanded(child: Text(hint, style: const TextStyle(color: Colors.black54, fontSize: 14))),
            const Icon(Icons.expand_more, color: Colors.black, size: 18),
          ]),
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
              child: Text('Escribe aquí...',
                  style: TextStyle(color: trend.subtleTextColor, fontSize: 13)),
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
          child: Text('Escribe aquí...',
              style: TextStyle(color: trend.subtleTextColor, fontSize: 13)),
        );
      default:
        return Container(
          height: 80,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: trend.surfaceColor,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(3, 3))],
          ),
          child: const Text('Escribe aquí...',
              style: TextStyle(color: Colors.black38, fontSize: 13)),
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
                  Text(label,
                      style: TextStyle(
                          color: trend.textColor, fontWeight: FontWeight.bold, fontSize: 16)),
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
                  color: _accent.withValues(alpha: 0.5), blurRadius: 20, spreadRadius: -4),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(width: 8),
              Icon(icon, color: Colors.white, size: 18),
            ],
          ),
        );
      default: // neo_clean
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.black,
            boxShadow: [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    letterSpacing: 2),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: Colors.white, size: 18),
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
                border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(icon, color: _accent, size: 28),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              color: trend.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      Text(subtitle,
                          style: TextStyle(color: trend.subtleTextColor, fontSize: 12)),
                    ],
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
            color: const Color(0xFF24283b),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _accent.withValues(alpha: 0.3), width: 1),
            boxShadow: [BoxShadow(color: _accent.withValues(alpha: 0.08), blurRadius: 15)],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: _accent, size: 22),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(subtitle,
                      style: TextStyle(color: trend.subtleTextColor, fontSize: 12)),
                ],
              ),
            ],
          ),
        );
      default: // neo_clean
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.fromBorderSide(BorderSide(color: Colors.black, width: 2)),
            boxShadow: [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black, size: 28),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 15, color: Colors.black)),
                  Text(subtitle,
                      style: const TextStyle(color: Colors.black54, fontSize: 12)),
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
                  Text(label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: trend.textColor, fontSize: 10, fontWeight: FontWeight.bold)),
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
            boxShadow: [BoxShadow(color: _accent.withValues(alpha: 0.15), blurRadius: 10)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome, color: _accent, size: 24),
              const SizedBox(height: 8),
              Text(label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: trend.subtleTextColor, fontSize: 10, fontWeight: FontWeight.w600)),
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
            boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(3, 3))],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_awesome, color: Colors.black, size: 24),
              const SizedBox(height: 8),
              Text(label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 10, fontWeight: FontWeight.w800)),
            ],
          ),
        );
    }
  }
}
