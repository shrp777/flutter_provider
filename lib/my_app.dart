import 'package:flutter/material.dart';

import 'users_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Refactor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UsersList(),
      routes: {
        UsersList.routeName: (context) => const UsersList(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == UserDetailsArguments.routeName) {
          final args = settings.arguments as UserDetailsArguments;

          return MaterialPageRoute(builder: (context) {
            return UserDetails(
              user: args.user,
            );
          });
        }
      },
    );
  }
}
