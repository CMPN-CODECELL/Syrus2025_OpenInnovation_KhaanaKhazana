// individual_group_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../trip_planner.dart';

class IndividualGroupPage extends StatefulWidget {
  final String groupName;
  IndividualGroupPage({required this.groupName});

  @override
  _IndividualGroupPageState createState() => _IndividualGroupPageState();
}

class _IndividualGroupPageState extends State<IndividualGroupPage> {
  final TextEditingController messageController = TextEditingController();

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('groups').doc(widget.groupName).collection('messages').add({
        'text': messageController.text,
        'sender': 'User123', // Replace with actual user ID
        'timestamp': FieldValue.serverTimestamp(),
      });
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        actions: [
          IconButton(
            icon: Icon(Icons.airplanemode_active),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TripPlannerPage()),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('groups')
                  .doc(widget.groupName)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                return ListView(
                  reverse: true,
                  children: snapshot.data!.docs.map((doc) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          doc['text'],
                          style: TextStyle(color: Colors.red),
                        ),
                        subtitle: Text(doc['sender']),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: messageController,
              style: TextStyle(color: Colors.red),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintStyle: TextStyle(color: Colors.red),
                hintText: "Type your response...",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (value) => sendMessage(),
            ),
          ),
        ],
      ),
    );
  }
}
