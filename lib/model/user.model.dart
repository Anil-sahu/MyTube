import 'package:blackcoffer/model/video.model.dart';

class UserData {
  String username = "";
  String mobile = "";
  DateTime? createdDate = DateTime.now();
  List<Video>? post;
  UserData(
      {required this.username,
      required this.mobile,
      this.createdDate,
      this.post});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['username'] = username;
    data['mobile'] = mobile;
    data['post'] = post;
    return data;
  }
}
