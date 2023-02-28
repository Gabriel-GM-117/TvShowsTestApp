
import Foundation
import UIKit

protocol LoginViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: LoginPresenterProtocol? { get set }
    func showFailure(failure: Bool)
    func showViewError(failure: Bool)
    
}

protocol LoginRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    
    static func createLoginModule() -> UIViewController
    var view: LoginViewProtocol? { get set }
    func showFow()
    
}

protocol LoginPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    
    func btnAction()
    func requestAgain()
}

protocol LoginInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func didRetrive(data: AuthToken)
    func didRetrive(data: AuthSessionResponse)
    func didRetrive(failure: Bool)
    func didShowErro(failure: Bool)
    func didFlow()
}

protocol LoginInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: LoginInteractorOutputProtocol? { get set }
    
    func getToken()
    func getAuth(token: String)
    func getAuthUser(token: String)

}
