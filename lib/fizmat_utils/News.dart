class News {
  String? _title;
  String? _subtitle;
  String? _face_image_url;
  String? _photoURL;

  News();

  News.set(
      this._title, this._subtitle, this._face_image_url, this._photoURL);

  String get photoURL => _photoURL!;

  set photoURL(String value) {
    _photoURL = value;
  }

  String get face_image_url => _face_image_url!;

  set face_image_url(String value) {
    _face_image_url = value;
  }

  String get subtitle => _subtitle!;

  set subtitle(String value) {
    _subtitle = value;
  }

  String get title => _title!;

  set title(String value) {
    _title = value;
  }
}
