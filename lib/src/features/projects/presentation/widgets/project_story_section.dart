import 'package:flutter/material.dart';

class ProjectStorySection extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final bool isLeftAligned;
  final Color? accentColor;

  const ProjectStorySection({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.isLeftAligned = true,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      height: size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.black,
        image: imageUrl != null
            ? DecorationImage(
                image: AssetImage(imageUrl!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.5),
                  BlendMode.darken,
                ),
              )
            : null,
      ),
      child: Stack(
        children: [
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Align(
              alignment: isLeftAligned
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                constraints: BoxConstraints(maxWidth: size.width * 0.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: isLeftAligned
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      textAlign: isLeftAligned
                          ? TextAlign.left
                          : TextAlign.right,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 4,
                      width: 80,
                      color:
                          accentColor ?? Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      description,
                      style: textTheme.headlineSmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.5,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: isLeftAligned
                          ? TextAlign.left
                          : TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
