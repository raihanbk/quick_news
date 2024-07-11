import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bottom_nav_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          onTap: (value) {
            context.read<BottomNavBloc>().add(TriggerAppEvent(value));
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.pink.shade100,
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.category,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
