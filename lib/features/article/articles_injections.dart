import 'package:tdd_with_dio/features/article/data/data_sources/remote_src/remote_local.dart';
import 'package:tdd_with_dio/features/article/data/data_sources/remote_src/remote_local_impl.dart';
import 'package:tdd_with_dio/features/article/domain/repositories/article_respository.dart';
import '../../core/network/dio_network.dart';
import '../../core/utils/injections.dart';
import 'data/repositories/articles_repo_impl.dart';
import 'domain/usecases/articles_usecase.dart';

initArticlesInjections() {


  /*remote apis*/
  sl.registerSingleton<ArticleRemote>(ArticleRemoteImpl(DioNetwork.appAPI));

  /*repository*/
  sl.registerSingleton<ArticleRepository>(ArticleRepoImpl(sl()));

  /*use case*/
  sl.registerSingleton<ArticlesUseCase>(ArticlesUseCase(sl()));


  // sl.registerSingleton<ArticlesSharedPrefs>(ArticlesSharedPrefs(sl()));
}
