import 'package:flutter/material.dart';

import 'my_app.dart';
import './users_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UsersCollection(),
      child: const MyApp(),
    ),
  );
}
