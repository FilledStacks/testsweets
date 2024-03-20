import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/utils/batch_processing/batch_processor.dart';

class TestBatchProcessor extends BatchProcessor<int> {}

void main() {
  TestBatchProcessor _getProcessor() => TestBatchProcessor();

  group('BatchProcessorTest -', () {
    group('addItem -', () {
      test(
          'When given event with name and properties, should add it to list of events',
          () {
        final processor = _getProcessor();
        processor.addItem(1);
        expect(processor.events.length, 1);
      });

      test(
          'When called 6 times, should submit the events to the backend only once',
          () async {
        final processor = _getProcessor();

        for (var i = 0; i < 6; i++) {
          processor.addItem(i);
        }
        processor.batchProcessingStream
            .listen(expectAsync1((eventsToProcess) => expect(
                  eventsToProcess,
                  [0, 1, 2, 3, 4],
                )));

        expect(processor.events.length, 1);
      });

      test(
          'When called 4 times, and we wait 500ms, should call the captureEvents function',
          () async {
        final processor = _getProcessor();

        for (var i = 0; i < 4; i++) {
          processor.addItem(i);
        }

        await Future.delayed(Duration(milliseconds: 500));

        processor.batchProcessingStream
            .listen(expectAsync1((eventsToProcess) => expect(
                  eventsToProcess,
                  [0, 1, 2, 3],
                )));

        expect(processor.events.length, 0);
      });

      test(
          'When called 6 times, should call submit the captureEvents function twice, once after 5th call, and another after 500ms',
          () async {
        final processor = _getProcessor();

        for (var i = 0; i < 6; i++) {
          processor.addItem(i);
        }

        await Future.delayed(Duration(milliseconds: 5));

        await Future.delayed(Duration(milliseconds: 500));

        expect(
            processor.batchProcessingStream,
            emitsInOrder([
              [0, 1, 2, 3, 4],
              [5]
            ]));

        expect(processor.events.length, 0);
      });
    });
  });
}
