import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';
import '../../../infrastructure/repositories/firestore.dart';

class ProfileEditor extends StatefulWidget {
  const ProfileEditor({
    super.key,
    required this.userRepository,
    required this.profile,
  });

  final FirestoreRepository<User> userRepository;
  final User profile;

  @override
  State<ProfileEditor> createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<ProfileEditor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _usernameController.text = widget.profile.username;
    _emailController.text = widget.profile.email;

    return Column(
      children: <Widget>[
        Text('Edit profile'),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: <Widget>[
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(hintText: 'Username'),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final User profile = User(
                id: widget.profile.id,
                username: _usernameController.text,
                email: _emailController.text,
              );
              widget.userRepository.setOrAdd('FN6UP0zZc3OrWDjPFJ52', profile);
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
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
