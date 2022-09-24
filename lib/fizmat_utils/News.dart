class News {
  String? _title;
  String? _subtitle;
  String? _face_image_url;
  String? URL;

  News(String news_title, String news_subtitle, String news_face_image_url, String news_URL) {
    this._title = news_title;
    this._subtitle = news_subtitle;
    this._face_image_url = news_face_image_url;
    this.URL = news_URL;
  }

  News.set(
      this._title, this._subtitle, this._face_image_url, this.URL);

  get photoURL {
    return this._face_image_url;
  }

  get title {
    return this._title;
  }

  get subtitle {
    return this._subtitle;
  }

  get url {
    return this.URL;
  }
}
