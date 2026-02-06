import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xtalk_20260218/config/theme.dart';

class AnimatedStampWidget extends StatefulWidget {
  final VoidCallback? onAnimationComplete;

  const AnimatedStampWidget({super.key, this.onAnimationComplete});

  @override
  State<AnimatedStampWidget> createState() => _AnimatedStampWidgetState();
}

class _AnimatedStampWidgetState extends State<AnimatedStampWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 3.0, end: 0.8), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.0), weight: 40),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5)),
    );

    _controller.forward().then((_) {
      widget.onAnimationComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: -0.2, // 少し傾ける
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: PresentationTheme.successDarkColor,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: PresentationTheme.successDarkColor.withValues(
                    alpha: 0.2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Cost',
                      style: GoogleFonts.blackOpsOne(
                        fontSize: 24,
                        color: PresentationTheme.successDarkColor,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      '¥0',
                      style: GoogleFonts.blackOpsOne(
                        fontSize: 64,
                        color: PresentationTheme.successDarkColor,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
