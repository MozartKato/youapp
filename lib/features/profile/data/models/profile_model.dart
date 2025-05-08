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
    final data = json['data'] as Map<String, dynamic>; // Ambil field 'data'
    return ProfileModel(
      email: data['email'] ?? '',
      username: data['username'] ?? '',
      name: data['name'] ?? '',
      birthday: data['birthday'] ?? '',
      horoscope: data['horoscope'] ?? '',
      height: (data['height'] ?? 0) as int,
      weight: (data['weight'] ?? 0) as int,
      interests: (data['interests'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'email': email,
        'username': username,
        'name': name,
        'birthday': birthday,
        'horoscope': horoscope,
        'height': height,
        'weight': weight,
        'interests': interests,
      },
    };
  }
}