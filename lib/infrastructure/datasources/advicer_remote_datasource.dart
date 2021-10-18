import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/infrastructure/models/advice_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AdvicerRemoteDatasource {
  /// request random advice from free API
  /// throws ServerException if response code is not 200
  Future<AdviceEntity> getRandomAdviceFromApi();
}

class AdvicerRemoteDataSourceImpl implements AdvicerRemoteDatasource {
  final http.Client client = http.Client();

  @override
  Future<AdviceEntity> getRandomAdviceFromApi() async {
    final response = await client.get(
        Uri.parse("https://api.adviceslip.com/advice"),
        headers: {'Content-Type': 'application/json'});

    final responseBody = json.decode(response.body);

    return AdviceModel.fromJson(responseBody["slip"]);
  }
}
