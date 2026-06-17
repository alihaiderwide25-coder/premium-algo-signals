import 'package:flutter/material.dart';

class SetupGuideScreen extends StatelessWidget {
  const SetupGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup Guide')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Step 1: TradingView Setup', [
            '1. TradingView open karein aur chart kholen (3m timeframe)',
            '2. Pine Editor neeche se kholen',
            '3. Premium Algo code paste karein',
            '4. Save aur Add to Chart dabayein',
            '5. Indicator chart par show hoga',
          ], Icons.show_chart, Colors.blue),
          _buildSection('Step 2: Alert Lagana', [
            '1. Chart par bell icon dabayein',
            '2. Condition: "Premium Algo Buy/Sell" select karein',
            '3. Frequency: "Once Per Close" rakhein',
            '4. Message format JSON mein rakhein',
            '5. Create par click karein',
          ], Icons.notifications_active, Colors.orange),
          _buildSection('Step 3: App Setup', [
            '1. App open karein',
            '2. Notifications enable karein',
            '3. TradingView se webhook configure karein',
            '4. Firebase setup karein (optional)',
          ], Icons.phone_android, Colors.green),
          _buildSection('Important Notes', [
            'Har signal par foran jump na karein',
            'Market structure aur spread bhi dekhein',
            'Risk chhota rakhein (1-2% per trade)',
            'Overtrading se bachein',
            'SL hamesha respect karein',
          ], Icons.warning_amber, Colors.red),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> steps, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...steps.map((step) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyle(color: color, fontSize: 16)),
                  Expanded(
                    child: Text(step, style: TextStyle(color: Colors.grey[300], fontSize: 14, height: 1.5)),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
