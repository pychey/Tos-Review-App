import 'package:client/data/models/notification.dart';
import 'package:client/services/api_client.dart';

class NotificationService {
  Future<List<AppNotification>> getNotifications() async {
    final response = await dio.get('/api/notifications');
    final List data = response.data;
    return data.map((item) => AppNotification.fromJson(item)).toList();
  }

  Future<void> markAsRead(String notificationId) async {
    await dio.patch('/api/notifications/$notificationId/read');
  }

  Future<void> markAllAsRead() async {
    await dio.patch('/api/notifications/read-all');
  }
}

final notificationService = NotificationService();