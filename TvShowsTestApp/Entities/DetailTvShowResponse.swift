import Foundation

// MARK: - DetailTvShow
struct DetailTvShowResponse: Decodable {
    let createdBy: [CreatedBy]?
    let firstAirDate: String?
    let genresTvShow: [GenreTvShow]?
    let homepage: String?
    let id: Int?
    let lastAirDate: String?
    let name: String?
    let networks: [ProductionCompany]?

    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let seasons: [Season]?

    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case createdBy = "created_by"
        case firstAirDate = "first_air_date"
        case genresTvShow = "genres"
        case homepage, id
        case lastAirDate = "last_air_date"
        case name
        case networks
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case seasons
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - CreatedBy
struct CreatedBy: Decodable {
    let id: Int?
    let creditID, name: String?
    let gender: Int?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name, gender
        case profilePath = "profile_path"
    }
}

// MARK: - GenreTvShow
struct GenreTvShow: Decodable {
    let id: Int?
    let name: String?
}

// MARK: - Season
struct Season: Decodable {
    let airDate: String?
    let episodeCount, id: Int?
    let name, overview, posterPath: String?
    let seasonNumber: Int?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
