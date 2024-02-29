import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_user_screen.dart';
import 'edit_user_screen.dart';
import 'user_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final User? user;

  // Constructor updated to accept nullable User object
  const HomeScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return _HomeScreenBody(user);
  }
}

class _HomeScreenBody extends StatefulWidget {
  final User? user;

  const _HomeScreenBody(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // Extract user data from snapshot
                  List<DocumentSnapshot> users = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Extract user details from the document
                      Map<String, dynamic> userData = users[index].data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(userData['name']),
                        subtitle: Text(userData['email']),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editUser(context, users[index].id),
                        ),
                        onTap: () => _viewUserDetails(context, users[index].id),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _addUser(context),
              child: Text('Add User'),
            ),
          ),
        ],
      ),
    );
  }

  void _addUser(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddUserScreen()),
    );
  }

  void _editUser(BuildContext context, String userId) {
    // Navigate to the EditUserScreen with the userId
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserScreen(userId),
      ),
    );
  }

  void _viewUserDetails(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UserDetailsScreen(userId: userId)),
    );
  }
}
