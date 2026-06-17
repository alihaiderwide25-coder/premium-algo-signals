class TradingSignal {
  final String id;
  final String symbol;
  final String action;
  final double entryPrice;
  final double stopLoss;
  final double tp1;
  final double tp2;
  final double tp3;
  final String timeframe;
  final DateTime timestamp;
  final bool isActive;
  final String? trailStatus;

  TradingSignal({
    required this.id,
    required this.symbol,
    required this.action,
    required this.entryPrice,
    required this.stopLoss,
    required this.tp1,
    required this.tp2,
    required this.tp3,
    required this.timeframe,
    required this.timestamp,
    this.isActive = true,
    this.trailStatus,
  });

  factory TradingSignal.fromJson(Map<String, dynamic> json) {
    return TradingSignal(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      symbol: json['symbol'] ?? 'UNKNOWN',
      action: json['action'] ?? 'BUY',
      entryPrice: double.tryParse(json['entry']?.toString() ?? '0') ?? 0,
      stopLoss: double.tryParse(json['sl']?.toString() ?? '0') ?? 0,
      tp1: double.tryParse(json['tp1']?.toString() ?? '0') ?? 0,
      tp2: double.tryParse(json['tp2']?.toString() ?? '0') ?? 0,
      tp3: double.tryParse(json['tp3']?.toString() ?? '0') ?? 0,
      timeframe: json['timeframe'] ?? '3m',
      timestamp: DateTime.tryParse(json['time'] ?? '') ?? DateTime.now(),
      trailStatus: json['trailStatus'],
    );
  }

  double get riskReward {
    double risk = (entryPrice - stopLoss).abs();
    double reward = (tp1 - entryPrice).abs();
    return risk > 0 ? reward / risk : 0;
  }
}
