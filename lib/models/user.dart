import '../string_utils.dart';

enum LoginType { email, phone }

class User {
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    print('User is created');
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  User.__(String name) {
    this._lastName = name;
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception('User name is empty');
    if ((phone == null || phone.isEmpty) && (email == null || email.isEmpty))
      throw Exception('Phone or email is empty');

    User user = User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: phone != null ? checkPhone(phone) : null,
        email: email != null ? checkEmail(email) : null);

    return user;
  }

  static _getFirstName(String name) {
    return name.split(' ')[0];
  }

  static _getLastName(String name) {
    return name.split(' ')[1];
  }

  static checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";

    phone = phone.replaceAll(RegExp("[^+\\d]"), '');

    if (phone == null || phone.isEmpty) {
      throw Exception("Enter don't empty phone");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          "Enter valid phone number staring with a + and containing 11 digits");
    }

    return phone;
  }

  static checkEmail(String email) {
    String pattern =
    r"""(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])""";
    if (email == null || email.isEmpty) {
      throw Exception("Enter don't empty phone number");
    } else if (!RegExp(pattern).hasMatch(email)) {
      throw Exception(
          "Enter valid email");
    }

    return email;
  }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name => "${"".capitalize(_firstName)} ${"".capitalize(_lastName)}";

  @override
  bool operator ==(Object object) {
    if (object == null) {
      return false;
    }
    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }
  }

  void addFriend(Iterable<User> newFriend) {
    friends.addAll(newFriend);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userInfo => '''
    name: $name
    email: $email
    firstName: $_firstName
    lastName: $_lastName
    friends: ${friends.toList()}
    \\n
  ''';

  @override
  String toString() {
    return """
    '
    name: $name,
    email: $email,
    friends: ${friends.toList()}
    """;
  }
}
