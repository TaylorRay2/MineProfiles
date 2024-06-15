import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({super.key});

  @override
  State<NewProfilePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewProfilePage> {
  bool _blacklist = false;

  var txtName = TextEditingController();
  var txtPlayers = TextEditingController();
  var txtAdmin = TextEditingController();

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length,
      (_) => 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'
          .codeUnitAt(Random().nextInt(
              'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'
                  .length))));

  Future<void> addProfile(BuildContext context) async {
    try {
      Map<String, dynamic> userProfile = <String, dynamic>{};
      var playersArray = [];
      var adminsArray = [];
      if (((txtName.text).isNotEmpty) &&
          ((txtPlayers.text).isNotEmpty) &&
          ((txtAdmin.text).isNotEmpty)) {
        userProfile["profileID"] = getRandomString(12);
        userProfile["profileName"] = txtName.text;

        //user data
        userProfile["users"] = [
          FirebaseAuth.instance.currentUser!.uid,
        ];

        //players
        if ((txtPlayers.text).contains(',')) {
          var playersArray = txtPlayers.text.split(',');
          for (var i = 0; i < playersArray.length; i++) {
            playersArray[i].trim();
            if ((playersArray[i].isEmpty) || (playersArray[i] == ' ')) {
              playersArray.removeAt(i);
              playersArray[i] = playersArray[i].trim();
            } else {
              playersArray[i] = playersArray[i].trim();
            }
          }
          userProfile["players"] = playersArray;
        } else {
          playersArray = [txtPlayers.text];
          userProfile["players"] = playersArray;
        }

        //Admins
        if ((txtAdmin.text).contains(',')) {
          adminsArray = txtAdmin.text.split(',');
          for (var ii = 0; ii < adminsArray.length; ii++) {
            adminsArray[ii].trim();
            if ((adminsArray[ii].isEmpty) || (adminsArray[ii] == ' ')) {
              adminsArray.removeAt(ii);
              adminsArray[ii] = adminsArray[ii].trim();
            } else {
              adminsArray[ii] = adminsArray[ii].trim();
            }
          }
          userProfile["admin"] = adminsArray;
        } else {
          adminsArray = [txtAdmin.text];
          userProfile["admin"] = adminsArray;
        }

        //blacklist
        userProfile["blacklist"] = _blacklist;

        //create
        await FirebaseFirestore.instance
            .collection('user_profile')
            .add(userProfile);
        // ignore: use_build_context_synchronously
        Navigator.of(context).maybePop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Um ou mais campos estão vazios')));
      }
      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[600],
        // shadowColor: Colors.grey,
        title: const Text("Criar um novo perfil"),
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
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
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
                    label: const Text('Players'),
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
                  child: Row(children: [
                    Flexible(
                      flex: 2,
                      child: CheckboxListTile(
                        title: const Text('Blacklist'),
                        value: _blacklist,
                        onChanged: (value) {
                          setState(() {
                            _blacklist = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
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
                  ]),
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
