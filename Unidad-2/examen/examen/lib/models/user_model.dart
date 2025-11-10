class UserModel {
  final String username;
  final String email;
  final String avatar;

  UserModel({
    required this.username,
    required this.email,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json['username'] ?? '',
        email: json['email'] ?? '',
        avatar: json['avatar'] ??
            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'avatar': avatar,
      };
}
