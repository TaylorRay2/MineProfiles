import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'localizer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();

  Future<void> _signIn(BuildContext context) async {
    try {
      if (((txtPassword.text).length > 0) && ((txtEmail.text).length > 0)) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: txtEmail.text,
          password: txtPassword.text,
        );
        Navigator.of(context).pushReplacementNamed('/list');
      } else if ((txtEmail.text).length > 0) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Digite uma senha')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Preencha os campos')));
      }
    } on FirebaseAuthException catch (e) {
      String message = localizeError(e.code);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.cyan[300],
        // shadowColor: Colors.grey,
        title: const Text("Login"),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          Flexible(
            flex: 3,
            child: Container(
              height: double.maxFinite,
              child: Image.asset(
                'images/MineProfiles.png',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            // padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 240,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextField(
                        controller: txtEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text('E-mail'),
                          hintText: "exemplo@outlook.com",
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green.shade300.withOpacity(0.25),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: txtPassword,
                        keyboardType: TextInputType.visiblePassword,
                        maxLength: 32,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        obscureText: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          label: Text('Senha'),
                          hintText: "caracteres: min 6",
                          border: const OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red.shade300)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green.shade300.withOpacity(0.25),
                              width: 2.0,
                            ),
                          ),
                        ),
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
                          onPressed: () => _signIn(context),
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              color: Colors.white.withOpacity(1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/register");
                          },
                          child: Text(
                            "Não tem uma conta? Crie uma",
                            style: TextStyle(
                                fontSize: 12, color: Colors.green.shade800),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
