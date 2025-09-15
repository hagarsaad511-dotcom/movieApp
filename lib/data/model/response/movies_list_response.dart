// class MoviesListResponse {
//   MoviesListResponse({
//       this.status,
//       this.statusMessage,
//       this.data,
//       });
//
//   MoviesListResponse.fromJson(dynamic json) {
//     status = json['status'];
//     statusMessage = json['status_message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//
//   }
//   String? status;
//   String? statusMessage;
//   Data? data;
//
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['status_message'] = statusMessage;
//     if (data != null) {
//       map['data'] = data?.toJson();
//     }
//
//     return map;
//   }
//
// }
//
//
//
// class Data {
//   Data({
//       this.movieCount,
//       this.limit,
//       this.pageNumber,
//       this.movies,});
//
//   Data.fromJson(dynamic json) {
//     movieCount = json['movie_count'];
//     limit = json['limit'];
//     pageNumber = json['page_number'];
//     if (json['movies'] != null) {
//       movies = [];
//       json['movies'].forEach((v) {
//         movies?.add(Movies.fromJson(v));
//       });
//     }
//   }
//   int? movieCount;
//   int? limit;
//   int? pageNumber;
//   List<Movies>? movies;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['movie_count'] = movieCount;
//     map['limit'] = limit;
//     map['page_number'] = pageNumber;
//     if (movies != null) {
//       map['movies'] = movies?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
//
//
//
// class Movies {
//   Movies({
//       this.id,
//       this.url,
//       this.imdbCode,
//       this.title,
//       this.titleEnglish,
//       this.titleLong,
//       this.slug,
//       this.year,
//       this.rating,
//       this.runtime,
//       this.genres,
//       this.summary,
//       this.descriptionFull,
//       this.synopsis,
//       this.ytTrailerCode,
//       this.language,
//       this.mpaRating,
//       this.backgroundImage,
//       this.backgroundImageOriginal,
//       this.smallCoverImage,
//       this.mediumCoverImage,
//       this.largeCoverImage,
//       this.state,
//       this.torrents,
//       this.dateUploaded,
//       this.dateUploadedUnix,});
//
//   Movies.fromJson(dynamic json) {
//     id = json['id'];
//     url = json['url'];
//     imdbCode = json['imdb_code'];
//     title = json['title'];
//     titleEnglish = json['title_english'];
//     titleLong = json['title_long'];
//     slug = json['slug'];
//     year = json['year'];
//     rating = json['rating'];
//     runtime = json['runtime'];
//     genres = json['genres'] != null ? json['genres'].cast<String>() : [];
//     summary = json['summary'];
//     descriptionFull = json['description_full'];
//     synopsis = json['synopsis'];
//     ytTrailerCode = json['yt_trailer_code'];
//     language = json['language'];
//     mpaRating = json['mpa_rating'];
//     backgroundImage = json['background_image'];
//     backgroundImageOriginal = json['background_image_original'];
//     smallCoverImage = json['small_cover_image'];
//     mediumCoverImage = json['medium_cover_image'];
//     largeCoverImage = json['large_cover_image'];
//     state = json['state'];
//     if (json['torrents'] != null) {
//       torrents = [];
//       json['torrents'].forEach((v) {
//         torrents?.add(Torrents.fromJson(v));
//       });
//     }
//     dateUploaded = json['date_uploaded'];
//     dateUploadedUnix = json['date_uploaded_unix'];
//   }
//
//
//   int? id;
//   String? url;
//   String? imdbCode;
//   String? title;
//   String? titleEnglish;
//   String? titleLong;
//   String? slug;
//   int? year;
//   double? rating;
//   int? runtime;
//   List<String>? genres;
//   String? summary;
//   String? descriptionFull;
//   String? synopsis;
//   String? ytTrailerCode;
//   String? language;
//   String? mpaRating;
//   String? backgroundImage;
//   String? backgroundImageOriginal;
//   String? smallCoverImage;
//   String? mediumCoverImage;
//   String? largeCoverImage;
//   String? state;
//   List<Torrents>? torrents;
//   String? dateUploaded;
//   int? dateUploadedUnix;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['url'] = url;
//     map['imdb_code'] = imdbCode;
//     map['title'] = title;
//     map['title_english'] = titleEnglish;
//     map['title_long'] = titleLong;
//     map['slug'] = slug;
//     map['year'] = year;
//     map['rating'] = rating;
//     map['runtime'] = runtime;
//     map['genres'] = genres;
//     map['summary'] = summary;
//     map['description_full'] = descriptionFull;
//     map['synopsis'] = synopsis;
//     map['yt_trailer_code'] = ytTrailerCode;
//     map['language'] = language;
//     map['mpa_rating'] = mpaRating;
//     map['background_image'] = backgroundImage;
//     map['background_image_original'] = backgroundImageOriginal;
//     map['small_cover_image'] = smallCoverImage;
//     map['medium_cover_image'] = mediumCoverImage;
//     map['large_cover_image'] = largeCoverImage;
//     map['state'] = state;
//     if (torrents != null) {
//       map['torrents'] = torrents?.map((v) => v.toJson()).toList();
//     }
//     map['date_uploaded'] = dateUploaded;
//     map['date_uploaded_unix'] = dateUploadedUnix;
//     return map;
//   }
//
// }
//
// class Torrents {
//   Torrents({
//       this.url,
//       this.hash,
//       this.quality,
//       this.type,
//       this.isRepack,
//       this.videoCodec,
//       this.bitDepth,
//       this.audioChannels,
//       this.seeds,
//       this.peers,
//       this.size,
//       this.sizeBytes,
//       this.dateUploaded,
//       this.dateUploadedUnix,});
//
//   Torrents.fromJson(dynamic json) {
//     url = json['url'];
//     hash = json['hash'];
//     quality = json['quality'];
//     type = json['type'];
//     isRepack = json['is_repack'];
//     videoCodec = json['video_codec'];
//     bitDepth = json['bit_depth'];
//     audioChannels = json['audio_channels'];
//     seeds = json['seeds'];
//     peers = json['peers'];
//     size = json['size'];
//     sizeBytes = json['size_bytes'];
//     dateUploaded = json['date_uploaded'];
//     dateUploadedUnix = json['date_uploaded_unix'];
//   }
//   String? url;
//   String? hash;
//   String? quality;
//   String? type;
//   String? isRepack;
//   String? videoCodec;
//   String? bitDepth;
//   String? audioChannels;
//   int? seeds;
//   int? peers;
//   String? size;
//   int? sizeBytes;
//   String? dateUploaded;
//   int? dateUploadedUnix;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['url'] = url;
//     map['hash'] = hash;
//     map['quality'] = quality;
//     map['type'] = type;
//     map['is_repack'] = isRepack;
//     map['video_codec'] = videoCodec;
//     map['bit_depth'] = bitDepth;
//     map['audio_channels'] = audioChannels;
//     map['seeds'] = seeds;
//     map['peers'] = peers;
//     map['size'] = size;
//     map['size_bytes'] = sizeBytes;
//     map['date_uploaded'] = dateUploaded;
//     map['date_uploaded_unix'] = dateUploadedUnix;
//     return map;
//   }
//
// }

