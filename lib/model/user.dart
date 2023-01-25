class User{
  const User({required this.name, required this.email});
  final String name;
  final String email;
  static const User emptyUser = User(name: "", email: "");
}