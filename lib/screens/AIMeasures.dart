import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_go/constants.dart';

class CommunitySolutionsScreen extends StatefulWidget {
  @override
  _CommunitySolutionsScreenState createState() =>
      _CommunitySolutionsScreenState();
}

class _CommunitySolutionsScreenState extends State<CommunitySolutionsScreen> {
  Map<String, dynamic>? solutions;
  bool isLoading = false;
String sol="";
  Future<void> fetchCommunitySolutions() async {
    setState(() {
      isLoading = true;
    });
    // Update with actual API URL

    final response = await http.post(
      Uri.parse('$url/suggest_community_measures'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "problem_description": "Garbage accumulation in public parks",
        "location": "Mumbai, India",
        "urgency_level": "High"
      }),
    );

    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      setState(() {

        sol=response.body.toString();
        //solutions = jsonDecode(response.body)["community_solutions"];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCommunitySolutions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Community Solutions")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
           children: [Text(sol)],
          // children: [
          //   Text("Engagement Ideas",
          //       style: TextStyle(
          //           fontSize: 18, fontWeight: FontWeight.bold)),
          //   ...List.generate(
          //     sol!["community_engagement_ideas"].length,
          //         (index) => ListTile(
          //       leading: Icon(Icons.people, color: Colors.blue),
          //       title: Text(
          //           sol!["community_engagement_ideas"][index]),
          //     ),
          //   ),
          //   SizedBox(height: 10),
          //   Text("Proposed Solutions",
          //       style: TextStyle(
          //           fontSize: 18, fontWeight: FontWeight.bold)),
          //   ...solutions!["solutions"].map<Widget>((solution) {
          //     return Card(
          //       elevation: 3,
          //       margin: EdgeInsets.symmetric(vertical: 5),
          //       child: ListTile(
          //         title: Text(solution["measure"],
          //             style: TextStyle(fontWeight: FontWeight.bold)),
          //         subtitle: Text(solution["details"]),
          //       ),
          //     );
          //   }).toList(),
          //   SizedBox(height: 10),
          //   Text("Twitter Suggestion",
          //       style: TextStyle(
          //           fontSize: 18, fontWeight: FontWeight.bold)),
          //   ListTile(
          //     leading: Icon(Icons.link, color: Colors.blue),
          //     title: Text(solutions!["twitter_suggestion"],
          //         style: TextStyle(color: Colors.blue)),
          //     onTap: () {
          //       // Open Twitter link if needed
          //     },
          //   ),
          // ],
        ),
      ),
    );
  }
}