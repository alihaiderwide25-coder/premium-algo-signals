import 'package:flutter/material.dart';
import '../models/trading_signal.dart';

class SignalProvider extends ChangeNotifier {
  final List<TradingSignal> _signals = [];
  final List<TradingSignal> _history = [];

  List<TradingSignal> get activeSignals => _signals.where((s) => s.isActive).toList();
  List<TradingSignal> get history => _history;

  void addSignal(TradingSignal signal) {
    _signals.add(signal);
    notifyListeners();
  }

  void updateSignal(String id, {String? trailStatus, bool? isActive}) {
    final index = _signals.indexWhere((s) => s.id == id);
    if (index != -1) {
      final old = _signals[index];
      _signals[index] = TradingSignal(
        id: old.id,
        symbol: old.symbol,
        action: old.action,
        entryPrice: old.entryPrice,
        stopLoss: old.stopLoss,
        tp1: old.tp1,
        tp2: old.tp2,
        tp3: old.tp3,
        timeframe: old.timeframe,
        timestamp: old.timestamp,
        isActive: isActive ?? old.isActive,
        trailStatus: trailStatus ?? old.trailStatus,
      );
      notifyListeners();
    }
  }

  void closeSignal(String id) {
    final signal = _signals.firstWhere((s) => s.id == id);
    _history.add(signal);
    _signals.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
