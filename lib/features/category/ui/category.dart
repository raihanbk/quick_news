import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../utils/text_styles.dart';
import '../bloc/category_bloc.dart';
import '../repo/category_repo.dart';

class Category extends StatelessWidget {
  Category({super.key});

  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
            style: MyTextStyles.headerStyle,
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: categories
                .map((category) => Tab(text: category.capitalize()))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: categories.map((category) {
            return BlocProvider(
              create: (context) => CategoryBloc(CategoryRepo())
                ..add(CategoriesInitialFetchEvent(category)),
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoriesNewsLoadedSuccessState) {
                    final success = state as CategoriesNewsLoadedSuccessState;
                    return ListView.builder(
                      itemCount: success.news.length,
                      itemBuilder: (context, index) {
                        final newsItem = success.news[index];
                        final imageUrl = newsItem.urlToImage;
                        final title = newsItem.title;
                        final formattedDate = DateFormat('dd-MM-yyyy – KK:mm')
                            .format(newsItem.publishedAt!);

                        return Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (imageUrl != null)
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.10,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (title != null)
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.60,
                                      child: Text(
                                        title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: MyTextStyles.boldedStyle,
                                      ),
                                    ),
                                    Text(formattedDate.toString()),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
