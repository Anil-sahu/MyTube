class Video {
  String title = "";
  
  String videoUrl = "";
  String thumbnail="";
  DateTime? postDate = DateTime.now();
  String description = "";
  String location = "";
  String category = "";
  String userId = "";
  String userName ="";
  List<Views> views = [];
  List<Like> like = [];
  List<Dislike> disLike = [];
  List<Comment> comments = [];
  Video(
      {required this.videoUrl,
     required this.thumbnail,
      required this.title,
      required this.category,
      required this.description,
      required this.userId,
      required this.location,
      required this.userName});

  Video.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
    videoUrl = json['url'];
    thumbnail = json['thumbnail'];
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
    data['thumbnail']=thumbnail;
    data['url'] = videoUrl;
    data['postDate'] = postDate;
    data['username']=userName;
    data['location']=location;
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
    data['comments'] = {
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
  List<Reply> reply =[];
  Comment({required this.username,required this.comment,required this.commentDate});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['comment'] = comment;
    data['username'] = username;
    data['commentDate'] = commentDate;
    data['reply']=reply;
    return data;
  }
}


class Reply{
  String user="";
  String reply="";
  DateTime replayDate =DateTime.now();

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