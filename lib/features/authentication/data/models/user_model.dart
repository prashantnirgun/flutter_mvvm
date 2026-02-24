import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  final bool success;
  final String message;
  //final List<UserModel> data;
  final UserModel? data;

  const UserDataModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          // (json['data'] as List<dynamic>?)
          //     ?.map((e) => UserModel.fromJson(e))
          //     .toList() ??
          // [],
          json['data'] != null ? UserModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      //'data': data.map((e) => e.toJson()).toList(),
      'data': data?.toJson(), // ✅ single object
    };
  }

  @override
  List<Object?> get props => [success, message, data];
}

class UserModel extends Equatable {
  final int id;
  final String fullName;
  final String userName;
  final String email;
  final String mobile;
  final String userStatus;
  final String uuid;
  final String session;
  final String userGroupName;
  final String emailVerified;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.mobile,
    required this.userStatus,
    required this.uuid,
    required this.session,
    required this.userGroupName,
    required this.emailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      userName: json['user_name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      userStatus: json['user_status'] ?? '',
      uuid: json['uuid'] ?? '',
      session: json['session'] ?? '',
      userGroupName: json['user_group_name'] ?? '',
      emailVerified: json['email_verified'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'mobile': mobile,
      'user_status': userStatus,
      'uuid': uuid,
      'session': session,
      'user_group_name': userGroupName,
      'email_verified': emailVerified,
    };
  }

  @override
  List<Object?> get props => [id, uuid, fullName, userName, email];
}
