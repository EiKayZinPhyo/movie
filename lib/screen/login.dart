import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  // var UserList = ["eikayzin", "12345678"];

  bool _passwordvisible = false;

  var userErrorText = '';
  var passwordErrorText = '';

  void error() {
    if (username.text.isEmpty == true) {
      userErrorText = "Username can't be blank";
    } else {
      userErrorText = '';
    }
    if (password.text.isEmpty == true) {
      passwordErrorText = 'Password can not be blank';
    } else {
      passwordErrorText = '';
    }
  }

  void getLogin() async {
    try {
      final auth = FirebaseAuth.instance;
      final singinemail = await auth.signInWithEmailAndPassword(
          email: username.text, password: password.text);

      print('>>>>>>>>>>');
      print(singinemail);
      Navigator.pushNamed(context, 'moviepage');
    } catch (e) {
      const snackbar = SnackBar(
        backgroundColor: Colors.red,
        content:
            Text('The email or password is Wrong and You need to register '),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    // const snackbar = SnackBar(
    //   backgroundColor: Colors.red,
    //   content: Text('Wrong username and Password ! Or You need to register'),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFfF8EFBA),
      appBar: AppBar(
        backgroundColor: Color(0xFfF8EFBA),
        elevation: 0.0,
        title: const Text(
          "LoginPage",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Image(width: 300, image: AssetImage('assets/microphone.png')),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 100),
              child: Container(
                width: double.infinity,
                child: const Text(
                  "Username",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  errorText: userErrorText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.black)),
                  contentPadding: const EdgeInsets.all(20),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.person,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Enter your username',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: double.infinity,
                child: const Text(
                  "Password",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: password,
                obscureText: !_passwordvisible,
                decoration: InputDecoration(
                  errorText: passwordErrorText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.lock,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Enter your Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordvisible = !_passwordvisible;
                      });
                    },
                    icon: Icon(
                      _passwordvisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'registerpage');
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                      width: double.infinity,
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      )),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    error();
                  });
                  if (username.text.isNotEmpty && password.text.isNotEmpty) {
                    getLogin();
                  }
                  username.clear();
                  password.clear();
                  // else {
                  //   const snackBar = SnackBar(
                  //     backgroundColor: Colors.red,
                  //     content: Text(
                  //       "Invalid username or Password!",
                  //       style: TextStyle(fontSize: 18),
                  //     ),
                  //   );
                  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // }
                  // }
                },
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
