class User {
  int _id;
  String _name;
  String _email;
  String _age;
  String _password;
  String _babyName;
  String _babyNickname;
  String _babyBirth;

  int get id => _id;

  String get name => _name;

  String get babyBirth => _babyBirth;

  String get babyNickname => _babyNickname;

  String get babyName => _babyName;

  String get password => _password;

  String get age => _age;

  String get email => _email;

  User(this._id, this._name, this._email, this._age, this._password,
      this._babyName, this._babyNickname, this._babyBirth);

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      jsonData['id'],
      jsonData['name'],
      jsonData['email'],
      jsonData['age'],
      jsonData['password'],
      jsonData['baby_name'],
      jsonData['baby_nickname'],
      jsonData['baby_birth'],
    );
  }
}
