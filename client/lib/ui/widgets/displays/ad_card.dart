import 'package:client/data/models/ad.dart';
import 'package:client/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdCard extends StatelessWidget {
  final Ad ad;
  const AdCard({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (ad.linkUrl != null) {
          final uri = Uri.parse(ad.linkUrl!);
          if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
        child: Stack(
          children: [
            Image.network(ad.imageUrl, fit: BoxFit.cover, height: double.infinity, width: double.infinity),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ad.brandName, style: TosReviewTextStyles.tooSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(ad.title, style: TosReviewTextStyles.tooSmall.copyWith(color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: TosReviewColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text("Ad", style: TosReviewTextStyles.tooSmall.copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}