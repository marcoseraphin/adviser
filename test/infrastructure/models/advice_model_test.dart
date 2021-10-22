import 'dart:convert';

import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tAdviceModel = AdviceModel(advice: "test", id: 1);

  test("model should be subclass of AdviceEntity", () {
    // assert
    expect(tAdviceModel, isA<AdviceEntity>());
  });

  group("fromJson factor", () {
    test("should return a valid model if the JSON advice is correct", () {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("advice.json"));

      // act
      final result = AdviceModel.fromJson(jsonMap);

      // assert
      expect(result, tAdviceModel);
    });
  });
}
