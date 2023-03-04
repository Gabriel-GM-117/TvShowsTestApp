import Foundation

class DetailViewPresenter: DetailViewPresenterProtocol  {

    // MARK: Properties
    weak var view: DetailViewViewProtocol?
    var interactor: DetailViewInteractorInputProtocol?
    var router: DetailViewWireRouterProtocol?
    
    func getInfoMovie(idMovie: Int) {
        interactor?.getMovie(idMovie: idMovie)
    }
}

extension DetailViewPresenter: DetailViewInteractorOutputProtocol {
    
    // TODO: implement interactor output methods
    func didRetrive(dataMovie: DetailMovieResponse) {
        view?.showMovieList(dataMovie: dataMovie)
    }
}
