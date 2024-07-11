import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quick_news/features/bottom_nav/ui/bottom_nav.dart';
import 'package:quick_news/utils/text_styles.dart';
import '../../bottom_nav/bloc/bottom_nav_bloc.dart';
import '../../category/ui/category.dart';
import '../../profile/ui/profile_page.dart';
import '../../search/ui/search.dart';
import '../bloc/home_bloc.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<Widget> _screens = [
    const HomeScreen(),
    Category(),
    const Search(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomeBloc()..add(HomeNewsFetchEvent())),
        BlocProvider(create: (context) => BottomNavBloc()),
      ],
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, bottomNavState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Quick News',
                style: MyTextStyles.boldedStyle,
              ),
              backgroundColor: Colors.pink.shade100,
            ),
            body: IndexedStack(
              index: bottomNavState.index,
              children: _screens,
            ),
            bottomNavigationBar: BottomNavBar(),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeNewsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeNewsLoadedSuccessState) {
          final successState = state;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                child: Text(
                  'Top Headlines',
                  style: MyTextStyles.headerStyle,
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeBloc>().add(HomeNewsFetchEvent());
                  },
                  child: ListView.builder(
                    itemCount: successState.news.length,
                    itemBuilder: (context, index) {
                      final newsItem = successState.news[index];
                      final imageUrl = newsItem.urlToImage;
                      final title = newsItem.title;
                      final formattedDate = DateFormat('dd-MM-yyyy – KK:mm')
                          .format(newsItem.publishedAt!);

                      return Container(
                        margin:
                            const EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (imageUrl != null)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            if (title != null)
                              InkWell(
                                onTap: () {
                                  
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    title,
                                    style: MyTextStyles.boldedStyle,
                                  ),
                                ),
                              ),
                            Text(formattedDate.toString()),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is HomeNewsLoadingErrorState) {
          return const Center(
              child: Text('Failed to load news. Please try again later.'));
        }
        return const Center(child: Text('Unknown state'));
      },
    );
  }
}
