part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryNewsLoadingState extends CategoryState {}

class CategoriesNewsLoadedSuccessState extends CategoryState {
  final List<Article> news;

  CategoriesNewsLoadedSuccessState({required this.news});
}

class CategoriesLoadingErrorState extends CategoryState {}
