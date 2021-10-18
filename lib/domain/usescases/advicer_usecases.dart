import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/repositories/advicer_repository.dart';
import 'package:adviser/infrastructure/repositories/advicer_repository_impl.dart';
import 'package:dartz/dartz.dart';

class AdvicerUsecases {
  // Future sleep1() {
  //   return Future.delayed(const Duration(seconds: 2), () => {"1"});
  // }

  final AdvicerRepository advicerRepository = AdvicerRepositoryImpl();

  Future<Either<Failure, AdviceEntity>> getAdviceUsecase() async {
    // Business logic implementation
    return advicerRepository.getAdviceFromApi();

    // call function from repotitory to get advice

    //await sleep1(); // fake network request

    //return Right(AdviceEntity(advice: "example", id: 1));
    //return Left(ServerFailure());
  }
}
