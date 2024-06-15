import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.document});

  DocumentSnapshot document;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/login");
  }

  final user = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    List<String> itemsList = List.from(widget.document['players']);
    List<String> itemsListAdmin = List.from(widget.document['players']);
    playerStatus(String p) {
      List<String> processinglist = p.split(' ');
      print(listEquals(itemsListAdmin, processinglist));
      print(listEquals(processinglist, itemsListAdmin));
      if (listEquals(itemsListAdmin, processinglist)) {
        return 'Admin';
      } else {
        return 'Player';
      }
    }

    List<Widget> ladmin = [
      Expanded(
        flex: 5,
        child: ListView.builder(
          itemCount: (itemsList).length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  // ((items).toList())[index],
                  itemsList[index]),
            );
          },
        ),
      ),
      Expanded(
        flex: 5,
        child: ListView.builder(
          itemCount: (itemsListAdmin).length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  // ((items).toList())[index],
                  itemsListAdmin[index]),
            );
          },
        ),
      ),
    ];
    List<Widget> lplayers = [
      Expanded(
        flex: 5,
        child: ListView.builder(
          itemCount: (itemsList).length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                // ((items).toList())[index],
                itemsList[index],
              ),
              subtitle: Text(playerStatus(itemsList[index])),
            );
          },
        ),
      ),
    ];
    print(itemsList.length);
    adminStatus() {
      if (listEquals(itemsList, itemsListAdmin)) {
        return lplayers;
      } else {
        return ladmin;
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(widget.document['profileName']),
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
      body: Center(child: Column(children: adminStatus())),
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
