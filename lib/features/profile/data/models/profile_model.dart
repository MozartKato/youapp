class ProfileModel {
  final String email;
  final String username;
  final String name;
  final String birthday;
  final String horoscope;
  final int height;
  final int weight;
  final List<String> interests;

  ProfileModel({
    required this.email,
    required this.username,
    required this.name,
    required this.birthday,
    required this.horoscope,
    required this.height,
    required this.weight,
    required this.interests,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
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
      'name': name,
      'birthday': birthday,
      'height': height,
      'weight': weight,
      'interests': interests,
    };
  }
}