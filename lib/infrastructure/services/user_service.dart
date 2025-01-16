import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  String get currentUserId => FirebaseAuth.instance.currentUser!.uid;
}
