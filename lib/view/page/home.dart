import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/view/page/login.dart';
import 'package:profile_app/view/widget/home/body.dart';
import 'package:profile_app/view/widget/home/drawer.dart';
import 'package:profile_app/view/widget/loading.dart';
import 'package:profile_app/view/widget/error.dart';
import 'package:profile_app/view/widget/student_crud/student_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userImage = ref.watch(userImageProvider);
    return ref.watch(userProvider).when(
      data: (user) {
        if(user != null){
          return HomeWidget(user: user, userImage: userImage);
        }else{
          return LoginPage();
        }
      },
      loading: () {
        return const LoadingWidget();
      },
      error: (error, stackTrace) {
        return const TryAgainErrorWidget();
      },
    );
  }
}


class HomeWidget extends StatefulWidget {
  final User user;
  final ImageProvider userImage;
  const HomeWidget({
    super.key,
    required this.user,
    required this.userImage
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _selectedTabIndex = 0;

  void _onItemBottomAppBarItemTapped(int index) {
    if (index == 1) return;
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabWidgetOptions = [
      HomeBody(user: widget.user),
      const Center(),
      const StudentListView(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(
          StringConstants.homeAppBarTitleText
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: IconButton(
          icon: const Icon(Icons.add), 
          onPressed: () async {
            DialogUtil.showAddStudentDialog(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      endDrawer: HomePageDrawer(user: widget.user, userImage: widget.userImage),
      bottomNavigationBar: _BottomAppBar(
        selectedIndex: _selectedTabIndex,
        onItemTapped: _onItemBottomAppBarItemTapped,
      ),
      body: tabWidgetOptions.elementAt(_selectedTabIndex),
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  const _BottomAppBar({
    Key? key,
    this.onItemTapped,
    required this.selectedIndex,
  }) : super(key: key);

  final ValueChanged<int>? onItemTapped;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5.0,
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: StringConstants.bottomNavHomeItemLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(null),
            label: StringConstants.bottomNavAddStudentItemLabel,              
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: StringConstants.bottomNavStudentsItemLabel,
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: onItemTapped,
      ),
    );
  }
}
