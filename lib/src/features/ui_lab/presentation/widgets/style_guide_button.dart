import 'package:flutter/material.dart';
import '../../domain/ui_trend.dart';
import 'style_guide_generator.dart';
import '../../../../core/utils/file_downloader.dart';

class StyleGuideDownloadButton extends StatefulWidget {
  final UITrend trend;

  const StyleGuideDownloadButton({super.key, required this.trend});

  @override
  State<StyleGuideDownloadButton> createState() => _StyleGuideDownloadButtonState();
}

class _StyleGuideDownloadButtonState extends State<StyleGuideDownloadButton> {
  bool _isHovered = false;

  Future<void> _downloadFile() async {
    final markdown = StyleGuideGenerator.generateMarkdown(widget.trend);
    final fileName = '${widget.trend.id}_ai_style_guide.md';
    
    try {
      downloadFile(markdown, fileName);
    } catch (e) {
      debugPrint('Error downloading style guide: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final trend = widget.trend;
    final isNight = trend.id == 'tokyo_night';
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _downloadFile,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered 
                ? trend.accentColor 
                : trend.accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: trend.accentColor.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: _isHovered && isNight
                ? [
                    BoxShadow(
                      color: trend.accentColor.withValues(alpha: 0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.smart_toy_outlined,
                size: 20,
                color: _isHovered ? Colors.white : trend.textColor,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'DESCARGAR GUÍA AI',
                    style: TextStyle(
                      color: _isHovered ? Colors.white : trend.textColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Optimizado para agentes',
                    style: TextStyle(
                      color: _isHovered 
                          ? Colors.white.withValues(alpha: 0.8) 
                          : trend.subtleTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.download_for_offline_outlined,
                size: 18,
                color: _isHovered ? Colors.white : trend.accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
