import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tdd_with_dio/features/article/data/models/articles_model.dart';
import 'package:tdd_with_dio/features/article/domain/usecases/articles_usecase.dart';

part 'articles_event.dart';

part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticlesUseCase articlesUseCase;
  List<ArticleModel> allArticles = [];

  ArticlesBloc({required this.articlesUseCase}) : super(InitialState()) {
    on<GetArticlesEvent>(_getArticles);
    on<SearchArticleEvent>(_onSearchEvent);
  }

  Future<void> _getArticles(
    GetArticlesEvent event,
    Emitter<ArticlesState> emit,
  ) async {
    if (event.withLoading) {
      emit(StateLoading());
    }

    var value = await articlesUseCase.call(
      ArticlesParams(period: event.period),
    );
    value.fold(
      (l) {
        emit(ErrorState(l.errorMessage));
      },
      (r) {
        allArticles = r;
        emit(GetArticleSuccessState(_runFilter(event.text)));
      },
    );
  }

  // Searching event
  _onSearchEvent(
    SearchArticleEvent event,
    Emitter<ArticlesState> emitter,
  ) async {
    emitter(SearchState(_runFilter(event.text)));
  }

  List<ArticleModel> _runFilter(String text) {
    List<ArticleModel> results = [];
    if (text.isEmpty) {
      results = List.from(allArticles);
    } else {
      results =
          allArticles.where((user) {
            return (user.title ?? '-').toLowerCase().contains(
              text.toLowerCase(),
            );
          }).toList();
    }
    return results;
  }
}
