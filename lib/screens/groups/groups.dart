// group_list_page.dart
import 'package:flutter/material.dart';
import 'indigrp.dart';

class GroupListPage extends StatelessWidget {
  final List<String> groups = ['Tours', 'Study', 'Work'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community')),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                groups[index],
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.red),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndividualGroupPage(groupName: groups[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
