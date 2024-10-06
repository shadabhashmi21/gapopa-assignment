class PixabayResponse {

  PixabayResponse({
    this.total,
    this.totalHits,
    this.hits,
  });

  PixabayResponse.fromJson(final Map<String, dynamic> json)
      : total = json['total'] as int?,
        totalHits = json['totalHits'] as int?,
        hits = (json['hits'] as List?)?.map((final dynamic e) => Hits.fromJson(e as Map<String,dynamic>)).toList();
  final int? total;
  final int? totalHits;
  final List<Hits>? hits;

  Map<String, dynamic> toJson() => {
    'total' : total,
    'totalHits' : totalHits,
    'hits' : hits?.map((final e) => e.toJson()).toList(),
  };
}

class Hits {

  Hits({
    this.id,
    this.pageURL,
    this.type,
    this.tags,
    this.previewURL,
    this.previewWidth,
    this.previewHeight,
    this.webformatURL,
    this.webformatWidth,
    this.webformatHeight,
    this.largeImageURL,
    this.imageWidth,
    this.imageHeight,
    this.imageSize,
    this.views,
    this.downloads,
    this.collections,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageURL,
  });

  Hits.fromJson(final Map<String, dynamic> json)
      : id = json['id'] as int?,
        pageURL = json['pageURL'] as String?,
        type = json['type'] as String?,
        tags = json['tags'] as String?,
        previewURL = json['previewURL'] as String?,
        previewWidth = json['previewWidth'] as int?,
        previewHeight = json['previewHeight'] as int?,
        webformatURL = json['webformatURL'] as String?,
        webformatWidth = json['webformatWidth'] as int?,
        webformatHeight = json['webformatHeight'] as int?,
        largeImageURL = json['largeImageURL'] as String?,
        imageWidth = json['imageWidth'] as int?,
        imageHeight = json['imageHeight'] as int?,
        imageSize = json['imageSize'] as int?,
        views = json['views'] as int?,
        downloads = json['downloads'] as int?,
        collections = json['collections'] as int?,
        likes = json['likes'] as int?,
        comments = json['comments'] as int?,
        userId = json['user_id'] as int?,
        user = json['user'] as String?,
        userImageURL = json['userImageURL'] as String?;

  final int? id;
  final String? pageURL;
  final String? type;
  final String? tags;
  final String? previewURL;
  final int? previewWidth;
  final int? previewHeight;
  final String? webformatURL;
  final int? webformatWidth;
  final int? webformatHeight;
  final String? largeImageURL;
  final int? imageWidth;
  final int? imageHeight;
  final int? imageSize;
  final int? views;
  final int? downloads;
  final int? collections;
  final int? likes;
  final int? comments;
  final int? userId;
  final String? user;
  final String? userImageURL;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'pageURL' : pageURL,
    'type' : type,
    'tags' : tags,
    'previewURL' : previewURL,
    'previewWidth' : previewWidth,
    'previewHeight' : previewHeight,
    'webformatURL' : webformatURL,
    'webformatWidth' : webformatWidth,
    'webformatHeight' : webformatHeight,
    'largeImageURL' : largeImageURL,
    'imageWidth' : imageWidth,
    'imageHeight' : imageHeight,
    'imageSize' : imageSize,
    'views' : views,
    'downloads' : downloads,
    'collections' : collections,
    'likes' : likes,
    'comments' : comments,
    'user_id' : userId,
    'user' : user,
    'userImageURL' : userImageURL,
  };
}