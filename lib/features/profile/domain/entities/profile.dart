class Profile {
  final String email;
  final String username;
  final String name;
  final String birthday;
  final String horoscope;
  final int height;
  final int weight;
  final List<String> interests;

  Profile({
    required this.email,
    required this.username,
    required this.name,
    this.birthday = '',
    this.horoscope = '',
    this.height = 0,
    this.weight = 0,
    this.interests = const [],
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      birthday: json['birthday'] ?? '',
      horoscope: json['horoscope'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      interests: List<String>.from(json['interests'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'name': name,
      'birthday': birthday,
      'horoscope': horoscope,
      'height': height,
      'weight': weight,
      'interests': interests,
    };
  }
}