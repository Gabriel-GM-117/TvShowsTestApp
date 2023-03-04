import Foundation
import UIKit

class LaunchMoviesRouter: LaunchMoviesRouterProtocol {
   
    weak var view: LaunchMoviesViewProtocol?
    
    static func createLaunchMoviesModule() -> UIViewController {
        let view = LaunchMoviesView()
        let presenter: LaunchMoviesPresenterProtocol & LaunchMoviesInteractorOutputProtocol = LaunchMoviesPresenter()
        let interactor: LaunchMoviesInteractorInputProtocol = LaunchMoviesInteractor()
        let router: LaunchMoviesRouterProtocol = LaunchMoviesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.view = view
        return view
    }
    
    func showDetailView(data: Any, flow: Flow) {
        guard let view = self.view as? UIViewController else { return }
        DispatchQueue.main.async {
            let vc = DetailViewRouter.createDetailViewModule(data: data, flow: flow)
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func presentInfoPerfil() {
        guard let view = self.view as? UIViewController else { return }
        let alert = UIAlertController(title: "What do you want to do", message: "", preferredStyle: .actionSheet)
        let actionOne = UIAlertAction(title: "View Profile", style: .default) { _ in
            let vc = DetailProfileRouter.createDetailProfileModule()
            view.present(vc, animated: true)
        }
        let actionTwo = UIAlertAction(title: "Log out", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
            self.view?.presenter?.closeSession()
            if Repository.authSessionFlag {
                view.navigationController?.popToRootViewController(animated: true)
            } else {
                view.navigationController?.popToRootViewController(animated: true)
            }
        }
        actionTwo.setValue(UIColor.red, forKey: "titleTextColor")
        let actionThree = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        alert.addAction(actionThree)
        view.present(alert, animated: true, completion: nil)
    }
}
