class UserExistsModel {
  final bool exists;

  UserExistsModel({required this.exists});

  factory UserExistsModel.fromJson(Map<String, dynamic> json) {
    // Map the JSON response to the model. Adjust key names to match API.
    return UserExistsModel(exists: json['exists'] as bool);
  }

  Map<String, dynamic> toJson() => {'exists': exists};
}
