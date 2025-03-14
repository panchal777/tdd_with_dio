import 'package:tdd_with_dio/features/article/data/data_sources/remote_src/remote_local.dart';
import 'package:tdd_with_dio/features/article/data/models/article_response_model.dart';
import 'package:tdd_with_dio/features/article/data/models/articles_model.dart';
import 'package:tdd_with_dio/features/article/domain/usecases/articles_usecase.dart';

class ArticleRemoteImpl extends ArticleRemote {
  @override
  Future<ApiResponse<List<ArticleModel>>> getArticlesFromServer(
    ArticlesParams params,
  ) {
    // TODO: implement getArticlesFromServer
    throw UnimplementedError();
  }
}
