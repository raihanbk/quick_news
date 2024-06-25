import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_news/utils/text_styles.dart';

import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeNewsFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeNewsLoadedSuccessState:
            final successState = state as HomeNewsLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Quick News',
                    style: MyTextStyles.boldedStyle,
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text('Top Headlines', style: MyTextStyles.headerStyle,),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: successState.news.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: MediaQuery.of(context).size.height *
                                        0.10,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(successState
                                                .news[index].urlToImage!),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.60,
                                        child: Text(
                                          successState.news[index].title!,
                                          style: MyTextStyles.boldedStyle,
                                        ),
                                      ),
                                      Text(successState.news[index].publishedAt!
                                          .toString()),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ));
        }
        return SizedBox();
      },
    );
  }
}
