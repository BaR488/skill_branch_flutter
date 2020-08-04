import 'models/user.dart';
import 'models/user.dart';
import 'models/user.dart';
import 'models/user.dart';
import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  User registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    print(user.toString());

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception('A user with this name already exist');
    }

    return user;
  }

  User getUserByLogin(String login) {
    return this.users[login];
  }

  User registerUserByEmail(String name, String email) {
    return registerUser(name, null, email);
  }

  User registerUserByPhone(String name, String phone) {
    return registerUser(name, phone, null);
  }

  void setFriends(String login, List<User> friends) {
    this.getUserByLogin(login)?.addFriend(friends);
  }

  User findUserInFriends(String login, User friend) {
    var users = this
        .getUserByLogin(login)
        .friends
        .where((element) => element == friend);

    if (users.isEmpty) {
      throw Exception("${friend.login} is not a friend of the login");
    }

    return users.first;
  }

  List<User> importUsers(List<String> list) {
    list.forEach((element) {
      List<String> lines = element.trim().split(';');
      registerUser(lines[0].trim(), lines[2].trim(), lines[1].trim());
    });
    return users.values.toList();
  }
}
