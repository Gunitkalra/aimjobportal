import 'package:get/get.dart';

class SecretTapDetector {
  static const int requiredTaps = 7;
  static const int timeWindowSeconds = 10;
  RxBool isSelectRole=false.obs;

  List<DateTime> _tapTimes = [];

  /// Call this method when "PL" is tapped
  bool recordTap() {
    final now = DateTime.now();
    _tapTimes.add(now);

    // Remove taps older than 10 seconds
    _tapTimes.removeWhere((tapTime) {
      return now.difference(tapTime).inSeconds > timeWindowSeconds;
    });

    // Check if we have 7 taps within 10 seconds
    if (_tapTimes.length >= requiredTaps) {
      _resetTaps();
      return true; // Secret condition met
    }

    return false; // Not enough taps yet
  }

  /// Reset tap counter
  void _resetTaps() {
    _tapTimes.clear();
  }

  /// Get current tap count within time window
  int getCurrentTapCount() {
    final now = DateTime.now();
    _tapTimes.removeWhere((tapTime) {
      return now.difference(tapTime).inSeconds > timeWindowSeconds;
    });
    return _tapTimes.length;
  }
}