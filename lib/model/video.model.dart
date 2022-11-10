class Video {
  String title = "";

  String videoUrl = "";
  DateTime? postDate = DateTime.now();
  String description = "";
  String location = "";
  String category = "";
  List<Like> like = [];
  List<Dislike> disLike = [];
  List<Comment> comments = [];
  Video(
      {required this.videoUrl,
      required this.title,
      required this.category,
      required this.description});

  Video.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    videoUrl = json['url'];
    postDate = json['postDate'];
    description = json['description'];
    location = json['location'];
    if (json['like'] != null) {
      like = <Like>[];
      json['like'].forEach((value) {
        like.add(Like.fromJson(json));
      });
    }

    if (json['dislike'] != null) {
      disLike = <Dislike>[];
      json['dislike'].forEach((value) {
        disLike.add(Dislike.fromJson(json));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['url'] = videoUrl;
    data['postDate'] = postDate;
    data['like'] = like;
    data['dislike'] = disLike;
    data['category'] = category;
    data['comment'] = comments;
    return data;
  }
}

class Like {
  bool isLike = false;
  String? username;
  Like({required this.isLike, this.username});
  Like.fromJson(Map<String, dynamic> json) {
    isLike = json['isLike'];
    username = json['username'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['isLike'] = isLike;
    data['username'] = username;
    return data;
  }
}

class Dislike {
  bool isDislike = false;
  String? username;
  Dislike({required this.isDislike, this.username});
  Dislike.fromJson(Map<String, dynamic> json) {
    isDislike = json['isDislike'];
    username = json['username'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['disLike'] = isDislike;
    data['username'] = username;
    return data;
  }
}

class Comment {
  String? username;
  DateTime commentDate = DateTime.now();
  String? comment;
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['comment'] = comment;
    data['username'] = username;
    data['commentDate'] = commentDate;
    return data;
  }
}




  //  onPressed: isPostLiked == true ? () {
  //                               _firestore.collection('posts').document(postID).updateData({'likeCount' : postLikeCount - 1, 'likedBy' : FieldValue.arrayRemove(['${loggedInUser.email}'])});


  //                               isPostLiked = false;
  //                               print('USER HAS UNLIKED THIS POST');

  //                             } : () {
  //                               _firestore.collection('posts').document(postID).updateData({'likeCount' : postLikeCount + 1, 'likedBy' : FieldValue.arrayUnion(['${loggedInUser.email}'])});

  //                               isPostLiked = true;
  //                               print('USER HAS LIKED THIS POST');

  //                             },