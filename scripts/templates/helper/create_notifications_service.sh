#!/bin/bash

function create_notifications_service(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/services"
 NOTIFICATIONS_SERVICE_FILE="$DEST_DIR/notifications_service.dart"
  cat <<EOL > "$NOTIFICATIONS_SERVICE_FILE"
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationService {
  static final _notificationPlugin = FlutterLocalNotificationsPlugin();
  static final bool _initialized = false;
  static int _badgeCounter = 0;
  bool get isInitialized => _initialized;

  static Future<void> initNotifications() async {
    if (_initialized) return;

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _notificationPlugin.initialize(initializationSettings);
  }

  static NotificationDetails _notificationDetails(){
    return NotificationDetails(
      android: AndroidNotificationDetails('daily_channel_id','Daily Notifications' , channelDescription: 'Daily notifications for the app',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        showWhen: true,
        enableLights: true,
        enableVibration: true,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        badgeNumber: ++_badgeCounter,
      ),

    );
  }

  static Future<void> showNotification({int id = 0, String? title, String? body}) async {
    await _notificationPlugin.show(
      id,
      title,
      body,
      _notificationDetails(),
    );
  }
}

EOL

 echo "📄 Created notifications_service.dart file successfully at $NOTIFICATIONS_SERVICE_FILE"
 echo "✅ Notifications service template generated successfully."
}

export -f create_notifications_service
