import Foundation

class DetailViewPresenter: DetailViewPresenterProtocol  {

    // MARK: Properties
    weak var view: DetailViewViewProtocol?
    var interactor: DetailViewInteractorInputProtocol?
    var router: DetailViewWireRouterProtocol?
    
}

extension DetailViewPresenter: DetailViewInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
