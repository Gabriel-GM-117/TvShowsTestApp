
import Foundation
import UIKit

class LoginRouter: LoginRouterProtocol {
   
    
    weak var view: LoginViewProtocol?

    static func createLoginModule() -> UIViewController {
//        let navController = mainStoryboard.instantiateViewController(withIdentifier: "LoginView")
         let view = LoginView()
//        {
            let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
            let interactor: LoginInteractorInputProtocol = LoginInteractor()
//            let localDataManager: LoginLocalDataManagerInputProtocol = LoginLocalDataManager()
//            let remoteDataManager: LoginRemoteDataManagerInputProtocol = LoginRemoteDataManager()
            let router: LoginRouterProtocol = LoginRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            router.view = view
        
//            interactor.localDatamanager = localDataManager
//            interactor.remoteDatamanager = remoteDataManager
//            remoteDataManager.remoteRequestHandler = interactor
            
            return view
//        }
//        return UIViewController()
    }
    
    func showFow() {
       
        guard let view = self.view as? UIViewController else { return }
        
        DispatchQueue.main.async {
            let vc = LaunchMoviesRouter.createLaunchMoviesModule()
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    static var mainStoryboard: UIStoryboard {
//        return UIStoryboard(name: "LoginView", bundle: Bundle.main)
//    }
    
}
