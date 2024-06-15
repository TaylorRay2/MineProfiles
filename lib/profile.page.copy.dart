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
  String pName = '';
  Future<void> getName() async {
    Stream snap = await firestore
        .collection('user_profile')
        .doc(widget.profID)
        .get(GetOptions(source: Source.server))
        .asStream();
    snap.map((event) => null);
  }

  testdoc(var i) {
    print(i);
    print(
        firestore.collection('user_profiles').doc(i).get().then((value) async {
      await value.data()?['profileName'];
    }));
    return 'test';
  }

  playerStatus(player, List admin) {
    var status;
    if (admin.contains(player)) {
      status = 'Administrador';
    } else {
      status = 'Player';
    }

    return status;
  }

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/login");
  }

  final user = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var players = firestore
        .collection('user_profile')
        .doc(widget.profID)
        .collection('players')
        .snapshots();
    var admins = firestore
        .collection('user_profile')
        .doc(widget.profID)
        .collection('admin')
        .snapshots();
    var snap = firestore
        .collection('user_profiles')
        .doc(widget.profID)
        .get()
        .asStream()
        .first
        .toString();
    //     .then((value) {
    //   var v = value.data();

    //   pName = v?['profileName'];
    //   print(v?['profileName']);
    // });

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(pName),
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
      body: Center(
        child: Column(
          children: [
            Text(testdoc(widget.profID)),
          ],
        ),
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
