# Premium Algo Signals - Flutter App (FIXED VERSION)

## Complete Trading Signal App

### Features:
- Real-time TradingView signals
- BUY/SELL signals with Entry, SL, TP1, TP2, TP3
- Auto Trail updates
- AdMob ads integration (Banner, Interstitial, Rewarded)
- Dark theme UI
- Signal history
- Setup guide

### How to Build APK:

#### Method 1: Codemagic (Free Online Builder)
1. Upload this project to GitHub
2. Go to codemagic.io
3. Connect your GitHub repository
4. Click "Start new build"
5. Download APK

#### Method 2: Local Build
1. Install Flutter SDK (flutter.dev)
2. Install Android Studio
3. Run: `flutter pub get`
4. Run: `flutter build apk --release`
5. APK will be in: build/app/outputs/flutter-apk/

### TradingView Setup:
1. Open Pine Editor
2. Paste Premium_Algo_Alert_Ready.pine
3. Create alert with webhook URL (optional)
4. Set message to JSON format

### AdMob Setup:
1. Create AdMob account
2. Create ad units
3. Replace test IDs in lib/services/admob_service.dart with real IDs
4. Update AndroidManifest.xml with your App ID

### Contact:
For support: SignalIndicator.com
Instagram: @signalindicator28
