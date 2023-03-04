import Foundation
import ProgressHUD

class LoginPresenter: LoginPresenterProtocol  {
    
    // MARK: Properties
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    
    func loadInfo() {
        interactor?.getToken()
    }
    
    func requestAgain() {
        ProgressHUD.show("Loading")
        ProgressHUD.fontStatus = .boldSystemFont(ofSize: 20)
        let token = Repository.tokenAuth?.requestToken
        interactor?.getAuthUser(token: token ?? "")
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {

    // TODO: implement interactor output methods
    func didRetrive(data: AuthToken) {
        guard let token = data.requestToken else { return }
        interactor?.getAuth(token: token)
    }
    
    func didRetrive(data: AuthSessionResponse) {
        print("data: \(data)")
    }
    
    func didRetrive(failure: Bool) {
        view?.showFailure(failure: failure)
    }
    
    func didShowErro(failure: Bool) {
        view?.showViewError(failure: failure)
    }
    
    func didFlow() {
        router?.showFow()
    }
}
