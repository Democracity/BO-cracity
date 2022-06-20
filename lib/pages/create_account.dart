import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/user.dart';
import 'login.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

Future<User> createAccount(
    String mail, String username, String password, String role) async {
  var response = await http.post(Uri.parse('https://democracity-api.herokuapp.com/user'),
      body: {
    "mail": mail,
    "username": username,
    "password": password,
    "role": role,
  });
  var data = response.body;
  print("OKKKKK");
  print(data);

  if (response.statusCode == 200) {
    String responseString = response.body;
  } else {
    throw Exception('Failed to create album.');
  }
  throw Exception('Failed to create album.');
}

class _CreateAccountState extends State<CreateAccount> {
  late User _userModel;
  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.purpleAccent.shade700])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(8),
            ),
            height: 400,
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("CREATE ACCOUNT"),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(40),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            icon: Icon(Icons.email_outlined)),
                        controller: mailController,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(40),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Username',
                            icon: Icon(Icons.account_circle_rounded)),
                        controller: usernameController,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(40),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            icon: Icon(Icons.lock_open)),
                        controller: passwordController,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.pink),
                    child: ElevatedButton(
                      onPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Votre compte a bien été crée"))
                        );
                        _goToLogin(context);
                        String mail = mailController.text;
                        String username = usernameController.text;
                        String password = passwordController.text;
                        String role = "1";

                        User data =
                            await createAccount(mail, username, password, role);

                        setState(() {
                          _userModel = data;

                        });

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("CREATE ACCOUNT"),
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _goToLogin(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => const Login(),
    ),
  );
}
