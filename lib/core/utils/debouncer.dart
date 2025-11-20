import 'dart:async';

/// A utility class that delays function execution until after a specified duration
/// has passed since the last time it was invoked.
///
/// This is useful for scenarios like search where you want to wait until the user
/// stops typing before making an API call.
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  /// Runs the action after the debounce delay.
  /// If called again before the delay expires, the previous timer is cancelled
  /// and a new timer is started.
  void run(void Function() action) {
    // Cancel any existing timer
    _timer?.cancel();

    // Start a new timer
    _timer = Timer(delay, action);
  }

  /// Cancels any pending debounced action
  void cancel() {
    _timer?.cancel();
  }

  /// Dispose of the debouncer and cancel any pending actions
  void dispose() {
    _timer?.cancel();
  }
}
