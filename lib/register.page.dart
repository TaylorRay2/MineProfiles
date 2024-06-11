import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _visible = false;

  final txtName = TextEditingController();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<void> register(BuildContext context) async {
    try {
      var credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: txtEmail.text,
        password: txtPassword.text,
      );
      await credential.user!.updateDisplayName(txtName.text);
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.cyan[300],
        // shadowColor: Colors.grey,
        title: const Text("Register"),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: MediaQuery.of(context).size.height - 56,
              child: Container(
                // height: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height - 56,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TextField(
                            controller: txtName,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              hintText: "Name",
                              border: null,
                              // OutlineInputBorder(),
                              // focusedBorder:
                              // OutlineInputBorder(
                              //   borderSide: BorderSide(
                              //     color: Colors.green.shade300.withOpacity(0.25),
                              //     width: 2.0,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TextField(
                            controller: txtEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: "E-mail",
                              border: null,
                              // OutlineInputBorder(),
                              // focusedBorder:
                              // OutlineInputBorder(
                              //   borderSide: BorderSide(
                              //     color: Colors.green.shade300.withOpacity(0.25),
                              //     width: 2.0,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TextField(
                            controller: txtPassword,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !_visible,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: _toggleVisibility,
                                  icon: _visible
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)),
                              hintText: "Password",
                              border: null,
                              // OutlineInputBorder(),
                              // focusedBorder:
                              // OutlineInputBorder(
                              //   borderSide: BorderSide(
                              //     color: Colors.green.shade300.withOpacity(0.25),
                              //     width: 2.0,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 11, 134, 21),
                          ),
                        ),
                        onPressed: () => register(context),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white.withOpacity(1),
                          ),
                        ),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: Text('Sign up'),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
