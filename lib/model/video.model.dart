class Video {
  String title = "";

  String videoUrl = "";
  DateTime? postDate = DateTime.now();
  String description = "";
  String location = "";
  String category = "";
  String userId = "";
  List<Views> views = [];
  List<Like> like = [];
  List<Dislike> disLike = [];
  List<Comment> comments = [];
  Video(
      {required this.videoUrl,
      required this.title,
      required this.category,
      required this.description,
      required this.userId});

  Video.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
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
    data['userId'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['url'] = videoUrl;
    data['postDate'] = postDate;
    data['like'] = {
      "countLike": 0,
      "user": like,
    };
    data['views']={
      "countView":0,
      "user":views

    };
    data['dislike'] = {
      "countDislike": 0,
      "user": disLike,
    };
    data['category'] = category;
    data['comment'] = {
      "countComment": 0,
      "user": comments,
    };
    return data;
  }
}

class Like {
  String? username;
  Like({required this.username});
  Like.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    data['username'] = username;
    return data;
  }
}

class Dislike {
  String? username;
  Dislike({required this.username});
  Dislike.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    data['username'] = username;
    return data;
  }
}

class Views {
  String user = "";
  
  Views({required this.user});
  
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