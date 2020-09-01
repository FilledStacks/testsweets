import 'package:test/test.dart';
import 'package:testsweets_generator/src/data_models/data_models.dart';

void main() {
  group("AutomationKey", () {
    group("toDartCode - ", () {
      test("should return the dart map code for the model", () {
        AutomationKey model = new AutomationKey(
          name: "keyName",
          type: WidgetType.general,
          view: "keyView",
        );

        String expectedCode = '''{
            "name": "keyName",
            "type": "${WidgetType.general}",
            "view": "keyView"
          }
          '''
            .replaceAll(RegExp(r"\s+"), "");
        expect(model.toDartCode().replaceAll(RegExp(r"\s+"), ""), expectedCode);
      });
    });
  });
}
