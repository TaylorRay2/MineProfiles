import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'localizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _visible = false;
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<void> _signIn(BuildContext context) async {
    try {
      if (((txtPassword.text).isNotEmpty) && ((txtEmail.text).isNotEmpty)) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: txtEmail.text.trim(),
          password: txtPassword.text.trim(),
        );
        Navigator.of(context).pushReplacementNamed('/list');
      } else if ((txtEmail.text).isNotEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Digite uma senha')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Preencha os campos')));
      }
    } on FirebaseAuthException catch (e) {
      String message = localizeError(e.code);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            child: SizedBox(
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: txtEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            label: const Text('E-mail'),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: txtPassword,
                          keyboardType: TextInputType.visiblePassword,
                          maxLength: 32,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          obscureText: !_visible,
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            label: const Text('Senha'),
                            hintText: "Digite sua senha",
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: _toggleVisibility,
                                icon: _visible
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green.shade300.withOpacity(0.25),
                                width: 2.0,
                              ),
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
