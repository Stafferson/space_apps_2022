class UserFiz {
  String? name;
  String? email;
  String? fcmToken;
  String? photoURL;
  int? forumCount;

  UserFiz();

  UserFiz.set(
      this.name, this.email, this.fcmToken, this.photoURL, this.forumCount) {}

  String? getName() {
    return name;
  }

  void setName(String? name) {
    this.name = name;
  }

  String? getEmail() {
    return email;
  }

  void setEmail(String? email) {
    this.email = email;
  }

  String? getFcmToken() {
    return fcmToken;
  }

  void setFcmToken(String? fcmToken) {
    this.fcmToken = fcmToken;
  }

  int? getForumCount() {
    return forumCount;
  }

  void setForumCount(int? forumCount) {
    this.forumCount = forumCount;
  }

  String? getPhotoURL() {
    return photoURL;
  }

  UserFiz setPhotoURL(String? photoURL) {
    this.photoURL = photoURL;
    return this;
  }

  Map<String, Object?> toJson() => {
        'email': email,
        'name': name,
        'photoURL': photoURL,
        'fcmToken': fcmToken,
        'forumCount': forumCount
      };

  factory UserFiz.fromJson(Map<String, dynamic> json) => UserFiz.set(
      json['name'],
      json['email'],
      json['fcmToken'],
      json['photoURL'],
      json['forumCount']);
}
