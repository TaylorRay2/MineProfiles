import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({super.key});

  @override
  State<NewProfilePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewProfilePage> {
  final txtName = TextEditingController();
  final txtPlayers = TextEditingController();
  final txtAdmin = TextEditingController();

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  Future<void> addProfile(BuildContext context) async {
    try {
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[600],
        // shadowColor: Colors.grey,
        title: const Text("New Profile"),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Container(
          // height: 260,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: txtName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Profile Name",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green.withOpacity(0.25),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: txtPlayers,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Player name',
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green.withOpacity(0.25),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('New Button'),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: txtPlayers,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Administrators - separated by ","',
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green.withOpacity(0.25),
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
                          Radius.circular(1),
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 11, 134, 21),
                    ),
                  ),
                  onPressed: () => addProfile(context),
                  child: Text(
                    'addProfile',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
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
    );
  }
}
