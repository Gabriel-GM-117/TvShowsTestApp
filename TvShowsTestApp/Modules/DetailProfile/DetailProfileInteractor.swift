import Foundation

class DetailProfileInteractor: DetailProfileInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: DetailProfileInteractorOutputProtocol?
    private let service = TheMovieDBService()
    
    func getInfoProfileDetail() {
        self.service.getInfoProfile { [weak self] result in
            switch result {
            case .success( let result):
                guard let data = result else { return }
                self?.presenter?.didRetrive(infoProfile: data)
            case .failure(_): break
            }
        }
    }
    
    func getMovies() {
        guard let db = SQLiteCommands.presentRowsMovies() else { return }
        presenter?.didRetrive(dataMovies: db)
    }
    
}

