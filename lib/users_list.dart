import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

class User {
  String? uuid;
  String? firstname;
  String? lastname;
  String? email;
  String? gender;
  bool favorite = false;

  User(this.uuid, this.firstname, this.lastname, this.email, this.gender);

  String fullname() {
    return firstname! + " " + lastname!;
  }
}

class UsersCollection extends ChangeNotifier {
  final List<User> _users = [];

  UsersCollection() {
    var rng = Random();
    var uuid = const Uuid();

    for (var i = 0; i < 50; i++) {
      _users.add(
        User(
          uuid.v4(),
          faker.person.firstName(),
          faker.person.lastName(),
          faker.internet.email(),
          (rng.nextInt(1) > 0) ? "Male" : "Female",
        ),
      );
    }
  }

  UnmodifiableListView<User> get users => UnmodifiableListView(_users);

  void add(User user) {
    _users.add(user);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(User user) {
    _users.remove(user);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void update(User user) {
    var index = _users.indexOf(user);

    _users[index] = user;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  int length() {
    return _users.length;
  }

  User find(User user) {
    var index = _users.indexOf(user);
    return _users[index];
  }

  User findAt(int index) {
    return _users[index];
  }

  void removeAll() {
    _users.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}

class UsersList extends StatelessWidget {
  const UsersList({Key? key, required this.users}) : super(key: key);

  final UsersCollection users;

  static const routeName = '/users-master';

  void _onPress() {
    var uuid = const Uuid();
    var rng = Random();
    users.add(
      User(
        uuid.v4(),
        faker.person.firstName(),
        faker.person.lastName(),
        faker.internet.email(),
        (rng.nextInt(1) > 0) ? "Male" : "Female",
      ),
    );
  }

  Widget _usersList() {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemCount: users.length(),
      itemBuilder: (BuildContext context, int index) {
        return UserPreview(user: users.findAt(index), users: users);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users List"),
      ),
      body: _usersList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPress,
        tooltip: 'Add a contact',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserPreview extends StatelessWidget {
  const UserPreview({Key? key, required this.user, required this.users})
      : super(key: key);

  final User user;
  final UsersCollection users;

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.pushNamed(
        context,
        UserDetailsArguments.routeName,
        arguments: UserDetailsArguments(user: user),
      );
    }

    void _onFavoriteUpdate(bool favorite) {
      user.favorite = favorite;
      users.update(user);
    }

    return Container(
      color: user.favorite == true ? Colors.red[50] : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => onTap(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.fullname(),
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ToggleFavorite(user: user, onUpdate: _onFavoriteUpdate)
        ],
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key, required this.user, required this.users})
      : super(key: key);

  final User user;
  final UsersCollection users;

  void _onFavoriteUpdate(bool favorite) {
    user.favorite = favorite;
    user.favorite = favorite;
    users.update(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User's Details"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(user.uuid!),
            Text(user.firstname!),
            Text(user.lastname!),
            Text(user.email!),
            Text(user.gender!),
            ToggleFavorite(user: user, onUpdate: _onFavoriteUpdate)
          ],
        ),
      ),
    );
  }
}

class UserDetailsArguments {
  final User user;

  static const routeName = '/users-details';

  UserDetailsArguments({required this.user});
}

class ToggleFavorite extends StatelessWidget {
  const ToggleFavorite({Key? key, required this.user, required this.onUpdate})
      : super(key: key);

  final User user;
  final Function onUpdate;

  void _toggle() {
    var newValue = (user.favorite == true) ? false : true;

    user.favorite = newValue;
    onUpdate(user.favorite);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _toggle(),
      icon: Icon((user.favorite == false)
          ? Icons.favorite_border_outlined
          : Icons.favorite),
      color: Colors.red,
    );
  }
}
