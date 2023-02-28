
import Foundation

enum Flow {
    case movie
    case tvShow
    
    var idFlow: Int {
        switch self {
        case .movie:
            return 1
        case .tvShow:
            return 2
        }
    }
    
}
