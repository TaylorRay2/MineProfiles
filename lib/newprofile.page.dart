import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({super.key});

  @override
  State<NewProfilePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewProfilePage> {
  var txtName = TextEditingController();
  var txtPlayers = TextEditingController();
  var txtAdmin = TextEditingController();

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  Future<void> addProfile(BuildContext context) async {
    try {
      Map<String, dynamic> userProfile = new Map<String, dynamic>();
      userProfile["profileName"] = txtName.text;
      var playersArray = txtPlayers.text.split(',');
      for (var i = 0; i < playersArray.length; i++) {
        playersArray[i].trim();
        if ((playersArray[i] == '') || (playersArray[i] == ' ')) {
          playersArray.removeAt(i);
          playersArray[i] = playersArray[i].trim();
        } else {
          playersArray[i] = playersArray[i].trim();
        }
      }
      userProfile["players"] = playersArray;
      // print(userProfile["players"]);
      var adminsArray = txtAdmin.text.split(',');
      for (var ii = 0; ii < adminsArray.length; ii++) {
        adminsArray[ii].trim();
        if ((adminsArray[ii] == '') || (adminsArray[ii] == ' ')) {
          adminsArray.removeAt(ii);
          adminsArray[ii] = adminsArray[ii].trim();
        } else {
          adminsArray[ii] = adminsArray[ii].trim();
        }
      }
      userProfile["admin"] = adminsArray;
      // print(userProfile["admin"]);
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
        title: const Text("Novo Perfil"),
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
                    label: const Text('Nome do perfil'),
                    hintText: "Nome do jogo ou servidor",
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

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: txtPlayers,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text('Players'),
                    hintText: 'Separados por vírgula',
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

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: txtAdmin,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: const Text('Administradores'),
                    hintText: 'Separados por vírgula',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
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
                      'Adicionar perfil',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                      ),
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
