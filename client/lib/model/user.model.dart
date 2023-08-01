class User {
  final String id;
  final String email;
  final String displayName;
  final String username;
  final String birthday;
  final String createdAt;
  final String profilePic;
  final String status;

  User(
      {required this.id,
      required this.email,
      required this.displayName,
      required this.username,
      required this.birthday,
      required this.createdAt,
      required this.profilePic,
      required this.status});
}
