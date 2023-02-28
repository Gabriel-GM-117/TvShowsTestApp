//
//  DetailViewInteractor.swift
//  TvShowsTestApp
//
//  Created by Gabriel GM on 26/02/23.
//  
//

import Foundation

class DetailViewInteractor: DetailViewInteractorInputProtocol {
  
    

    // MARK: Properties
    weak var presenter: DetailViewInteractorOutputProtocol?
//    var localDatamanager: DetailViewLocalDataManagerInputProtocol?
//    var remoteDatamanager: DetailViewRemoteDataManagerInputProtocol?
    private let service = TheMovieDBService()
    
    func getMovie(idMovie: Int) {
        service.getDetailfMovie(idMovie: idMovie) { [weak self] result in
            switch result {
            case .success(let success):
                print("exito \(String(describing: success))")
                guard let objResp = success else { return
                    // self?.presenter?.didShowError(error)
                }
                self?.presenter?.didRetrive(dataMovie: objResp)
            case .failure(let failure):
                print("error\(failure)")
            }
        }
    }

}

//extension DetailViewInteractor: DetailViewRemoteDataManagerOutputProtocol {
//    // TODO: Implement use case methods
//}
