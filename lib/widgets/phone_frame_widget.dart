import 'package:flutter/material.dart';

class PhoneFrameWidget extends StatelessWidget {
  final Widget child;

  const PhoneFrameWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320, // Typical phone width
      height: 640,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFF333333), width: 8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // Screen Content
            child,

            // Status Bar Area (Mock)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 30,
              child: Container(
                color: Colors.black.withValues(
                  alpha: 0.2,
                ), // Just to darken status bar area slightly
              ),
            ),

            // Dynamic Island / Notch
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 100,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // Home Indicator
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 120,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
