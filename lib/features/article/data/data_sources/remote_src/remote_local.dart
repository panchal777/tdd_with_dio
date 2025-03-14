import 'package:tdd_with_dio/features/article/data/models/article_response_model.dart';
import 'package:tdd_with_dio/features/article/data/models/articles_model.dart';
import 'package:tdd_with_dio/features/article/domain/usecases/articles_usecase.dart';

abstract class ArticleRemote {
  Future<ApiResponse<List<ArticleModel>>> getArticlesFromServer(
    ArticlesParams params,
  );
}
