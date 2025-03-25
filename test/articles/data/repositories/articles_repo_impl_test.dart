import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_with_dio/features/article/data/data_sources/remote_src/remote_local_impl.dart';
import 'package:tdd_with_dio/features/article/data/repositories/articles_repo_impl.dart';
import 'package:tdd_with_dio/features/article/domain/repositories/article_respository.dart';
import 'package:tdd_with_dio/features/article/domain/usecases/articles_usecase.dart';

import 'articles_repo_impl_test.mocks.dart';
import 'mock_data/actual_expected_articles_data.dart';

@GenerateMocks([ArticleRemoteImpl])
void main() {
  ArticlesParams articlesParams = ArticlesParams(period: 30);

  late MockArticleRemoteImpl remoteImpl;

  //Current repo class
  late ArticleRepository articleRepository;

  setUp(() {
    remoteImpl = MockArticleRemoteImpl();
    articleRepository = ArticleRepositoryImpl(remoteImpl);
  });

  group('Test articles_repo_impl', () {
    test(
      'Get All Articles - Failed Case, Empty or Null api response',
      () async {
        when(remoteImpl.getArticlesFromServer(articlesParams)).thenAnswer((
          realInvocation,
        ) async {
          return actualArticlesFailedOrEmptyListData;
        });

        dynamic result;
        try {
          result = await articleRepository.getArticles(articlesParams);
        } catch (e) {
          result = e;
        }

        expect(result.value, expectedArticlesEmptyListData.value);
      },
    );

    test("Get All Articles - Success Case", () async {
      when(remoteImpl.getArticlesFromServer(articlesParams)).thenAnswer((
        realInvocation,
      ) async {
        return actualSuccessArticlesListData;
      });

      dynamic result;
      try {
        result = await articleRepository.getArticles(articlesParams);
      } catch (e) {
        result = e;
      }
      expect(result.value, expectedSuccessArticlesListData.value);
    });
  });

  // test('Get All Articles - Check exception', () async {
  //   when(remoteImpl.getArticlesFromServer(articlesParams)).thenThrow((
  //     realInvocation,
  //   ) async {
  //     return actualServerException;
  //   });
  //
  //   dynamic result;
  //   try {
  //     result = await articleRepository.getArticles(articlesParams);
  //   } catch (e) {
  //     result = e;
  //   }
  //
  //   expect(
  //     result.value is ServerException,
  //     expectedServerException.value is ServerFailure,
  //   );
  // });
}
