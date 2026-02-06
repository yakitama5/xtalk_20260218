import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:xtalk_20260218/config/theme.dart';

class IntroSlide extends FlutterDeckSlideWidget {
  const IntroSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/intro',
          title: 'Introduction',
          header: FlutterDeckHeaderConfiguration(title: 'Who am I?'),
          speakerNotes: '''
最初に軽く自己紹介をさせて下さい。
「やくらん」というハンドルネームで活動しており、ピープルソフトウェア株式会社に所属しています。

技術スタックには個人的に好きなFlutterを記載していますが、本業はWebエンジニアとして働いています。
この後の懇親会でも、Flutterの話やWebの話ができたら嬉しいです。

よろしくお願いします。
''',
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      splitRatio: const SplitSlideRatio(left: 4, right: 6),
      leftBuilder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: PresentationTheme.primaryColor,
                    width: 8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: PresentationTheme.primaryColor.withValues(
                        alpha: 0.3,
                      ),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://avatars.githubusercontent.com/u/14286444?v=4',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.person,
                      size: 150,
                      color: Colors.white24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              _buildQRCard('X (Twitter)', 'https://x.com/yakuran1'),
            ],
          ),
        );
      },
      rightBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'やくらん (@yakuran1)',
                style: GoogleFonts.notoSansJp(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: PresentationTheme.primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Software Engineer',
                  style: GoogleFonts.notoSansJp(
                    fontSize: 24,
                    color: PresentationTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              _buildInfoRow(Icons.business, 'ピープルソフトウェア株式会社'),
              const SizedBox(height: 24),
              _buildInfoRow(Icons.location_on, 'Okayama, Japan'),
              const SizedBox(height: 24),
              _buildInfoRow(Icons.terminal, 'Flutter / Dart'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: PresentationTheme.primaryColor, size: 28),
        const SizedBox(width: 20),
        Text(
          text,
          style: GoogleFonts.notoSansJp(fontSize: 28, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildQRCard(String label, String data) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 120.0,
            gapless: false,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: GoogleFonts.notoSansJp(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: PresentationTheme.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}
