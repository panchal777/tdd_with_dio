part of 'articles_bloc.dart';


abstract class ArticlesState {
  const ArticlesState();
}

class InitialState extends ArticlesState {}

class StateLoading extends ArticlesState {}

class ErrorState extends ArticlesState {
  String errorMessage;

  ErrorState(this.errorMessage);
}

/*----------------------------------*/

class GetArticleSuccessState extends ArticlesState {
  final List<ArticleModel> articles;

  GetArticleSuccessState(this.articles);
}

class SearchState extends ArticlesState {
  final List<ArticleModel> articles;

  SearchState(this.articles);
}
