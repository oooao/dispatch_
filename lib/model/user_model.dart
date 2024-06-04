import 'package:dispatch/util/common.dart';

class UserModel {
  String user_id;
  String password;
  String name;
  String email;
  String role;
  String phone;
  String city;
  String address;
  String about;
  String area;
  String avatar;
  String photo;
  int point;
  int status;
  bool validity;
  String token;
  String birthday;
  String attachment;
  String attachment2;

  UserModel({
    this.user_id = "",
    this.name = "",
    this.password = "",
    this.email = "",
    this.role = "",
    this.phone = "",
    this.city = "",
    this.address = "",
    this.about = "",
    this.avatar = "",
    this.photo = "",
    this.area = "",
    this.point = 0,
    this.status = 0,
    this.validity = false,
    this.token = "",
    this.birthday = "",
    this.attachment = "",
    this.attachment2 = "",
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      user_id: data['user_id'] ?? "",
      name: data['name'] ?? "",
      password: data['password'] ?? "",
      email: data['email'] ?? "",
      role: data['role'] ?? "",
      avatar: data['avatar'] ?? "",
      phone: data['phone'] ?? "",
      city: data['city'] ?? "",
      address: data['address'] ?? "",
      about: data['about'] ?? "",
      photo: data['photo'] ?? "",
      area: data['area'] ?? "",
      point: int.tryParse(data['point']) ?? 0,
      status: int.tryParse(data['status']) ?? 0,
      validity: data['validity'] ?? false,
      token: data['token'] ?? "",
      birthday: data['birthday'] ?? "",
      attachment: data['attachment'] ?? "",
      attachment2: data['attachment2'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "password": password,
      "user_id": user_id,
      "name": name,
      "email": email,
      "role": role,
      "avatar": avatar,
      "phone": phone,
      "city": city,
      "area": area,
      "address": address,
      "about": about,
      "photo": photo,
      'status': status,
      'validity': validity,
      'token': token,
      'birthday': birthday,
      'attachment': attachment,
      'attachment2': attachment2
    };
  }

  bool isDesigner() {
    return role == DESIGNER;
  }

  bool isWorker() {
    return role == WORKER;
  }

  bool isCustomer() {
    return role == CUSTOMER;
  }
}
