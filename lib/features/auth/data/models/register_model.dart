class RegisterModel {
  final String message;
  final String accessToken;

  RegisterModel({required this.message, required this.accessToken});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      message: json['message'] ?? '',
      accessToken: json['access_token'] ?? '',
    );
  }
}