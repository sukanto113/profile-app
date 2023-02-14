class User{
  const User({required this.name, required this.email});
  final String name;
  final String email;

  @override
  bool operator == (Object other) =>
    other is User &&
    other.name == name &&
    other.email == email;

  @override
  int get hashCode => Object.hash(name, email);
}