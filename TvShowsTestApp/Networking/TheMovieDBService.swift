
import Foundation

class TheMovieDBService {
    func getListOfMovies(strUrl: String, completion: @escaping(Result<PopularMoviesResponse?, RequestError>) -> Void) {
        ServicesManager().fetchRequest(strUrl: strUrl, completion: completion)
    }
    
    func getDetailfMovie(idMovie: Int, completion: @escaping(Result<DetailMovieResponse?, RequestError>) -> Void) {
        let strURl = Path.consultMoviDetails.stringURL + "\(idMovie)" + Path.apiKey.stringURL + Path.baseLangueMX.stringURL
        ServicesManager().fetchRequest(strUrl: strURl, completion: completion)
    }
    
    func getTVShowDetail(idTVShow: Int, completion: @escaping(Result<DetailTvShowResponse?, RequestError>) -> Void) {
        let strURl = Path.consultTvShowDetail.stringURL + "\(idTVShow)" + Path.apiKey.stringURL
        ServicesManager().fetchRequest(strUrl: strURl, completion: completion)
    }
    
    func getToken(completion: @escaping(Result<AuthToken?, RequestError>) -> Void) {
        let strURl = Path.authenticationTokenNew.stringURL + Path.apiKey.stringURL
        ServicesManager().fetchRequest(strUrl: strURl, completion: completion)
    }
    
    func getAuth(strToken: String, completion: @escaping(Result<AuthSessionResponse?, RequestError>) -> Void) {
        let strURL = Path.authSessionNew.stringURL + Path.apiKey.stringURL
        guard let request = ServicesManager().createRequest(urlString: strURL, HTTPMethod: .post, bodyStr: strToken, bodyObjAny: nil) else
        { return }
        DispatchQueue.main.async {
            ServicesManager().fetchRequest(with: request, completion: completion)
        }
    }
    
    func getAuthUser(strToken: String, completion: @escaping(Result<AuthUserResponse?, RequestError>) -> Void) {
        let strURL = Path.authWithUser.stringURL + Path.apiKey.stringURL
        guard let param1 = Repository.userPass else { return }
        guard let param2 = Repository.userName else { return }
        
        let parametros = ["request_token": strToken, "password": param1 , "username": param2 ]
        guard let request = ServicesManager().createRequest(urlString: strURL, HTTPMethod: .post, bodyObjAny: parametros) else
        { return }
            ServicesManager().fetchRequest(with: request, completion: completion)
    }
    
}

