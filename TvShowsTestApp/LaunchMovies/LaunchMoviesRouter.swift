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
        let alerta = UIAlertController(title: "What do you want to do", message: "View Profile", preferredStyle: .actionSheet)
        let accion1 = UIAlertAction(title: "Log out", style: .default) { _ in
            alerta.dismiss(animated: true, completion: nil) }
        let accion2 = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        alerta.addAction(accion1)
        alerta.addAction(accion2)
        view.present(alerta, animated: true, completion: nil)
    }
}
