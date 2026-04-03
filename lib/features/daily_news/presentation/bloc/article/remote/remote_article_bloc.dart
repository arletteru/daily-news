import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/usercases/get_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticlesUseCase _getArticlesUseCase;

  RemoteArticleBloc(this._getArticlesUseCase) : super (const RemoteArticlesLoading()){
      on<GetArticles>(onGetArticles);
  }

  void onGetArticles(GetArticles event, Emitter<RemoteArticleState> emit) async{
    final dataState = await _getArticlesUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
        RemoteArticlesDone(articles: dataState.data!)
        );
    } else if (dataState is DataFailed) {
      emit(
        RemoteArticlesError(error: dataState.error!)
        );
    }
  }

}