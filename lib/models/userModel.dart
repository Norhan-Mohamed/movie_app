class UserModel {
  String? user_name;
  String? email;
  String? password;

  UserModel(this.user_name, this.email, this.password);

  Map<String, dynamic> toMap() {
    return {
      'user_name': user_name,
      'email': email,
      'password': password,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    user_name = map['user_name'];
    email = map['email'];
    password = map['password'];
  }
}
