/// Represents the response from the Pixabay API.
///
/// The [PixabayResponse] class models the JSON response returned from the
/// Pixabay API, which includes the total number of results, total hits,
/// and a list of hits (images).
class PixabayResponse {
  /// Creates an instance of [PixabayResponse].
  ///
  /// - [total]: The total number of items available in the response.
  /// - [totalHits]: The total number of hits returned in the JSON response.
  /// - [hits]: A list of [Hits] objects containing image data from the JSON response.
  PixabayResponse({
    this.total,
    this.totalHits,
    this.hits,
  });

  /// Creates a [PixabayResponse] instance from a JSON map.
  ///
  /// - [json]: A map representation of the JSON response from the API.
  PixabayResponse.fromJson(final Map<String, dynamic> json)
      : total = json['total'] as int?,
        totalHits = json['totalHits'] as int?,
        hits = (json['hits'] as List?)?.map((final dynamic e) => Hits.fromJson(e as Map<String,dynamic>)).toList();

  /// The total number of items available in the JSON response.
  final int? total;

  /// The total number of hits returned in the JSON response.
  final int? totalHits;

  /// A list of hits (images) returned by the API in the JSON response.
  final List<Hits>? hits;

  /// Converts the [PixabayResponse] instance to a JSON map.
  Map<String, dynamic> toJson() => {
    'total' : total,
    'totalHits' : totalHits,
    'hits' : hits?.map((final e) => e.toJson()).toList(),
  };
}

/// Represents a single hit (image) returned from the Pixabay API.
///
/// The [Hits] class encapsulates the properties of each image returned
/// by the Pixabay API, including various image URLs and metadata
/// as defined in the JSON response.
class Hits {
  /// Creates an instance of [Hits].

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

  /// Creates a [Hits] instance from a JSON map.
  ///
  /// - [json]: A map representation of the JSON response for a single hit.
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

  /// Converts the [Hits] instance to a JSON map.
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