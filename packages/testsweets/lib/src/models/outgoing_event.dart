import 'package:freezed_annotation/freezed_annotation.dart';

part 'outgoing_event.freezed.dart';
part 'outgoing_event.g.dart';

@freezed
class OutgoingEvent with _$OutgoingEvent {
  factory OutgoingEvent({
    required String name,
    @Default({}) Map<String, dynamic> properties,
  }) = _OutgoingEvent;

  factory OutgoingEvent.fromJson(Map<String, dynamic> json) =>
      _$OutgoingEventFromJson(json);
}
