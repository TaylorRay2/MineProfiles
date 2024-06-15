import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mineprofiles/list.page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.profID});

  String profID;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  testdoc(var i) {
    print(i.length);
    return 1;
  }

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/login");
  }

  final user = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;
  playerStatus(String player, String admin) {
    String value;
    if (player == admin) {
      value = 'Administrador';
    } else {
      value = 'Player';
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    var players = firestore
        .collection('user_profile')
        .doc(widget.profID)
        .collection('players')
        .snapshots();
    var snap = firestore
        .collection('user_profile')
        .where('users', arrayContains: user.uid)
        .where('profileID', isEqualTo: widget.profID)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(''),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(255, 206, 206, 206),
                  Color.fromARGB(255, 255, 255, 255)
                ]),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: snap,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            dynamic docs = snapshot.data?.docs;

            return Column(
                children: docs
                    .map<Widget>(
                      (doc) => Column(
                        children: [
                          Text(doc['profileName']),
                          ListView.builder(
                              itemCount: testdoc(doc['players']),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(doc['players'][index]),
                                );
                              }),
                        ],
                      ),
                    )
                    .toList());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/newtask"),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ListTile(
              //   title: Text("Task 1"),
              //   subtitle: Text("Alta"),
              //   leading: CircleAvatar(),
              //   trailing: Checkbox(
              //     shape: CircleBorder(),
              //     value: false,
              //     onChanged: (_) => print("Task 1"),
              //   ),
              // ),
