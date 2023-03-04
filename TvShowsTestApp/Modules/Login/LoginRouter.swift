import Foundation
import UIKit

class LoginRouter: LoginRouterProtocol {
  
    weak var view: LoginViewProtocol?
    
    static func createLoginModule() -> UIViewController {
        let view = LoginView()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        let router: LoginRouterProtocol = LoginRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
    func showFow() {
        guard let view = self.view as? UIViewController else { return }
        DispatchQueue.main.async {
            let vc = LaunchMoviesRouter.createLaunchMoviesModule()
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
