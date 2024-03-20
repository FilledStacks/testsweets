import 'package:testsweets/src/models/outgoing_event.dart';
import 'package:testsweets/src/utils/batch_processing/batch_processor.dart';
import 'package:testsweets/testsweets.dart';

class EventsProcessor extends BatchProcessor<OutgoingEvent> {}

class InteractionsProcessor extends BatchProcessor<Interaction> {}
