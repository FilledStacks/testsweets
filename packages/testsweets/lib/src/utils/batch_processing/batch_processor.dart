import 'dart:async';

/// A class that allows you to rapidly add data to it and it will
/// process in batches of 5, or every 500 milliseconds.
class BatchProcessor<T> {
  List<T> events = [];
  Timer? _batchTimer;

  StreamController<List<T>> _batchProcessingController =
      StreamController<List<T>>();

  Stream<List<T>> get batchProcessingStream =>
      _batchProcessingController.stream;

  void addItem(T item) {
    print('🍬 TESTSWEETS :: _captureEventsForBackend');

    _batchTimer?.cancel();

    events.add(item);

    _batchTimer =
        Timer(Duration(milliseconds: 500), () => _submitBatch('timer'));

    if (events.length > 4) {
      _batchTimer?.cancel();
      _submitBatch('length');
    }
  }

  void _submitBatch(String reason) {
    print('🍬 TESTSWEETS :: Submit batch - reason:$reason');

    final eventsToSubmit = List<T>.from(events.take(5));
    final endRange = events.length > 4 ? 5 : events.length;
    events.removeRange(0, endRange);

    _batchProcessingController.add(eventsToSubmit);
  }
}
