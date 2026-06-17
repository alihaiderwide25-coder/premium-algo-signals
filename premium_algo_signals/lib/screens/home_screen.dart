import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/signal_provider.dart';
import '../services/admob_service.dart';
import '../widgets/signal_card.dart';
import '../widgets/ad_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AdMobService().loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.trending_up, color: Color(0xFFC70849)),
            SizedBox(width: 8),
            Text('Premium Algo'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, '/history'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          const AdBanner(),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'LIVE SIGNALS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/guide'),
                  icon: const Icon(Icons.help_outline, size: 18),
                  label: const Text('Setup'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<SignalProvider>(
              builder: (context, provider, child) {
                if (provider.activeSignals.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_none, size: 64, color: Colors.grey[600]),
                        const SizedBox(height: 16),
                        Text('No Active Signals', style: TextStyle(fontSize: 18, color: Colors.grey[400])),
                        const SizedBox(height: 8),
                        Text('Wait for next signal...', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: provider.activeSignals.length,
                  itemBuilder: (context, index) {
                    return SignalCard(signal: provider.activeSignals[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
