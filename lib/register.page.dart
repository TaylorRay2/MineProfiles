import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'localizer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _visibleP = false;
  bool _visibleC = false;

  final txtName = TextEditingController();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  final txtConfirm = TextEditingController();

  void _toggleVisibilityP() {
    setState(() {
      _visibleP = !_visibleP;
    });
  }

  void _toggleVisibilityC() {
    setState(() {
      _visibleC = !_visibleC;
    });
  }

  Future<void> register(BuildContext context) async {
    try {
      if (txtPassword.text == txtConfirm.text) {
        var credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: txtEmail.text.trim(),
          password: txtPassword.text.trim(),
        );
        await credential.user!.updateDisplayName(txtName.text);
        await FirebaseAuth.instance.signOut();
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('O conteúdo da senha não é o mesmo que o da confirmação'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = localizeError(e.code);
      // ignore: use_build_context_synchronously
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
              height: MediaQuery.of(context).size.height - 100,
              child: Container(
                // height: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height - 100,
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
                              label: const Text('Nome'),
                              hintText: "Digite seu nome",
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
                              label: const Text('E-mail'),
                              hintText: "Digite seu e-mail",
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
                            maxLength: 32,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            obscureText: !_visibleP,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: _toggleVisibilityP,
                                  icon: _visibleP
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              label: const Text('Senha'),
                              hintText: "Digite sua senha",
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
                            controller: txtConfirm,
                            keyboardType: TextInputType.visiblePassword,
                            maxLength: 32,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            obscureText: !_visibleC,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: _toggleVisibilityC,
                                  icon: _visibleC
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              label: const Text('Confirme sua senha'),
                              hintText: "Digite novamente a sua senha",
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
