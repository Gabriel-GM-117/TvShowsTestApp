
import Foundation

class LoginInteractor: LoginInteractorInputProtocol {
    

    // MARK: Properties
    weak var presenter: LoginInteractorOutputProtocol?
    private let service = TheMovieDBService()

    func getToken() {
        self.service.getToken { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    print("exito \(String(describing: success))")
                    guard let objResp = success else { return
                    }
                    
                    Repository.tokenAuth = objResp
                    let defaults = UserDefaults.standard
                    defaults.set(objResp.requestToken, forKey: "Auth")

                    self?.getAuth(token: objResp.requestToken ?? "")

                case .failure(let failure):
                    print("error\(failure)")
                }
            }
        }
    }
    
    func getAuth(token: String) {
        self.service.getAuth(strToken: token) { [weak self] result in
            switch result {
            case .success(let success):
                guard let objResp = success else { return }

                self?.presenter?.didFlow()
            case .failure(let failure):
                self?.presenter?.didRetrive(failure: true)
            }
        }
    }
    
    func getAuthUser(token: String) {
        self.service.getAuthUser(strToken: token) {  [weak self] result in
            switch result {
            case .success(let success):
                guard let objResp = success else { return }
     
                self?.presenter?.didFlow()
            case .failure(let failure):
                print("error\(failure)")
                self?.presenter?.didShowErro(failure: false)
            }
        }
    }
}

