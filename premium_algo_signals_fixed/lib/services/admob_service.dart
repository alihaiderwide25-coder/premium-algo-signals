import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  // TEST IDs - pehle inhi se test karein
  static const String bannerTestId = 'ca-app-pub-3940256099942544/6300978111';
  static const String interstitialTestId = 'ca-app-pub-3940256099942544/1033173712';
  static const String rewardedTestId = 'ca-app-pub-3940256099942544/5224354917';

  static String bannerAdUnitId = bannerTestId;
  static String interstitialAdUnitId = interstitialTestId;
  static String rewardedAdUnitId = rewardedTestId;

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => debugPrint('Banner Loaded'),
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    )..load();
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) => debugPrint('Interstitial Failed: $error'),
      ),
    );
  }

  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      loadInterstitialAd();
    }
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewardedAd = ad,
        onAdFailedToLoad: (error) => debugPrint('Rewarded Failed: $error'),
      ),
    );
  }

  void showRewardedAd(VoidCallback onReward) {
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) => onReward(),
      );
      _rewardedAd = null;
      loadRewardedAd();
    } else {
      onReward();
    }
  }
}
