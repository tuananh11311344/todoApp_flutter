
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:todo_app/src/components/pages/Home/home.dart';
import 'package:todo_app/src/routes/RouterMenuWidget.dart';
import 'package:todo_app/src/components/pages/Profile/profile.dart';

class Drawernavigaton extends StatefulWidget {
  const Drawernavigaton({super.key});

  @override
  State<Drawernavigaton> createState() => _DrawernavigatonState();
}

class _DrawernavigatonState extends State<Drawernavigaton> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: Image(
                    image: AssetImage("assets/images/avatar1.jpg"),
                  )),
              accountName: Text('Nguyen Tuan Anh'),
              accountEmail: Text('tuananh260602@gmail.com'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ProfileMenuWidget(
              title: 'Home',
              icon: LineAwesomeIcons.home,
              onPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Home())); //chuyển trang
              },
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'Profile',
              icon: LineAwesomeIcons.user,
              onPress: () {
              //  GoRouter.of(context).go("/profile");
               Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Profile()));
              },
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'Billing Details',
              icon: LineAwesomeIcons.wallet,
              onPress: () {},
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'Settings',
              icon: LineAwesomeIcons.cog,
              onPress: () {},
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'Logout',
              icon: LineAwesomeIcons.alternate_sign_out,
              onPress: () {
               context.go("/login");
              },
              endIcon: true,
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
