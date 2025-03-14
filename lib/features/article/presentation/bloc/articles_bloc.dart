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
  }

  Future<void> _getArticles(
    GetArticlesEvent event,
    Emitter<ArticlesState> emit,
  ) async {
    if (event.withLoading) {
      emit(StateLoading());
    }

    await articlesUseCase.call(ArticlesParams(period: event.period)).then((
      value,
    ) {
      value.fold(
        (l) {
          emit(ErrorState(l.errorMessage));
        },
        (r) {
          allArticles = r;
          emit(GetArticleSuccessState(_runFilter(event.text)));
        },
      );
    });
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
