import 'package:flutter/material.dart';

import 'users_list.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Refactor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<UsersCollection>(builder: (context, users, child) {
        return UsersList(users: users);
      }),
      routes: {
        UsersList.routeName: (context) =>
            Consumer<UsersCollection>(builder: (context, users, child) {
              return UsersList(users: users);
            }),
      },
      onGenerateRoute: (settings) {
        if (settings.name == UserDetailsArguments.routeName) {
          final args = settings.arguments as UserDetailsArguments;

          return MaterialPageRoute(builder: (context) {
            return Consumer<UsersCollection>(builder: (context, users, child) {
              return UserDetails(user: args.user, users: users);
            });
          });
        }
        return null;
      },
    );
  }
}
