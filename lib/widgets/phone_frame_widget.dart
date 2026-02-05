import 'package:flutter/material.dart';

class PhoneFrameWidget extends StatelessWidget {
  final Widget child;

  const PhoneFrameWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 800,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: const Color(0xFF333333), width: 10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 30,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(38),
        child: Stack(
          children: [
            // Screen Content
            child,

            // Status Bar Area (Mock)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 40,
              child: Container(color: Colors.black.withValues(alpha: 0.2)),
            ),

            // Dynamic Island / Notch
            Positioned(
              top: 12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 130,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            // Home Indicator
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 160,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2.5),
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
