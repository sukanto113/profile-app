import 'package:flutter/material.dart';
import 'package:profile_app/user_manager/user_manager.dart';
import 'package:profile_app/util/dialog.dart';
import 'package:profile_app/util/navigation.dart';
import 'package:profile_app/view/page/profile.dart';
import 'package:profile_app/view/page/login.dart';
import 'package:profile_app/view/page/registration.dart';
import 'package:profile_app/view/page/students_list.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  User _user = const User(name: "", email: "");
  int _selectedIndex = 0;

    static const List<Widget> _widgetOptions = <Widget>[
    const HomeBody(),
    const Text(""),
    StudentList(),
  ];


  @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      User user = await UserManager.getCurrentUser();
      setState(() {
        _user = user; 
      });

    });
    super.initState();
  }

  void _onItemTapped(int index) {
    if (index == 1) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Home")),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {  },
      child: IconButton(
        icon: const Icon(Icons.add), 
        onPressed: () async {
          // open add new page
          // await ref.read(studentsListProvider.notifier).addStudent();
          // if(isMounted()){
          //   DialogUtil.showStudentEditDialog(context, students.last);
          // }
          DialogUtil.showAddStudentDialog(context);

        },
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      endDrawer: AppNavigationDrawer(user: _user),
      bottomNavigationBar: BottomAppBar(
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
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
            child: ElevatedButton(
              onPressed: () => _onViewProfileTab(context),
              // onPressed: (){},
              child: const Text("View Profile"),
            ),
          )
        ],
      ),
    );
  }
}

class AppNavigationDrawer extends StatefulWidget {
  const AppNavigationDrawer({
    Key? key,
    required User user,
  }) : _user = user, super(key: key);

  final User _user;

  @override
  State<AppNavigationDrawer> createState() => _AppNavigationDrawerState();
}

class _AppNavigationDrawerState extends State<AppNavigationDrawer> {
  void _onNavHomeTab(){
    _closeDrawer();
    NavigationUtil.openHomePage(context);
  }

  void _onNavProfileTab() {
    _closeDrawer();
    _openProfilePage();
  }

  void _onNavRegisterTab() {
    _closeDrawer();
    _openRegisterPage();
  }

  Future<void> _onNavLogoutTab() async {
    _closeDrawer();

    await UserManager.logout();
    if(!mounted) return;

    _openLogoutPage();

  }
  void _openProfilePage(){
    NavigationUtil.push(context, const ProfilePage());
  }

  void _openLogoutPage() {
    NavigationUtil.pushAndRemoveAllPreviousRoute(context, const LoginPage());
  }

  void _openRegisterPage() {
    NavigationUtil.push(context, const RegistrationPage());
  }

  void _closeDrawer(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          _DrawerHeader(user: widget._user),
          MenuItem(
            name: "Home",
            icon: Icons.home_outlined,
            onTap: _onNavHomeTab,
          ),
          MenuItem(
            name: "Profile",
            icon: Icons.person_outline,
            onTap: _onNavProfileTab,
          ),
          MenuItem(
            name: "Logout",
            icon: Icons.logout_outlined,
            onTap: _onNavLogoutTab,
          ),
          const Divider(color: Colors.black,),
          MenuItem(
            name: "Register",
            icon: Icons.add_outlined,
            onTap: _onNavRegisterTab,
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
    required User user,
  }) : _user = user, super(key: key);

  final User _user;

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
            const Expanded(
              child: FittedBox(
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/sukanto_profile_pic.jpg")
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              _user.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            Text(
              _user.email,
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