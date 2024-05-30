import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/components/pages/Home/AddNoteScreen.dart';
import 'package:todo_app/src/components/pages/Home/home.dart';
import 'package:todo_app/src/components/pages/Login/Login.dart';
import 'package:todo_app/src/components/pages/Profile/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Go Router",
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }

  final GoRouter _router = GoRouter(initialLocation: "/login", routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const Home(),
    ),
    GoRoute(
        path: "/addTask",
        builder: (context, state) {
          final updateTaskList = state.extra as Function;
          return AddNoteScreen(
            updateTaskList: updateTaskList,
          );
        }),
    GoRoute(
        path: "/addTask/:id",
        builder: (context, state) =>
            AddNoteScreen(id: int.parse(state.params["id"]!))),
    GoRoute(path: "/profile", builder: (context, state) => const Profile()),
    GoRoute(path: "/login", builder: (context, state) => const Login()),
  ]);
}
