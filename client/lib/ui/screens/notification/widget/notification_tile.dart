import 'package:flutter/material.dart';
import 'package:client/data/models/notification.dart';
import '../../../theme/theme.dart';

class NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onPress;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = notification.post != null && notification.post!.mediaUrls.isNotEmpty;
    final hasProfile = notification.actor.profileSrc != null;

    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: notification.isRead ? Colors.transparent : TosReviewColors.primary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Actor avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: hasProfile
                      ? Image.network(
                          notification.actor.profileSrc!,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 48,
                          height: 48,
                          color: TosReviewColors.primary.withOpacity(0.2),
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                ),
                const SizedBox(width: TosReviewSpacings.m),
                // Message + time
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.message,
                        style: TosReviewTextStyles.button.copyWith(
                          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.timeAgo,
                        style: TosReviewTextStyles.body.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                // Post thumbnail (if applicable)
                if (hasImage) ...[
                  const SizedBox(width: TosReviewSpacings.s),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      notification.post!.mediaUrls.first,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                // Space for dot on unread
                if (!notification.isRead) const SizedBox(width: 16),
              ],
            ),
          ),
          // Unread dot as overlay (top-right)
          if (!notification.isRead)
            Positioned(
              top: 12,
              right: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: TosReviewColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}