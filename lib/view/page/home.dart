import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/values/providers.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/values/strings.dart';
import 'package:profile_app/view/page/profile.dart';
import 'package:profile_app/view/page/login.dart';
import 'package:profile_app/view/page/registration.dart';
import 'package:profile_app/view/widget/buttons.dart';
import 'package:profile_app/view/widget/layout.dart';
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
        return const ErrorWidget();
      },
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(StringConstants.errorTryLater),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:const [
        Opacity(
          opacity: 1,
          child: ModalBarrier(dismissible: false, color: Colors.white),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
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
      endDrawer: _Drawer(user: widget.user, userImage: widget.userImage),
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

class HomeBody extends StatelessWidget {
  final User user;
  const HomeBody({
    Key? key,
    required this.user
  }) : super(key: key);

  void _onViewProfileTab(BuildContext context) {
    _openProfilePage(context);
  }

  void _openProfilePage(BuildContext context){
    NavigationUtil.push(context, ProfilePage(user: user,));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            StringConstants.welcomeToHomeText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedTextButton(
              onPressed: () => _onViewProfileTab(context),
              text: StringConstants.viewProfileButtonText,
            )
          )
        ],
      ),
    );
  }
}

class _Drawer extends ConsumerWidget {

  final User user;
  final ImageProvider userImage;
  const _Drawer({
    required this.user,
    required this.userImage,
  });

  void _onNavHomeTab(BuildContext context){
    _closeDrawer(context);
    NavigationUtil.openHomePage(context);
  }

  void _onNavProfileTab(BuildContext context) {
    _closeDrawer(context);
    _openProfilePage(context);
  }

  void _onNavRegisterTab(BuildContext context) {
    _closeDrawer(context);
    _openRegisterPage(context);
  }

  _onNavLogoutTab(BuildContext context, WidgetRef ref) async {
    _closeDrawer(context);
    ref.read(authNotifireProvider.notifier).logout();
  }

  void _openProfilePage(BuildContext context){
    NavigationUtil.push(context, ProfilePage(user: user,));
  }

  void _openRegisterPage(BuildContext context) {
    NavigationUtil.push(context, RegistrationPage());
  }

  void _closeDrawer(BuildContext context){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          _DrawerHeader(user: user, userImage: userImage),
          MenuItem(
            name: StringConstants.drawerHomeItemName,
            icon: Icons.home_outlined,
            onTap:() =>  _onNavHomeTab(context),
          ),
          MenuItem(
            name: StringConstants.drawerProfileItemName,
            icon: Icons.person_outline,
            onTap: () => _onNavProfileTab(context),
          ),
          MenuItem(
            name: StringConstants.drawerLogoutItemName,
            icon: Icons.logout_outlined,
            onTap: () =>  _onNavLogoutTab(context, ref),
          ),
          const Divider(color: Colors.black,),
          MenuItem(
            name: StringConstants.drawerRegisterItemName,
            icon: Icons.add_outlined,
            onTap: () => _onNavRegisterTab(context),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final User user;
  final ImageProvider userImage;
  const _DrawerHeader({
    required this.user,
    required this.userImage,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: Column(
          children:  [
            Expanded(
              child: CirculerImage(
                image: userImage,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              user.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            Text(
              user.email,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget{
  const MenuItem({required this.name, required this.icon, required this.onTap, super.key});
  final String name;
  final IconData icon;
  final VoidCallback onTap; 
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 17
        ),
      ),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}