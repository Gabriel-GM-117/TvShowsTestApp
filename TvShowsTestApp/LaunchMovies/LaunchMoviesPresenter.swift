import Foundation

class LaunchMoviesPresenter: LaunchMoviesPresenterProtocol  {
    
    // MARK: Properties
    weak var view: LaunchMoviesViewProtocol?
    var interactor: LaunchMoviesInteractorInputProtocol?
    var router: LaunchMoviesRouterProtocol?
    
    func getInfoMovies(flow: CategoryFlow) {
        interactor?.getMovies(flow: flow)
    }
    
    func presentInfo(id: Int, flow: Flow) {
        switch flow {
        case .movie:
            interactor?.getMovieDetail(idMovie: id)
        case .tvShow:
            interactor?.getTVShowDetail(idTVShow: id)
        }
    }
    
    func showInfoPerfil() {
        router?.presentInfoPerfil()
    }
}

extension LaunchMoviesPresenter: LaunchMoviesInteractorOutputProtocol {
    
    // TODO: implement interactor output methods
    func didRetrive(dataMovies: [PopularMoviesEntity]) {
        view?.showMovieList(dataMovies: dataMovies)
    }
    
    func didRetrive(data: Any, flow: Flow) {
        router?.showDetailView(data: data, flow: flow)
    }
}
