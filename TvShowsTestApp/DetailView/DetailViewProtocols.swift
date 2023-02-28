import Foundation
import UIKit

protocol DetailViewViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: DetailViewPresenterProtocol? { get set }
    func showMovieList(dataMovie: DetailMovieResponse)
}

protocol DetailViewWireRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createDetailViewModule(data: Any, flow: Flow) -> UIViewController
}

protocol DetailViewPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: DetailViewViewProtocol? { get set }
    var interactor: DetailViewInteractorInputProtocol? { get set }
    var router: DetailViewWireRouterProtocol? { get set }
    func getInfoMovie(idMovie: Int)
}

protocol DetailViewInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRetrive(dataMovie: DetailMovieResponse)
}

protocol DetailViewInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: DetailViewInteractorOutputProtocol? { get set }
    func getMovie(idMovie: Int)
}
