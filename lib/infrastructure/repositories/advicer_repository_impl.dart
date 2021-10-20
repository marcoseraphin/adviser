import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/repositories/advicer_repository.dart';
import 'package:adviser/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

class AdvicerRepositoryImpl implements AdvicerRepository {
  final AdvicerRemoteDatasource advicerRemoteDatasource;

  AdvicerRepositoryImpl({required this.advicerRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi() async {
    try {
      final remoteAdvice =
          await advicerRemoteDatasource.getRandomAdviceFromApi();
      return Right(remoteAdvice);
    } catch (e) {
      if (e.runtimeType is ServerException) {
        return Left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }
}
