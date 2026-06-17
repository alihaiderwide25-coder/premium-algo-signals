import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/trading_signal.dart';

class SignalCard extends StatelessWidget {
  final TradingSignal signal;

  const SignalCard({super.key, required this.signal});

  @override
  Widget build(BuildContext context) {
    final bool isBuy = signal.action == 'BUY';
    final Color actionColor = isBuy ? const Color(0xFF00E676) : const Color(0xFFFF1744);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: actionColor, width: 4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: actionColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: actionColor),
                    ),
                    child: Text(signal.action, style: TextStyle(color: actionColor, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text(signal.symbol, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(6)),
                    child: Text(signal.timeframe, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildPriceRow('📍 ENTRY', signal.entryPrice, Colors.white),
              const Divider(height: 16, color: Colors.grey),
              _buildPriceRow('🛑 STOP LOSS', signal.stopLoss, const Color(0xFFFF9800)),
              const SizedBox(height: 8),
              _buildPriceRow('🎯 TP1', signal.tp1, const Color(0xFF00BCD4)),
              const SizedBox(height: 4),
              _buildPriceRow('🎯 TP2', signal.tp2, const Color(0xFF00BCD4)),
              const SizedBox(height: 4),
              _buildPriceRow('🎯 TP3', signal.tp3, const Color(0xFF00BCD4)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Text('RISK/REWARD', style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                          const SizedBox(height: 4),
                          Text('1:${signal.riskReward.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  if (signal.trailStatus != null) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5770F).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE5770F)),
                        ),
                        child: Column(
                          children: [
                            Text('TRAIL', style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                            const SizedBox(height: 4),
                            Text(signal.trailStatus!, style: const TextStyle(color: Color(0xFFE5770F), fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF0B90B),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Binance'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C087),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Bybit'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(signal.timestamp), style: TextStyle(color: Colors.grey[600], fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 13)),
        Text(value.toStringAsFixed(2), style: TextStyle(color: valueColor, fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'monospace')),
      ],
    );
  }
}
