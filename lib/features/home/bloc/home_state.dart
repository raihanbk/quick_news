part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}

class HomeNewsLoadingState extends HomeState {}

class HomeNewsLoadedSuccessState extends HomeState {
  final List<Article> news;

  HomeNewsLoadedSuccessState({required this.news});
}

class HomeNewsLoadingErrorState extends HomeState {}
