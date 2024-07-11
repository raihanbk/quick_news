part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CategoriesInitialFetchEvent extends CategoryEvent {
  final String category;

  CategoriesInitialFetchEvent(this.category);
}
