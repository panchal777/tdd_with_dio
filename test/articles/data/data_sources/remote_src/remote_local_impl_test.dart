import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_with_dio/core/network/error/exceptions.dart';
import 'package:tdd_with_dio/core/utils/network_constant.dart';
import 'package:tdd_with_dio/features/article/data/data_sources/remote_src/remote_local.dart';
import 'package:tdd_with_dio/features/article/data/data_sources/remote_src/remote_local_impl.dart';
import 'package:tdd_with_dio/features/article/domain/usecases/articles_usecase.dart';

import 'mock_data/actual_expected_json.dart';
import 'remote_local_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  ArticlesParams articlesParams = ArticlesParams(period: 30);

  late MockDio mockDio;

  late ArticleRemote articleRemote;

  setUp(() {
    mockDio = MockDio();
    articleRemote = ArticleRemoteImpl(mockDio);
  });

  RequestOptions requestOptions = RequestOptions();

  group("Test remote_articles_api", () {
    test("Get All Articles - Failed Case", () async {
      // Mockito will store the fake call to `fakeCall`, and pair the exact
      // arguments given with the response. When `fakeCall` is called outside a
      // `when` or `verify` context (a call "for real"), Mockito will respond with
      // the stored canned response, if it can match the mock method parameters.
      when(mockDio.get(getArticlePath(articlesParams.period))).thenAnswer((
        realInvocation,
      ) async {
        // Actual result
        return Response(requestOptions: requestOptions, statusCode: 400);
      });
      var result;
      try {
        result = await articleRemote.getArticlesFromServer(articlesParams);
      } catch (e) {
        result = e;
      }
      // Compare actual result with expected result
      expect(result, ServerException("Unknown Error", 400));
    });

    test("Get All Articles - Empty Case", () async {
      when(mockDio.get(getArticlePath(articlesParams.period))).thenAnswer((
        realInvocation,
      ) async {
        // Actual result
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: actualArticlesEmptyJson,
        );
      });
      var result;
      try {
        result = await articleRemote.getArticlesFromServer(articlesParams);
      } catch (e) {
        result = e;
      }
      // Compare actual result with expected result
      expect(result, expectedArticlesEmptyListData);
    });
    test("Get All Articles -Article Success List", () async {
      when(mockDio.get(getArticlePath(articlesParams.period))).thenAnswer((
        realInvocation,
      ) async {
        // Actual result
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: actualSuccessArticlesListJson,
        );
      });
      var result;
      try {
        result = await articleRemote.getArticlesFromServer(articlesParams);
      } catch (e) {
        result = e;
      }
      // Compare actual result with expected result
      expect(result, expectedSuccessArticlesListData);
    });
  });
}
