import 'dart:ui';

class SerializableRect extends Rect {
  const SerializableRect.fromLTWH(
    double left,
    double top,
    double width,
    double height,
  ) : super.fromLTWH(left, top, width, height);

  SerializableRect.fromPoints(Offset a, Offset b) : super.fromPoints(a, b);

  factory SerializableRect.fromJson(Map<String, dynamic> json) {
    return SerializableRect.fromLTWH(
      (json['left']! as num).toDouble(),
      (json['top']! as num).toDouble(),
      (json['width']! as num).toDouble(),
      (json['height']! as num).toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'left': left,
      'top': top,
      'width': width,
      'height': height,
    };
  }
}
