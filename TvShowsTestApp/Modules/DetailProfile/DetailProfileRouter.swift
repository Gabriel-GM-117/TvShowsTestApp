import Foundation
import UIKit

class DetailProfileRouter: DetailProfileRouterProtocol {
 
    weak var view: DetailProfileViewProtocol?
    
    class func createDetailProfileModule() -> UIViewController {
        let view = DetailProfileView()
        let presenter: DetailProfilePresenterProtocol & DetailProfileInteractorOutputProtocol = DetailProfilePresenter()
        let interactor: DetailProfileInteractorInputProtocol = DetailProfileInteractor()
        let router: DetailProfileRouterProtocol = DetailProfileRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
    func showDetailView(data: Any, flow: Flow) {
        //
    }
    
    
}
