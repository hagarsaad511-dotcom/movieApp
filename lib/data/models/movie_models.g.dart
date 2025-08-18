// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      year: (json['year'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      runtime: (json['runtime'] as num).toInt(),
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      summary: json['summary'] as String,
      descriptionFull: json['description_full'] as String?,
      synopsis: json['synopsis'] as String?,
      ytTrailerCode: json['yt_trailer_code'] as String?,
      language: json['language'] as String,
      mpaRating: json['mpa_rating'] as String?,
      backgroundImage: json['background_image'] as String,
      backgroundImageOriginal: json['background_image_original'] as String,
      smallCoverImage: json['small_cover_image'] as String,
      mediumCoverImage: json['medium_cover_image'] as String,
      largeCoverImage: json['large_cover_image'] as String,
      torrents: (json['torrents'] as List<dynamic>?)
          ?.map((e) => TorrentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'year': instance.year,
      'rating': instance.rating,
      'runtime': instance.runtime,
      'genres': instance.genres,
      'summary': instance.summary,
      'description_full': instance.descriptionFull,
      'synopsis': instance.synopsis,
      'yt_trailer_code': instance.ytTrailerCode,
      'language': instance.language,
      'mpa_rating': instance.mpaRating,
      'background_image': instance.backgroundImage,
      'background_image_original': instance.backgroundImageOriginal,
      'small_cover_image': instance.smallCoverImage,
      'medium_cover_image': instance.mediumCoverImage,
      'large_cover_image': instance.largeCoverImage,
      'torrents': instance.torrents,
    };

TorrentModel _$TorrentModelFromJson(Map<String, dynamic> json) => TorrentModel(
      url: json['url'] as String,
      hash: json['hash'] as String,
      quality: json['quality'] as String,
      type: json['type'] as String,
      seeds: (json['seeds'] as num).toInt(),
      peers: (json['peers'] as num).toInt(),
      size: json['size'] as String,
      sizeBytes: (json['size_bytes'] as num).toInt(),
      dateUploaded: json['date_uploaded'] as String,
      dateUploadedUnix: (json['date_uploaded_unix'] as num).toInt(),
    );

Map<String, dynamic> _$TorrentModelToJson(TorrentModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'hash': instance.hash,
      'quality': instance.quality,
      'type': instance.type,
      'seeds': instance.seeds,
      'peers': instance.peers,
      'size': instance.size,
      'size_bytes': instance.sizeBytes,
      'date_uploaded': instance.dateUploaded,
      'date_uploaded_unix': instance.dateUploadedUnix,
    };

MoviesResponse _$MoviesResponseFromJson(Map<String, dynamic> json) =>
    MoviesResponse(
      status: json['status'] as String,
      statusMessage: json['status_message'] as String,
      data: MovieDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MoviesResponseToJson(MoviesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_message': instance.statusMessage,
      'data': instance.data,
    };

MovieDataModel _$MovieDataModelFromJson(Map<String, dynamic> json) =>
    MovieDataModel(
      movieCount: (json['movie_count'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      pageNumber: (json['page_number'] as num).toInt(),
      movies: (json['movies'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDataModelToJson(MovieDataModel instance) =>
    <String, dynamic>{
      'movie_count': instance.movieCount,
      'limit': instance.limit,
      'page_number': instance.pageNumber,
      'movies': instance.movies,
    };

MovieDetailsResponse _$MovieDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    MovieDetailsResponse(
      status: json['status'] as String,
      statusMessage: json['status_message'] as String,
      data:
          MovieDetailsDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDetailsResponseToJson(
        MovieDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_message': instance.statusMessage,
      'data': instance.data,
    };

MovieDetailsDataModel _$MovieDetailsDataModelFromJson(
        Map<String, dynamic> json) =>
    MovieDetailsDataModel(
      movie: MovieModel.fromJson(json['movie'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDetailsDataModelToJson(
        MovieDetailsDataModel instance) =>
    <String, dynamic>{
      'movie': instance.movie,
    };
