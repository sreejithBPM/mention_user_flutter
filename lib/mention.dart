import 'package:flutter/material.dart';

class UserSelectionPage extends StatefulWidget {
  @override
  _UserSelectionPageState createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> _users = ["John", "Jane", "Doe", "Alice", "Bob"];
  List<String> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _filteredUsers = [];
  }

  void _updateFilteredUsers(String input) {
    setState(() {
      if (input.isNotEmpty && input.startsWith('@')) {
        // Filter users based on the input after '@'
        String filter = input.substring(1).toLowerCase();
        _filteredUsers = _users
            .where((user) => user.toLowerCase().contains(filter))
            .toList();
      } else {
        _filteredUsers = [];
      }
    });
  }

  void _selectUser(String user) {
    setState(() {
      _textEditingController.text = '@$user ';
      _filteredUsers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            onChanged: (input) {
              _updateFilteredUsers(input);
            },
            decoration: InputDecoration(
              hintText: 'Type @ to mention a user',
            ),
          ),
          if (_filteredUsers.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _filteredUsers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredUsers[index]),
                    onTap: () {
                      // Handle user selection
                      _selectUser(_filteredUsers[index]);
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}