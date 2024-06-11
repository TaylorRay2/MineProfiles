import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mineprofiles/list.page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key, this.profile});

  final profile;

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/login");
  }

  final user = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("${user.displayName} Task list"),
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
          stream: firestore
              .collection('user_profile')
              .where('user', arrayContains: user.uid)
              .where('profileID', isEqualTo: profile)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            dynamic docs = snapshot.data!.docs;

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
                        },
                        child: ListTile(
                          title: Text(doc['players']),
                          subtitle: Text(doc['desc']),
                          onTap: () => print(doc),
                        ),
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
