import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _fcmToken;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    final token = await NotificationService.getToken();
    setState(() => _fcmToken = token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.notifications_active, color: Color(0xFFC70849)),
              title: Text('Notifications'),
              subtitle: Text('Enabled'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.token, color: Color(0xFF00DBFF)),
              title: const Text('FCM Token'),
              subtitle: Text(
                _fcmToken != null 
                  ? '${_fcmToken!.substring(0, 20)}...'
                  : 'Loading...',
                style: const TextStyle(fontSize: 12),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  // Copy token to clipboard
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Token copied!')),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline, color: Colors.orange),
              title: Text('App Version'),
              subtitle: Text('1.0.0'),
            ),
          ),
        ],
      ),
    );
  }
}
