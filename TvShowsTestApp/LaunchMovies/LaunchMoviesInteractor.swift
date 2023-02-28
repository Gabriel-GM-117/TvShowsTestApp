import Foundation

class LaunchMoviesInteractor: LaunchMoviesInteractorInputProtocol {
 
    // MARK: Properties
    weak var presenter: LaunchMoviesInteractorOutputProtocol?
    private let service = TheMovieDBService()
    
    func getMovies(flow: CategoryFlow) {

        switch flow {
        case .popular:
            getPopularMovies()
        case .topRated:
            getTopRatedMovies()
        case .onTV:
            getOnTVMovies()
        case .airingToday:
            getAiringTodayMovies()
        }

    }
    
    private func getPopularMovies() {
        self.service.getListOfMovies(strUrl: Path.baseMoviePopular.stringURL) { [weak self] result in
            switch result {
            case .success(let success):
                print("exito \(String(describing: success))")
                guard let objResp = success else { return
                    // self?.presenter?.didShowError(error)
                }
                self?.presenter?.didRetrive(dataMovies: objResp.results)
            case .failure(let failure):
                print("error\(failure)")
            }
        }
    }
    
    private func getTopRatedMovies() {
        self.service.getListOfMovies(strUrl: Path.baseMovieTopRated.stringURL) { [weak self] result in
            switch result {
            case .success(let success):
                print("exito \(String(describing: success))")
                guard let objResp = success else { return
                }
                self?.presenter?.didRetrive(dataMovies: objResp.results)
            case .failure(let failure):
                print("error\(failure)")
            }
        }
    }
    
    private func getOnTVMovies() {
        service.getListOfMovies(strUrl: Path.baseMovieOnTV.stringURL) { [weak self] result in
            switch result {
            case .success(let success):
                print("exito \(String(describing: success))")
                guard let objResp = success else { return
                }
                self?.presenter?.didRetrive(dataMovies: objResp.results)
            case .failure(let failure):
                print("error\(failure)")
            }
        }
    }
    
    private func getAiringTodayMovies() {
        service.getListOfMovies(strUrl: Path.baseMovieAiringToday.stringURL) { [weak self] result in
            switch result {
            case .success(let success):
                print("exito \(String(describing: success))")
                guard let objResp = success else { return
                }
                self?.presenter?.didRetrive(dataMovies: objResp.results)
            case .failure(let failure):
                print("error\(failure)")
            }
        }
    }
    
    func getMovieDetail(idMovie: Int) {
        self.service.getDetailfMovie(idMovie: idMovie) { [weak self] result in
            switch result {
            case .success(let success):
                print("exito \(String(describing: success))")
                guard let objResp = success else { return
                    // self?.presenter?.didShowError(error)
                }
                self?.presenter?.didRetrive(data: objResp, flow: Flow.movie)
            case .failure(let failure):
                print("error\(failure)")
            }
        }
    }
    
    func getTVShowDetail(idTVShow: Int) {
        self.service.getTVShowDetail(idTVShow: idTVShow) { [weak self] result in
            switch result {
            case .success(let success):
                print("exito \(String(describing: success))")
                guard let objResp = success else { return
                    // self?.presenter?.didShowError(error)
                }
                self?.presenter?.didRetrive(data: objResp, flow: Flow.tvShow)
            case .failure(let failure):
                print("error\(failure)")
            }
        }
    }
    
    
}


