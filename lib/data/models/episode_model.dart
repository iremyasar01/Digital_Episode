class EpisodeModel {
  String? airDate;
  int? episodeNumber;
  String? episodeType;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;
  int? voteAverage;
  int? voteCount;

  EpisodeModel({
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  EpisodeModel.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeNumber = (json['episode_number'] as num?)?.toInt(); // Convert from num to int
    episodeType = json['episode_type'];
    id = (json['id'] as num?)?.toInt(); // Convert from num to int
    name = json['name'];
    overview = json['overview'];
    productionCode = json['production_code'];
    runtime = (json['runtime'] as num?)?.toInt(); // Convert from num to int
    seasonNumber = (json['season_number'] as num?)?.toInt(); // Convert from num to int
    showId = (json['show_id'] as num?)?.toInt(); // Convert from num to int
    stillPath = json['still_path'];
    voteAverage = (json['vote_average'] as num?)?.toInt(); // Convert from num to int
    voteCount = (json['vote_count'] as num?)?.toInt(); // Convert from num to int
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['episode_type'] = episodeType;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['production_code'] = productionCode;
    data['runtime'] = runtime;
    data['season_number'] = seasonNumber;
    data['show_id'] = showId;
    data['still_path'] = stillPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