class MoviesListResponse {
  String? status;
  String? statusMessage;
  Data? data;

  MoviesListResponse({this.status, this.statusMessage, this.data});

  MoviesListResponse.fromJson(dynamic json) {
    status = json['status']?.toString();
    statusMessage = json['status_message']?.toString();
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<Movies>? movies;

  Data({this.movieCount, this.limit, this.pageNumber, this.movies});

  Data.fromJson(dynamic json) {
    movieCount = _parseInt(json['movie_count']);
    limit = _parseInt(json['limit']);
    pageNumber = _parseInt(json['page_number']);
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(Movies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movie_count'] = movieCount;
    map['limit'] = limit;
    map['page_number'] = pageNumber;
    if (movies != null) {
      map['movies'] = movies?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Movies {
  Movies({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  Movies.fromJson(dynamic json) {
    id = _toInt(json['id']);
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = _toInt(json['year']);
    rating = _toDouble(json['rating']);
    runtime = _toInt(json['runtime']);
    genres = json['genres'] != null ? List<String>.from(json['genres']) : [];
    summary = json['summary'];
    descriptionFull = json['description_full'];
    synopsis = json['synopsis'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    state = json['state'];
    if (json['torrents'] != null) {
      torrents = [];
      json['torrents'].forEach((v) {
        torrents?.add(Torrents.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = _toInt(json['date_uploaded_unix']);
  }

  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? state;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['summary'] = summary;
    map['description_full'] = descriptionFull;
    map['synopsis'] = synopsis;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['state'] = state;
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

  /// 🔒 Helpers to avoid format exceptions
  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}



// class Movies {
//   int? id;
//   String? url;
//   String? imdbCode;
//   String? title;
//   String? titleEnglish;
//   String? titleLong;
//   String? slug;
//   int? year;
//   double? rating;
//   int? runtime;
//   List<String>? genres;
//   String? summary;
//   String? descriptionFull;
//   String? synopsis;
//   String? ytTrailerCode;
//   String? language;
//   String? mpaRating;
//   String? backgroundImage;
//   String? backgroundImageOriginal;
//   String? smallCoverImage;
//   String? mediumCoverImage;
//   String? largeCoverImage;
//   String? state;
//   List<Torrents>? torrents;
//   String? dateUploaded;
//   int? dateUploadedUnix;
//
//   Movies({
//     this.id,
//     this.url,
//     this.imdbCode,
//     this.title,
//     this.titleEnglish,
//     this.titleLong,
//     this.slug,
//     this.year,
//     this.rating,
//     this.runtime,
//     this.genres,
//     this.summary,
//     this.descriptionFull,
//     this.synopsis,
//     this.ytTrailerCode,
//     this.language,
//     this.mpaRating,
//     this.backgroundImage,
//     this.backgroundImageOriginal,
//     this.smallCoverImage,
//     this.mediumCoverImage,
//     this.largeCoverImage,
//     this.state,
//     this.torrents,
//     this.dateUploaded,
//     this.dateUploadedUnix,
//   });
//
//   Movies.fromJson(dynamic json) {
//     id = _parseInt(json['id']);
//     url = json['url']?.toString();
//     imdbCode = json['imdb_code']?.toString();
//     title = json['title']?.toString();
//     titleEnglish = json['title_english']?.toString();
//     titleLong = json['title_long']?.toString();
//     slug = json['slug']?.toString();
//     year = _parseInt(json['year']);
//     rating = _parseDouble(json['rating']);
//     runtime = _parseInt(json['runtime']);
//     genres = json['genres'] != null ? List<String>.from(json['genres']) : [];
//     summary = json['summary']?.toString();
//     descriptionFull = json['description_full']?.toString();
//     synopsis = json['synopsis']?.toString();
//     ytTrailerCode = json['yt_trailer_code']?.toString();
//     language = json['language']?.toString();
//     mpaRating = json['mpa_rating']?.toString();
//     backgroundImage = json['background_image']?.toString();
//     backgroundImageOriginal = json['background_image_original']?.toString();
//     smallCoverImage = json['small_cover_image']?.toString();
//     mediumCoverImage = json['medium_cover_image']?.toString();
//     largeCoverImage = json['large_cover_image']?.toString();
//     state = json['state']?.toString();
//
//     if (json['torrents'] != null) {
//       torrents = [];
//       json['torrents'].forEach((v) {
//         torrents?.add(Torrents.fromJson(v));
//       });
//     }
//
//     dateUploaded = json['date_uploaded']?.toString();
//     dateUploadedUnix = _parseInt(json['date_uploaded_unix']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['url'] = url;
//     map['imdb_code'] = imdbCode;
//     map['title'] = title;
//     map['title_english'] = titleEnglish;
//     map['title_long'] = titleLong;
//     map['slug'] = slug;
//     map['year'] = year;
//     map['rating'] = rating;
//     map['runtime'] = runtime;
//     map['genres'] = genres;
//     map['summary'] = summary;
//     map['description_full'] = descriptionFull;
//     map['synopsis'] = synopsis;
//     map['yt_trailer_code'] = ytTrailerCode;
//     map['language'] = language;
//     map['mpa_rating'] = mpaRating;
//     map['background_image'] = backgroundImage;
//     map['background_image_original'] = backgroundImageOriginal;
//     map['small_cover_image'] = smallCoverImage;
//     map['medium_cover_image'] = mediumCoverImage;
//     map['large_cover_image'] = largeCoverImage;
//     map['state'] = state;
//     if (torrents != null) {
//       map['torrents'] = torrents?.map((v) => v.toJson()).toList();
//     }
//     map['date_uploaded'] = dateUploaded;
//     map['date_uploaded_unix'] = dateUploadedUnix;
//     return map;
//   }
// }

class Torrents {
  Torrents({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  Torrents.fromJson(dynamic json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    type = json['type'];
    isRepack = json['is_repack']?.toString();
    videoCodec = json['video_codec'];
    bitDepth = json['bit_depth']?.toString();
    audioChannels = json['audio_channels']?.toString();
    seeds = _toInt(json['seeds']);
    peers = _toInt(json['peers']);
    size = json['size'];
    sizeBytes = _toInt(json['size_bytes']);
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = _toInt(json['date_uploaded_unix']);
  }

  String? url;
  String? hash;
  String? quality;
  String? type;
  String? isRepack;
  String? videoCodec;
  String? bitDepth;
  String? audioChannels;
  int? seeds;
  int? peers;
  String? size;
  int? sizeBytes;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['hash'] = hash;
    map['quality'] = quality;
    map['type'] = type;
    map['is_repack'] = isRepack;
    map['video_codec'] = videoCodec;
    map['bit_depth'] = bitDepth;
    map['audio_channels'] = audioChannels;
    map['seeds'] = seeds;
    map['peers'] = peers;
    map['size'] = size;
    map['size_bytes'] = sizeBytes;
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

  /// 🔒 Helpers
  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}


/// helper functions
int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}

double? _parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}
