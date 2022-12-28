import 'package:flutter_test/flutter_test.dart';
import 'package:survey_kit/src/model/answer/option.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  final tResult = StepResult(
    id: 'example1',
    startTime: DateTime(2022, 8, 12, 16, 4),
    endTime: DateTime(2022, 8, 12, 16, 14),
    valueIdentifier: 'singleChoiceValue1',
    result: const Option(id: 'choice1', value: 'option2'),
  );

  group('serialisation', () {
    test(
      'should work with valid example',
      () async {
        final encodedResult = tResult.toJson();
        final decodedResult = StepResult<Option>.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}