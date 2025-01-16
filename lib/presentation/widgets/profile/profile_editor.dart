import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileEditor extends StatefulWidget {
  const ProfileEditor({super.key, required this.user});

  final User user;

  @override
  State<ProfileEditor> createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<ProfileEditor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    _nameController.text = user.displayName ?? "";
    _emailController.text = user.email ?? "";

    return Column(
      children: <Widget>[
        Text('Edit profile', style: Theme.of(context).textTheme.titleLarge),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: 'Username'),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (_nameController.text != "") {
                user.updateProfile(displayName: _nameController.text);
              }

              if (_emailController.text != "") {
                // ignore: deprecated_member_use
                user.updateEmail(_emailController.text);
              }

              if (_passwordController.text != "") {
                user.updatePassword(_passwordController.text);
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Saved profile!')),
              );

              return;
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed validating input!')),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
