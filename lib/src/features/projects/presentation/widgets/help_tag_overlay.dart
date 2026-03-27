import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/project.dart';

class HelpTagOverlay extends StatefulWidget {
  final List<HelpStep> steps;
  final bool visible;

  const HelpTagOverlay({super.key, required this.steps, this.visible = true});

  @override
  State<HelpTagOverlay> createState() => _HelpTagOverlayState();
}

class _HelpTagOverlayState extends State<HelpTagOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400 + (widget.steps.length * 200)),
    );
    if (widget.visible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(HelpTagOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !oldWidget.visible) {
      _controller.forward(from: 0);
    } else if (!widget.visible && oldWidget.visible) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible || widget.steps.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Semi-transparent scrim
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final scrimOpacity = Tween<double>(begin: 0, end: 0.3).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(0, 0.3, curve: Curves.easeOut),
                  ),
                );
                return IgnorePointer(
                  child: Container(
                    color: Colors.black.withValues(alpha: scrimOpacity.value),
                  ),
                );
              },
            ),
            // Help step tags
            ...widget.steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final totalSteps = widget.steps.length;
              final intervalStart = index / (totalSteps + 1);
              final intervalEnd = (index + 2) / (totalSteps + 1);

              return _AnimatedHelpTag(
                step: step,
                left: step.left * w,
                top: step.top * h,
                animation: CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    intervalStart.clamp(0.0, 1.0),
                    intervalEnd.clamp(0.0, 1.0),
                    curve: Curves.elasticOut,
                  ),
                ),
              );
            }),
            // Connector lines between steps
            if (widget.steps.length > 1)
              ...List.generate(widget.steps.length - 1, (i) {
                final from = widget.steps[i];
                final to = widget.steps[i + 1];
                return _ConnectorLine(
                  fromLeft: from.left * w + 16,
                  fromTop: from.top * h + 24,
                  toLeft: to.left * w + 16,
                  toTop: to.top * h,
                  animation: CurvedAnimation(
                    parent: _controller,
                    curve: Interval(
                      ((i + 1) / (widget.steps.length + 1)).clamp(0.0, 1.0),
                      ((i + 3) / (widget.steps.length + 1)).clamp(0.0, 1.0),
                      curve: Curves.easeOut,
                    ),
                  ),
                );
              }),
          ],
        );
      },
    );
  }
}

class _AnimatedHelpTag extends StatelessWidget {
  final HelpStep step;
  final double left;
  final double top;
  final Animation<double> animation;

  const _AnimatedHelpTag({
    required this.step,
    required this.left,
    required this.top,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          left: left,
          top: top,
          child: Opacity(
            opacity: animation.value.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: animation.value.clamp(0.0, 1.0),
              alignment: Alignment.topLeft,
              child: child,
            ),
          ),
        );
      },
      child: _HelpTagBadge(step: step),
    );
  }
}

class _HelpTagBadge extends StatelessWidget {
  final HelpStep step;
  const _HelpTagBadge({required this.step});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 240),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A).withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFFF6B00).withValues(alpha: 0.6),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6B00).withValues(alpha: 0.15),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Step number circle
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF6B00),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${step.stepNumber}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Text content
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      step.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                    if (step.description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        step.description!,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 10,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConnectorLine extends StatelessWidget {
  final double fromLeft, fromTop, toLeft, toTop;
  final Animation<double> animation;

  const _ConnectorLine({
    required this.fromLeft,
    required this.fromTop,
    required this.toLeft,
    required this.toTop,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return IgnorePointer(
          child: CustomPaint(
            size: Size.infinite,
            painter: _DashedLinePainter(
              from: Offset(fromLeft, fromTop),
              to: Offset(toLeft, toTop),
              progress: animation.value.clamp(0.0, 1.0),
            ),
          ),
        );
      },
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Offset from;
  final Offset to;
  final double progress;

  _DashedLinePainter({
    required this.from,
    required this.to,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF6B00).withValues(alpha: 0.4 * progress)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    final endPoint = Offset.lerp(from, to, progress)!;

    // Dashed line
    const dashLength = 6.0;
    const gapLength = 4.0;

    final dx = endPoint.dx - from.dx;
    final dy = endPoint.dy - from.dy;
    final distance = (endPoint - from).distance;

    if (distance == 0) return;

    final unitDx = dx / distance;
    final unitDy = dy / distance;

    double drawn = 0;
    path.moveTo(from.dx, from.dy);

    while (drawn < distance) {
      final dashEnd = (drawn + dashLength).clamp(0.0, distance);
      path.lineTo(from.dx + unitDx * dashEnd, from.dy + unitDy * dashEnd);
      drawn = dashEnd + gapLength;
      if (drawn < distance) {
        path.moveTo(from.dx + unitDx * drawn, from.dy + unitDy * drawn);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
