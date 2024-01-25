import 'package:clean_project/data/data_sources/advice_remote_datasource.dart';
import 'package:clean_project/data/exceptions/exceptions.dart';
import 'package:clean_project/domain/entities/advice_entity.dart';
import 'package:clean_project/domain/failures/failures.dart';
import 'package:clean_project/domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceRepoImpl implements AdviceRepo {
  AdviceRepoImpl({required this.adviceRemoteDatasource});
  final AdviceRemoteDatasource adviceRemoteDatasource;
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
