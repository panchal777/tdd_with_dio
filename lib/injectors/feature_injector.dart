import 'package:tdd_with_dio/core/network/dio_network.dart';
import 'package:tdd_with_dio/features/article/data/data_sources/remote_src/remote_local.dart';
import 'package:tdd_with_dio/features/article/data/data_sources/remote_src/remote_local_impl.dart';
import 'package:tdd_with_dio/features/article/domain/repositories/article_respository.dart';
import 'package:tdd_with_dio/features/article/presentation/bloc/articles_bloc.dart';
import 'package:tdd_with_dio/injectors/main_injector.dart';

import '../features/article/data/repositories/articles_repo_impl.dart';
import '../features/article/domain/usecases/articles_usecase.dart';

class FeatureInjector {
  FeatureInjector._();

  static init() async {
    final injector = MainInjector.instance;

    // bloc
    injector.registerFactory(() => ArticlesBloc(articlesUseCase: injector()));

    // use case
    injector.registerLazySingleton(() => ArticlesUseCase(injector()));

    // repos
    injector.registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(injector()),
    );

    //local
    injector.registerLazySingleton<ArticleRemote>(
      () => ArticleRemoteImpl(DioNetwork.appAPI),
    );
  }
}

//
// initArticlesInjections() {
//
//
//   /*remote apis*/
//   sl.registerSingleton<ArticleRemote>(ArticleRemoteImpl(DioNetwork.appAPI));
//
//   /*repository*/
//   sl.registerSingleton<ArticleRepository>(ArticleRepoImpl(sl()));
//
//   /*use case*/
//   sl.registerSingleton<ArticlesUseCase>(ArticlesUseCase(sl()));
//
//
//   // sl.registerSingleton<ArticlesSharedPrefs>(ArticlesSharedPrefs(sl()));
// }
