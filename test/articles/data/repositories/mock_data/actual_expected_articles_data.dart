import 'package:dartz/dartz.dart';
import 'package:tdd_with_dio/core/network/error/exceptions.dart';
import 'package:tdd_with_dio/core/network/error/failures.dart';
import 'package:tdd_with_dio/features/article/data/models/article_response_model.dart';
import 'package:tdd_with_dio/features/article/data/models/articles_model.dart';

/*----------------Actual---------------*/

ApiResponse<List<ArticleModel>> actualArticlesFailedOrEmptyListData =
    ApiResponse(status: null, copyright: null, numResults: null, results: null);

ApiResponse<List<ArticleModel>> actualSuccessArticlesListData = ApiResponse(
  status: null,
  copyright: null,
  numResults: null,
  results: [
    ArticleModel(id: 100000008872080),
    ArticleModel(id: 100000008852162),
  ],
);
ServerException actualServerException = ServerException(
  'server exception',
  401,
);

/*----------------Expected---------------*/

Right<Failure, List<ArticleModel>> expectedArticlesEmptyListData = Right(
  <ArticleModel>[],
);

Right<Failure, List<ArticleModel>> expectedSuccessArticlesListData = Right(
  <ArticleModel>[
    ArticleModel(id: 100000008872080),
    ArticleModel(id: 100000008852162),
  ],
);

Left<Failure, List<ArticleModel>> expectedServerException = Left(
  ServerFailure('server exception', 401),
);
