import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/components/pages/Home/home.dart';
import 'package:todo_app/src/components/pages/Login/Login.dart';
import 'package:todo_app/src/components/pages/Profile/profile.dart';

class Router extends StatelessWidget {
  Router({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Go Router",
      routerConfig: _router,
    );
  }
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: ((context,state)=>const Home())),
    GoRoute(path: "/profile", builder: ((context,state)=>const Profile())),
    GoRoute(path: "/login", builder: ((context,state)=>const Login())),
  ]
);
}
