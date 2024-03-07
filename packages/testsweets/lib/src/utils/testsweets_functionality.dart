import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/events_service.dart';

class TestSweets {
  static void captureEvent({
    required String name,
    required Map<String, dynamic> properties,
  }) {
    locator<EventsService>().captureEvent(name: name, properties: properties);
  }
}
