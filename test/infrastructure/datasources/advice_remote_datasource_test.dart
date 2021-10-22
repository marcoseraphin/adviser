import 'package:adviser/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:adviser/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'advice_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AdvicerRemoteDatasource advicerRemoteDatasource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    advicerRemoteDatasource = AdvicerRemoteDataSourceImpl(client: mockClient);
  });

  void setupMockClientSuccess200() {
// arrange
    when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
        (_) async => http.Response(fixture("advice_http_respond.json"), 200));
  }

  void setupMockClientFailure404() {
// arrange
    when(mockClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response("something went wrong", 404));
  }

  group("getRandomAdviceFromApi", () {
    final tAdviceModel = AdviceModel(advice: "test", id: 1);

    test(
        "should perform get request URL with advice beeing the exndpoint and header application/json",
        () {
      // arrange
      setupMockClientSuccess200();

      // act
      advicerRemoteDatasource.getRandomAdviceFromApi();

      // assert
      verify(mockClient.get(Uri.parse("https://api.adviceslip.com/advice"),
          headers: {'Content-Type': 'application/json'}));
    });

    test("should return a valid advice when the response is a success",
        () async {
      // arrange
      setupMockClientSuccess200();

      // act
      final result = await advicerRemoteDatasource.getRandomAdviceFromApi();

      // assert
      expect(result, tAdviceModel);
    });

    test("should throw server exception if the response code is not 200",
        () async {
      // arrange
      setupMockClientFailure404();

      // act
      final call = advicerRemoteDatasource.getRandomAdviceFromApi;

      // assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
