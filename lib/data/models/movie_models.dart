import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'movie_models.g.dart';

@JsonSerializable()
class MovieModel extends Equatable {
  final int id;
  final String title;
  @JsonKey(name: 'year')
  final int year;
  final double rating;
  @JsonKey(name: 'runtime')
  final int runtime;
  final List<String> genres;
  final String summary;
  @JsonKey(name: 'description_full')
  final String? descriptionFull;
  @JsonKey(name: 'synopsis')
  final String? synopsis;
  @JsonKey(name: 'yt_trailer_code')
  final String? ytTrailerCode;
  @JsonKey(name: 'language')
  final String language;
  @JsonKey(name: 'mpa_rating')
  final String? mpaRating;
  @JsonKey(name: 'background_image')
  final String backgroundImage;
  @JsonKey(name: 'background_image_original')
  final String backgroundImageOriginal;
  @JsonKey(name: 'small_cover_image')
  final String smallCoverImage;
  @JsonKey(name: 'medium_cover_image')
  final String mediumCoverImage;
  @JsonKey(name: 'large_cover_image')
  final String largeCoverImage;
  final List<TorrentModel>? torrents;

  const MovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    required this.language,
    this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    this.torrents,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    title,
    year,
    rating,
    runtime,
    genres,
    summary,
    descriptionFull,
    synopsis,
    ytTrailerCode,
    language,
    mpaRating,
    backgroundImage,
    backgroundImageOriginal,
    smallCoverImage,
    mediumCoverImage,
    largeCoverImage,
    torrents,
  ];
}

@JsonSerializable()
class TorrentModel extends Equatable {
  final String url;
  final String hash;
  final String quality;
  final String type;
  final int seeds;
  final int peers;
  final String size;
  @JsonKey(name: 'size_bytes')
  final int sizeBytes;
  @JsonKey(name: 'date_uploaded')
  final String dateUploaded;
  @JsonKey(name: 'date_uploaded_unix')
  final int dateUploadedUnix;

  const TorrentModel({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory TorrentModel.fromJson(Map<String, dynamic> json) =>
      _$TorrentModelFromJson(json);

  Map<String, dynamic> toJson() => _$TorrentModelToJson(this);

  @override
  List<Object> get props => [
    url,
    hash,
    quality,
    type,
    seeds,
    peers,
    size,
    sizeBytes,
    dateUploaded,
    dateUploadedUnix,
  ];
}

@JsonSerializable()
class MoviesResponse extends Equatable {
  final String status;
  @JsonKey(name: 'status_message')
  final String statusMessage;
  final MovieDataModel data;

  const MoviesResponse({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesResponseToJson(this);

  @override
  List<Object> get props => [status, statusMessage, data];
}

@JsonSerializable()
class MovieDataModel extends Equatable {
  @JsonKey(name: 'movie_count')
  final int movieCount;
  final int limit;
  @JsonKey(name: 'page_number')
  final int pageNumber;
  final List<MovieModel> movies;

  const MovieDataModel({
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
    required this.movies,
  });

  factory MovieDataModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDataModelToJson(this);

  @override
  List<Object> get props => [movieCount, limit, pageNumber, movies];
}

@JsonSerializable()
class MovieDetailsResponse extends Equatable {
  final String status;
  @JsonKey(name: 'status_message')
  final String statusMessage;
  final MovieDetailsDataModel data;

  const MovieDetailsResponse({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsResponseToJson(this);

  @override
  List<Object> get props => [status, statusMessage, data];
}

@JsonSerializable()
class MovieDetailsDataModel extends Equatable {
  final MovieModel movie;

  const MovieDetailsDataModel({
    required this.movie,
  });

  factory MovieDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsDataModelToJson(this);

  @override
  List<Object> get props => [movie];
}