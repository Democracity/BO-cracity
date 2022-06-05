import 'package:bo_cracity/create_account.dart';
import 'package:flutter/material.dart';
import 'package:bo_cracity/create_account.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.pinkAccent,
                Colors.purpleAccent.shade700
              ]
          )

      ),
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
                  const Text("LOGIN"),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withAlpha(40),
                        borderRadius: BorderRadius.circular(8),


                    ),
                      child: const Padding(
                        padding: EdgeInsets.only(left:8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              icon: Icon(Icons.email_outlined)
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withAlpha(40),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left:8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              icon: Icon(Icons.lock_open)
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),

                  Padding(
                    padding: const EdgeInsets.only(right:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [Text("Forgot password?")],
                    ),
                  ),

                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.pink
                      ),
                      child: FlatButton(
                        onPressed: ()async{

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical:4),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("LOGIN"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40,),

                  Padding(
                    padding: const EdgeInsets.only(right:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Do not have an account? "),
                        GestureDetector(
                            onTap:
                                  () => _goToCreateAccount(context),

                            child: const Text("Sign up here. ")),
                      ],
                    ),
                  ),

                ],
              ),
            ),

        ),
      ),
    );
  }
}

void _goToCreateAccount(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => const CreateAccount(),
    ),
  );
}

