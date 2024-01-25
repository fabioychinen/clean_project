import 'package:clean_project/domain/entities/advice_entity.dart';
import 'package:clean_project/domain/failures/failures.dart';
import 'package:clean_project/domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdvicerUseCases {
  AdvicerUseCases({required this.adviceRepo});

  final AdviceRepo adviceRepo;
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDatasource();
  }
}
