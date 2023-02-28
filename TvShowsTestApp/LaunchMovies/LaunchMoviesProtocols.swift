//
//  LaunchMoviesProtocols.swift
//  TvShowsTestApp
//
//  Created by Gabriel GM on 24/02/23.
//  
//

import Foundation
import UIKit

protocol LaunchMoviesViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: LaunchMoviesPresenterProtocol? { get set }
    
    func showMovieList(dataMovies: [PopularMoviesEntity])
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
 
    
}


protocol LaunchMoviesInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRetrive(dataMovies: [PopularMoviesEntity])
    func didRetrive(data: Any, flow: Flow)
//    func didRetriveTvShow(data: DetailTvShowResponse)
}


protocol LaunchMoviesInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: LaunchMoviesInteractorOutputProtocol? { get set }
//    var service: TheMovieDBService { get }

    func getMovies(flow: CategoryFlow)
    func getMovieDetail(idMovie: Int)
    func getTVShowDetail(idTVShow: Int)
}




