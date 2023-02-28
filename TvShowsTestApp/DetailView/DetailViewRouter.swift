//
//  DetailViewWireFrame.swift
//  TvShowsTestApp
//
//  Created by Gabriel GM on 26/02/23.
//  
//

import Foundation
import UIKit

class DetailViewRouter: DetailViewWireRouterProtocol {

    static func createDetailViewModule(data: Any, flow: Flow) -> UIViewController {
//        let navController = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewView")
        let view = DetailViewVC(data: data, flow: flow)
//        {
            let presenter: DetailViewPresenterProtocol & DetailViewInteractorOutputProtocol = DetailViewPresenter()
            let interactor: DetailViewInteractorInputProtocol = DetailViewInteractor()
//            let localDataManager: DetailViewLocalDataManagerInputProtocol = DetailViewLocalDataManager()
//            let remoteDataManager: DetailViewRemoteDataManagerInputProtocol = DetailViewRemoteDataManager()
            let router: DetailViewWireRouterProtocol = DetailViewRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
//            interactor.localDatamanager = localDataManager
//            interactor.remoteDatamanager = remoteDataManager
//            remoteDataManager.remoteRequestHandler = interactor
            
            return view
//        }
//        return UIViewController()
    }
    
//    static var mainStoryboard: UIStoryboard {
//        return UIStoryboard(name: "DetailViewView", bundle: Bundle.main)
//    }
    
}
