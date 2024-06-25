import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quick_news/features/home/repo/home_repo.dart';

import '../../../model/news_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeNewsFetchEvent> (homeNewsFetchEvent);
  }

  FutureOr<void> homeNewsFetchEvent(HomeNewsFetchEvent event, Emitter<HomeState> emit) async{
    final news = await NewsHomeRepo.fetchNews();
    emit(HomeNewsLoadedSuccessState(news: news!));
  }
}
