import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/signal_provider.dart';

class SignalHistoryScreen extends StatelessWidget {
  const SignalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signal History'),
      ),
      body: Consumer<SignalProvider>(
        builder: (context, provider, child) {
          if (provider.history.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: Colors.grey[600]),
                  const SizedBox(height: 16),
                  Text('No History Yet', style: TextStyle(fontSize: 18, color: Colors.grey[400])),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.history.length,
            itemBuilder: (context, index) {
              final signal = provider.history[index];
              return Card(
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: signal.action == 'BUY' ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      signal.action,
                      style: TextStyle(
                        color: signal.action == 'BUY' ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(signal.symbol),
                  subtitle: Text('Entry: ${signal.entryPrice.toStringAsFixed(2)}'),
                  trailing: Text(
                    DateFormat('MM/dd HH:mm').format(signal.timestamp),
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
