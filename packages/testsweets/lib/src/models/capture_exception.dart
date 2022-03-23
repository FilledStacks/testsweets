class CaptureException implements Exception {
  final String? message;
  const CaptureException([this.message]);
}

class FoundMoreThanOneScrollInteractionPerScrollable extends CaptureException {
  const FoundMoreThanOneScrollInteractionPerScrollable([String? message])
      : super(message);
}

class NoScrollableInteractionsInsideThisScrollableWidget
    extends CaptureException {
  const NoScrollableInteractionsInsideThisScrollableWidget([String? message])
      : super(message);
}
