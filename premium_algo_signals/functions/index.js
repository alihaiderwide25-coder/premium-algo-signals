const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.tradingviewWebhook = functions.https.onRequest(async (req, res) => {
  const data = req.body;

  const signal = {
    id: Date.now().toString(),
    symbol: data.symbol || 'UNKNOWN',
    action: data.action || 'BUY',
    entry: parseFloat(data.entry || 0),
    sl: parseFloat(data.sl || 0),
    tp1: parseFloat(data.tp1 || 0),
    tp2: parseFloat(data.tp2 || 0),
    tp3: parseFloat(data.tp3 || 0),
    timeframe: data.timeframe || '3m',
    timestamp: new Date().toISOString(),
    isActive: true,
    trailStatus: null,
  };

  if (signal.tp2 === 0) {
    const risk = Math.abs(signal.entry - signal.sl);
    signal.tp2 = signal.action === 'BUY' 
      ? signal.entry + (risk * 1.0) 
      : signal.entry - (risk * 1.0);
  }
  if (signal.tp3 === 0) {
    const risk = Math.abs(signal.entry - signal.sl);
    signal.tp3 = signal.action === 'BUY' 
      ? signal.entry + (risk * 1.5) 
      : signal.entry - (risk * 1.5);
  }

  await admin.firestore().collection('signals').doc(signal.id).set(signal);

  const message = {
    notification: {
      title: `${signal.action} SIGNAL - ${signal.symbol}`,
      body: `Entry: ${signal.entry} | SL: ${signal.sl} | TP: ${signal.tp1}`,
    },
    data: {
      symbol: signal.symbol,
      action: signal.action,
      entry: signal.entry.toString(),
      sl: signal.sl.toString(),
      tp1: signal.tp1.toString(),
      tp2: signal.tp2.toString(),
      tp3: signal.tp3.toString(),
      timeframe: signal.timeframe,
      id: signal.id,
    },
    topic: 'all_signals',
  };

  await admin.messaging().send(message);
  res.status(200).send({ success: true, signalId: signal.id });
});