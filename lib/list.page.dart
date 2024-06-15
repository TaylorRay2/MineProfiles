// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mineprofiles/profile.page.dart';

class Profile {
  String profile;

  Profile(this.profile);
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/login");
  }

  void _openProfile(BuildContext context, dynamic reference) {
    Navigator.of(context).pushNamed('/profile');
  }

  final user = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // args.profile = ;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[600],
        title: Text("Perfis de ${user.displayName}"),
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('user_profile')
              .where('users', arrayContains: user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Image.asset(
                'images/emptyProfiles.png',
                fit: BoxFit.contain,
              );
            }

            var docs = snapshot.data!.docs;
            // var players = docs.map((doc) => doc['players']);

            return ListView(
                children: docs
                    .map(
                      (doc) => Dismissible(
                        direction: DismissDirection.startToEnd,
                        key: Key(doc.id),
                        background: Container(
                          color: Colors.red[300],
                        ),
                        onDismissed: (_) {
                          doc.reference.delete();
                          setState(() {});
                        },
                        child: ListTile(
                            title: Text(doc['profileName']),
                            subtitle: Text(
                                '${((doc['players']).length)} Players, ${(doc['admin']).length} administradores'),
                            // Text((doc['players'].toString())
                            // .replaceAll(RegExp(r'\[|\]'), '')),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                    document: doc,
                                  ),
                                ),
                              );
                            }
                            // {_openProfile(context, doc.reference.id)},
                            ),
                      ),
                    )
                    .toList());
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[100],
        onPressed: () => Navigator.of(context).pushNamed("/newprofile"),
        child: const Icon(Icons.app_registration_outlined),
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
