import 'package:adviser/domain/entities/advice_entity.dart';

class AdviceModel extends AdviceEntity {
  AdviceModel({required String advice, required int id})
      : super(advice: advice, id: id);

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(advice: json["advice"], id: json["id"]);
  }
}
