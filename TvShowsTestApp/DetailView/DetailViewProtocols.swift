//
//  DetailViewProtocols.swift
//  TvShowsTestApp
//
//  Created by Gabriel GM on 26/02/23.
//  
//

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
//    func viewDidLoad()
}

protocol DetailViewInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    
    func didRetrive(dataMovie: DetailMovieResponse)
}

protocol DetailViewInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: DetailViewInteractorOutputProtocol? { get set }
    
    func getMovie(idMovie: Int)
//    var localDatamanager: DetailViewLocalDataManagerInputProtocol? { get set }
//    var remoteDatamanager: DetailViewRemoteDataManagerInputProtocol? { get set }
}

//protocol DetailViewDataManagerInputProtocol: AnyObject {
//    // INTERACTOR -> DATAMANAGER
//}
//
//protocol DetailViewRemoteDataManagerInputProtocol: AnyObject {
//    // INTERACTOR -> REMOTEDATAMANAGER
//    var remoteRequestHandler: DetailViewRemoteDataManagerOutputProtocol? { get set }
//}
//
//protocol DetailViewRemoteDataManagerOutputProtocol: AnyObject {
//    // REMOTEDATAMANAGER -> INTERACTOR
//}
//
//protocol DetailViewLocalDataManagerInputProtocol: AnyObject {
//    // INTERACTOR -> LOCALDATAMANAGER
//}
