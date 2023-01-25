import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/providers.dart';
import 'package:profile_app/user_manager/user_reopsitory.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/view/page/profile.dart';
import 'package:profile_app/view/page/login.dart';
import 'package:profile_app/view/page/registration.dart';
import 'package:profile_app/view/widget/buttons.dart';
import 'package:profile_app/view/widget/layout.dart';
import 'package:profile_app/view/widget/student_crud.dart';

class HomePage extends ConsumerStatefulWidget{
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  int _selectedTabIndex = 0;

  static const List<Widget> _tabWidgetOptions = [
    HomeBody(),
    Text(""),
    StudentListView(),
  ];


  void _onItemBottomAppBarItemTapped(int index) {
    if (index == 1) return;
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _openLogoutPage(BuildContext context) {
    NavigationUtil.pushAndRemoveAllPreviousRoute(context, const LoginPage());
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(userProvider, (previous, next) {
      if(next == null){
        _openLogoutPage(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Home")),
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
      endDrawer: _Drawer(),
      bottomNavigationBar: _BottomAppBar(
        selectedIndex: _selectedTabIndex,
        onItemTapped: _onItemBottomAppBarItemTapped,
      ),
      body: _tabWidgetOptions.elementAt(_selectedTabIndex),
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(null),
            label: 'Add Students',              
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Students',
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
  const HomeBody({
    Key? key,
  }) : super(key: key);

  void _onViewProfileTab(BuildContext context) {
    _openProfilePage(context);
  }

  void _openProfilePage(BuildContext context){
    NavigationUtil.push(context, const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "WELCOME TO HOME",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedTextButton(
              onPressed: () => _onViewProfileTab(context),
              text: "View Profile",
            )
          )
        ],
      ),
    );
  }
}

class _Drawer extends ConsumerWidget {
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
    ref.read(userProvider.notifier).logout();
  }

  void _openProfilePage(BuildContext context){
    NavigationUtil.push(context, const ProfilePage());
  }

  void _openRegisterPage(BuildContext context) {
    NavigationUtil.push(context, const RegistrationPage());
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
          _DrawerHeader(),
          MenuItem(
            name: "Home",
            icon: Icons.home_outlined,
            onTap:() =>  _onNavHomeTab(context),
          ),
          MenuItem(
            name: "Profile",
            icon: Icons.person_outline,
            onTap: () => _onNavProfileTab(context),
          ),
          MenuItem(
            name: "Logout",
            icon: Icons.logout_outlined,
            onTap: () =>  _onNavLogoutTab(context, ref),
          ),
          const Divider(color: Colors.black,),
          MenuItem(
            name: "Register",
            icon: Icons.add_outlined,
            onTap: () => _onNavRegisterTab(context),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider) ?? User.emptyUser;

    return SizedBox(
      height: 250,
      child: DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: Column(
          children:  [
            const Expanded(
              child: CirculerImage(
                image: AssetImage("images/sukanto_profile_pic.jpg")
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