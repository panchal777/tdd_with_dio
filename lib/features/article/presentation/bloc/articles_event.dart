part of 'articles_bloc.dart';

abstract class ArticlesEvent {
  const ArticlesEvent();
}

class GetArticlesEvent extends ArticlesEvent {
  final String text;
  final int period;
  final bool withLoading;

  GetArticlesEvent(this.text, this.period, {this.withLoading = true});
}

class SearchArticleEvent extends ArticlesEvent {
  final String text;

  SearchArticleEvent(this.text);
}
