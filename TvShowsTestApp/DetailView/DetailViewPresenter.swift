//
//  DetailViewPresenter.swift
//  TvShowsTestApp
//
//  Created by Gabriel GM on 26/02/23.
//  
//

import Foundation

class DetailViewPresenter: DetailViewPresenterProtocol  {
    
    
   
    
    // MARK: Properties
    weak var view: DetailViewViewProtocol?
    var interactor: DetailViewInteractorInputProtocol?
    var router: DetailViewWireRouterProtocol?
    
    func getInfoMovie(idMovie: Int) {
        interactor?.getMovie(idMovie: idMovie)
    }
    
    
}

//extension DetailViewPresenter: DetailViewPresenterProtocol {
//    // TODO: implement presenter methods
//    func viewDidLoad() {
//    }
//}

extension DetailViewPresenter: DetailViewInteractorOutputProtocol {
    
    
    // TODO: implement interactor output methods
    
    func didRetrive(dataMovie: DetailMovieResponse) {
        view?.showMovieList(dataMovie: dataMovie)
    }
}
