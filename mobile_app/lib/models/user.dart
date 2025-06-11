class User {
  final int id;
  final String name;
  final String email;
  final String rol;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.rol,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      rol: json['rol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'rol': rol,
    };
  }
}
