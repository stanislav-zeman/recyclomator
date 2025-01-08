import '../../domain/entities/user.dart';

class MockUserService {
  User getUser() {
    return User(id: 'cpiYF4Jxk6d4egtN9dc0ABzKs3E2', username: 'John Doe', email: 'john@mail.com');
  }

  User getRecycler() {
    return User(id: '2', username: 'Jan Novak', email: 'novak@mail.com');
  }
}
