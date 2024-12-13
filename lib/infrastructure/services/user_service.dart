import '../../domain/entities/user.dart';

class MockUserService {
  User getUser() {
    return User(id: '1', username: 'John Doe', email: 'john@mail.com');
  }

  User getRecycler() {
    return User(id: '2', username: 'Jan Novak', email: 'novak@mail.com');
  }
}
