import 'package:dio/dio.dart';
import 'package:tdd_with_dio/core/network/error/exceptions.dart';
import 'package:tdd_with_dio/core/utils/network_constant.dart';
import 'package:tdd_with_dio/features/article/data/data_sources/remote_src/remote_local.dart';
import 'package:tdd_with_dio/features/article/data/models/article_response_model.dart';
import 'package:tdd_with_dio/features/article/data/models/articles_model.dart';
import 'package:tdd_with_dio/features/article/domain/usecases/articles_usecase.dart';

import '../../../../../core/network/error/dio_error_handler.dart';

class ArticleRemoteImpl extends ArticleRemote {
  final Dio dio;

  ArticleRemoteImpl(this.dio);

  @override
  Future<ApiResponse<List<ArticleModel>>> getArticlesFromServer(
    ArticlesParams params,
  ) async {
    try {
      final result = (await dio.get(getArticlePath(params.period)));
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }

      return ApiResponse.fromJson<List<ArticleModel>>(
        result.data,
        ArticleModel.fromJsonList,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
