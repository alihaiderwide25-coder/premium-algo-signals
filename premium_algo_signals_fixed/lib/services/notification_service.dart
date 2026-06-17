import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    await _notificationsPlugin.initialize(
      const InitializationSettings(android: androidSettings),
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'signal_channel',
      'Trading Signals',
      description: 'Live trading signals from Premium Algo',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> showSignalNotification(Map<String, dynamic> data) async {
    String action = data['action'] ?? 'BUY';

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'signal_channel',
      'Trading Signals',
      channelDescription: 'Live trading signals',
      importance: Importance.max,
      priority: Priority.max,
      color: action == 'BUY' ? const Color(0xFF00E676) : const Color(0xFFFF1744),
      styleInformation: BigTextStyleInformation(
        '${data['symbol']}
Entry: ${data['entry']}
SL: ${data['sl']}
TP1: ${data['tp1']}',
        contentTitle: '$action SIGNAL',
        summaryText: 'Premium Algo',
      ),
    );

    await _notificationsPlugin.show(
      DateTime.now().millisecond,
      '$action SIGNAL - ${data['symbol']}',
      'Entry: ${data['entry']} | SL: ${data['sl']} | TP: ${data['tp1']}',
      NotificationDetails(android: androidDetails),
    );
  }
}
