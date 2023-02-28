import Foundation

enum CategoryFlow {
    case popular
    case topRated
    case onTV
    case airingToday
    
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .onTV:
            return "On TV"
        case .airingToday:
            return "Airing Today"
        }
    }
    var idFlow: Int {
        switch self {
        case .popular:
            return 1
        case .topRated:
            return 1
        case .onTV:
            return 2
        case .airingToday:
            return 2
        }
    }
}
