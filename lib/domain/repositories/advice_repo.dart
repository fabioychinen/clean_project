import 'package:clean_project/domain/entities/advice_entity.dart';
import 'package:clean_project/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource();
}
