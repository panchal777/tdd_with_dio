import 'package:dartz/dartz.dart';
import 'package:tdd_with_dio/core/network/error/failures.dart';
import 'package:tdd_with_dio/features/article/data/models/articles_model.dart';

import '../usecases/articles_usecase.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleModel>>> getArticles(
    ArticlesParams params,
  );
}
