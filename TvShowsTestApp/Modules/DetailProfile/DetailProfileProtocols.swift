import Foundation
import UIKit

protocol DetailProfileViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: DetailProfilePresenterProtocol? { get set }
    func showInfoProfile(info: ResponseDetailUser)
    func showMovieList(dataMovies: [MovieEntity])
}

protocol DetailProfileRouterProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createDetailProfileModule() -> UIViewController
    var view: DetailProfileViewProtocol? { get set }
}

protocol DetailProfilePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: DetailProfileViewProtocol? { get set }
    var interactor: DetailProfileInteractorInputProtocol? { get set }
    var router: DetailProfileRouterProtocol? { get set }
    func presentInfo()
    func presentDataMovies()
}

protocol DetailProfileInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRetrive(dataMovies: [MovieEntity])
    func didRetrive(infoProfile: ResponseDetailUser)
}

protocol DetailProfileInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: DetailProfileInteractorOutputProtocol? { get set }
    func getInfoProfileDetail()
    func getMovies()
}

