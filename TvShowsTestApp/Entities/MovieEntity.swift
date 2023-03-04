import Foundation

struct MovieEntity: Decodable {
    var id: Int
    var title: String?
    var overview: String?
    var imageURL: String
    var votes: Double?
    var releaseDate: String?
    var firstAirDate: String?
    var nameTV: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case imageURL = "poster_path"
        case votes = "vote_average"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case nameTV
    }
}
