import Foundation

class DetailProfilePresenter: DetailProfilePresenterProtocol  {

    // MARK: Properties
    weak var view: DetailProfileViewProtocol?
    var interactor: DetailProfileInteractorInputProtocol?
    var router: DetailProfileRouterProtocol?
    
    func presentInfo() {
        interactor?.getInfoProfileDetail()
    }
    
    func presentDataMovies() {
        interactor?.getMovies()
    }

}


extension DetailProfilePresenter: DetailProfileInteractorOutputProtocol {
    
    // TODO: implement interactor output methods
    func didRetrive(infoProfile: ResponseDetailUser) {
        view?.showInfoProfile(info: infoProfile)
    }
    
    func didRetrive(dataMovies: [MovieEntity]) {
        view?.showMovieList(dataMovies: dataMovies)
    }

}
