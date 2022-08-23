import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  void saveData() async {
    try {
      final auth = FirebaseAuth.instance;
      final newemail = await auth.createUserWithEmailAndPassword(
          email: username.text, password: password.text);
      print('>>>>>>>>>>');
      print(newemail);
      Navigator.pushNamed(context, 'loginpage');
    } catch (e) {
      const snackbar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('The email address is already  use by another account'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFfF8EFBA),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'firstpage');
          },
        ),
        backgroundColor: Color(0xFfF8EFBA),
        elevation: 0.0,
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 100),
              child: Container(
                width: double.infinity,
                child: const Text(
                  "Enter your email address",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  fillColor: Colors.black,
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
                  errorText: userErrorText,
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
            Container(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    error();
                    if (username.text.isNotEmpty && password.text.isNotEmpty) {
                      saveData();
                    }
                    username.clear();
                    password.clear();
                  });
                },
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: const Text(
                  "Register",
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
