import 'package:dartz/dartz.dart';
import 'package:tdd_with_dio/core/network/error/exceptions.dart';
import 'package:tdd_with_dio/core/network/error/failures.dart';
import 'package:tdd_with_dio/features/article/data/models/articles_model.dart';
import 'package:tdd_with_dio/features/article/domain/repositories/article_respository.dart';
import 'package:tdd_with_dio/features/article/domain/usecases/articles_usecase.dart';

import '../data_sources/remote_src/remote_local.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  ArticleRemote articleRemote;

  ArticleRepositoryImpl(this.articleRemote);

  @override
  Future<Either<Failure, List<ArticleModel>>> getArticles(
    ArticlesParams params,
  ) async {
    try {
      final result = await articleRemote.getArticlesFromServer(params);
      return Right(result.results ?? []);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
