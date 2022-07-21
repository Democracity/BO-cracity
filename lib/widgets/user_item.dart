import 'package:bo_cracity/services/user.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text("${user.username} ${user.mail}"),
      subtitle: Text(user.password!),
    );
  }
}
