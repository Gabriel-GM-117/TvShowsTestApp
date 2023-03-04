import Foundation
import UIKit

protocol LaunchMoviesViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: LaunchMoviesPresenterProtocol? { get set }
    func showMovieList(dataMovies: [MovieEntity])
}

protocol LaunchMoviesRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createLaunchMoviesModule() -> UIViewController
    var view: LaunchMoviesViewProtocol? { get set }
    func showDetailView(data: Any, flow: Flow)
    func presentInfoPerfil()
}

protocol LaunchMoviesPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: LaunchMoviesViewProtocol? { get set }
    var interactor: LaunchMoviesInteractorInputProtocol? { get set }
    var router: LaunchMoviesRouterProtocol? { get set }
    func getInfoMovies(flow: CategoryFlow)
    func presentInfo(id: Int, flow: Flow)
    func showInfoPerfil()
    func closeSession()
}

protocol LaunchMoviesInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRetrive(dataMovies: [MovieEntity])
    func didRetrive(data: Any, flow: Flow)
}

protocol LaunchMoviesInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: LaunchMoviesInteractorOutputProtocol? { get set }
    func getMovies(flow: CategoryFlow)
    func getMovieDetail(idMovie: Int)
    func getTVShowDetail(idTVShow: Int)
    func logOut()
}
