/// Helper class that handles Duration
class DurationHelper {
  /// Return formatted time from duration
  ///
  /// For example, Duration of 100 seconds will
  /// be displayed as 01:40
  static String toFormattedTime(Duration duration) {
    // Return two digits if the number has one
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$minutes:$seconds';
  }
}
