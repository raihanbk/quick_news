import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quick_news/features/category/repo/category_repo.dart';

import '../../../model/news_model.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(CategoryRepo categoryRepo) : super(CategoryInitial()) {
    on<CategoriesInitialFetchEvent>(categoriesInitialFetchEvent);
  }

  FutureOr<void> categoriesInitialFetchEvent(
      CategoriesInitialFetchEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryNewsLoadingState());

    try {
      final response = await CategoryRepo.fetchCategory(event.category);
      emit(CategoriesNewsLoadedSuccessState(news: response));

    } catch(e) {
      emit(CategoriesLoadingErrorState());
    }

  }
}
