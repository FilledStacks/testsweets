import 'package:testsweets/testsweets.dart';

extension SerializableRectExtension on SerializableRect {
  bool biggestThan(SerializableRect anotherRect) {
    if ((this.size.width * this.size.height) >
        (anotherRect.size.width * anotherRect.size.height))
      return true;
    else
      return false;
  }

  SerializableRect get resposivy {
    return SerializableRect.fromPoints(this.topLeft, this.bottomRight);
  }
}
