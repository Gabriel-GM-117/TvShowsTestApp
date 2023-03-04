import Foundation

struct RequestError: Error {
    let statusCode: Int
    let description: String
    var data: Data?
}

struct Path {
    let stringURL: String
}

internal extension Path {
    static let baseImage = Path(stringURL: "https://image.tmdb.org/t/p/w200")
    static let baseMoviePopular = Path(stringURL: "https://api.themoviedb.org/3/movie/popular?api_key=fdd70b40b9830022c6867b34964e2a92&language=es-mx&page=1")
    static let baseMovieTopRated = Path(stringURL: "https://api.themoviedb.org/3/movie/top_rated?api_key=fdd70b40b9830022c6867b34964e2a92&language=es-mx&page=1")
    static let baseMovieOnTV = Path(stringURL: "https://api.themoviedb.org/3/tv/on_the_air?api_key=fdd70b40b9830022c6867b34964e2a92")
    static let baseMovieAiringToday = Path(stringURL: "https://api.themoviedb.org/3/tv/airing_today?api_key=fdd70b40b9830022c6867b34964e2a92")
    static let consultMoviDetails = Path(stringURL: "https://api.themoviedb.org/3/movie/")
    static let consultTvShowDetail = Path(stringURL: "https://api.themoviedb.org/3/tv/")
    static let apiKey = Path(stringURL: "?api_key=fdd70b40b9830022c6867b34964e2a92")
    static let baseLangueMX = Path(stringURL: "&language=es-mx&page=1")
    static let authenticationTokenNew = Path(stringURL: "https://api.themoviedb.org/3/authentication/token/new")
    static let authenticateRequest = Path(stringURL: "https://www.themoviedb.org/authenticate/")
    static let authSessionNew = Path(stringURL: "https://api.themoviedb.org/3/authentication/session/new")
    static let authWithUser = Path(stringURL: "https://api.themoviedb.org/3/authentication/token/validate_with_login")
    static let accountDetail = Path(stringURL: "https://api.themoviedb.org/3/account")
    static let logOutSession = Path(stringURL: "https://api.themoviedb.org/3/authentication/session")
}
