class User {
  final String email;
  final String? token;

  const User({
    required this.email,
    this.token,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.email == email && other.token == token;
  }

  @override
  int get hashCode => email.hashCode ^ token.hashCode;

  @override
  String toString() => 'User(email: $email, token: ${token ?? 'null'})';
}

