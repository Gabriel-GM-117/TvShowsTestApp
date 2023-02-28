import Foundation
import UIKit

class DetailViewRouter: DetailViewWireRouterProtocol {
    
    static func createDetailViewModule(data: Any, flow: Flow) -> UIViewController {
        let view = DetailViewVC(data: data, flow: flow)
        let presenter: DetailViewPresenterProtocol & DetailViewInteractorOutputProtocol = DetailViewPresenter()
        let interactor: DetailViewInteractorInputProtocol = DetailViewInteractor()
        let router: DetailViewWireRouterProtocol = DetailViewRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
