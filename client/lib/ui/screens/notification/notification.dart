import 'package:flutter/material.dart';
import 'package:client/data/models/notification.dart';
import 'package:client/services/notification_service.dart';
import '../../theme/theme.dart';
import '../inspect_post/inspect_post.dart';
import 'widget/notification_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<AppNotification> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      final data = await notificationService.getNotifications();
      setState(() {
        _notifications = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _markAllAsRead() async {
    await notificationService.markAllAsRead();
    setState(() {
      _notifications = _notifications.map((n) => AppNotification(
        id: n.id,
        type: n.type,
        isRead: true,
        createdAt: n.createdAt,
        actor: n.actor,
        post: n.post,
      )).toList();
    });
  }

  void _onTapNotification(AppNotification notification) async {
    // Mark as read
    if (!notification.isRead) {
      await notificationService.markAsRead(notification.id);
      setState(() {
        _notifications = _notifications.map((n) {
          if (n.id == notification.id) {
            return AppNotification(
              id: n.id, type: n.type, isRead: true,
              createdAt: n.createdAt, actor: n.actor, post: n.post,
            );
          }
          return n;
        }).toList();
      });
    }

    // Navigate to post if applicable
    if (notification.post != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InspectPost(postId: notification.post!.id)),
      );
    }
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TosReviewColors.white,
      appBar: AppBar(
        title: Text(
          _unreadCount > 0 ? 'Notifications ($_unreadCount)' : 'Notifications',
          style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary),
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: TosReviewColors.white,
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(
                'Mark all read',
                style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.primary),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
              ? Center(
                  child: Text(
                    'No notifications yet',
                    style: TosReviewTextStyles.body.copyWith(color: Colors.grey),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadNotifications,
                  child: ListView.builder(
                    padding: EdgeInsets.all(TosReviewSpacings.paddingScreen),
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final notification = _notifications[index];
                      return NotificationTile(
                        notification: notification,
                        onPress: () => _onTapNotification(notification),
                      );
                    },
                  ),
                ),
    );
  }
}