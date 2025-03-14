import 'package:dartz/dartz.dart';
import 'package:tdd_with_dio/core/network/error/failures.dart';
import 'package:tdd_with_dio/core/utils/usecase.dart';
import 'package:tdd_with_dio/features/article/data/models/articles_model.dart';
import 'package:tdd_with_dio/features/article/domain/repositories/article_respository.dart';

class ArticlesUseCase extends UseCase<List<ArticleModel>, ArticlesParams> {
  final ArticleRepository articleRepository;

  ArticlesUseCase(this.articleRepository);

  @override
  Future<Either<Failure, List<ArticleModel>>> call(params) async {
    return await articleRepository.getArticles(params);
  }
}

// Required params for this use-case
class ArticlesParams {
  ArticlesParams({required this.period});

  late final int period;

  ArticlesParams.fromJson(Map<String, dynamic> json) {
    period = json['period'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['period'] = period;
    return _data;
  }
}
