import Foundation
import UIKit

class LaunchMoviesView: UIViewController {
  
    private let movieCategorySegmented: UISegmentedControl = {
        let segmentItems = [CategoryFlow.popular.title,
                            CategoryFlow.topRated.title,
                            CategoryFlow.onTV.title,
                            CategoryFlow.airingToday.title]
        let segmentedControl = UISegmentedControl(items: segmentItems)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0

        return segmentedControl
    }()
    
    private var moviesCollectionView: UICollectionView = {

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieViewCell")
        collectionView.backgroundColor = UIColor(hexString: "#21242e")
        return collectionView
        }()
    

    // MARK: Properties
    var presenter: LaunchMoviesPresenterProtocol?
    var dataModel: [MovieEntity] = []
    private var flowSegmentedControl = CategoryFlow.popular
  
     init() {
         super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presentInfo()
        configNavBar()
        setUpView()
        createTable()
    }
    
    private func createTable() {
        let database = SQLiteDatabase.sharedInstance
        database.createTableMovies()
    }
    
    
    private func configNavBar() {
        self.navigationController?.navigationBar.backgroundColor = UIColor(hexString: "#3b3e4d")
        self.navigationItem.title = "Tv Shows"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconList")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(buttonAction))
        self.navigationController?.navigationBar.barStyle = .default
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(hexString: "#3b3e4d")
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setUpView() {
        view.backgroundColor = UIColor(hexString: "#21242e")
        view.addSubview(movieCategorySegmented)
        movieCategorySegmented.addTarget(self, action: #selector(segmentedControlAction(_:)), for: .valueChanged)
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        view.addSubview(moviesCollectionView)
        view.addConstraint(NSLayoutConstraint(item: movieCategorySegmented,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: view.safeAreaLayoutGuide,
                                              attribute: .top,
                                              multiplier: 1,
                                              constant: 20))

        NSLayoutConstraint.activate([
            self.movieCategorySegmented.heightAnchor.constraint(equalToConstant: 50),
            self.movieCategorySegmented.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            self.movieCategorySegmented.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            self.moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            self.moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            self.moviesCollectionView.topAnchor.constraint(equalTo: self.movieCategorySegmented.bottomAnchor, constant: 20),

            self.moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func presentInfo() {
        presenter?.getInfoMovies(flow: .popular)
    }
    
    @objc private func segmentedControlAction(_ segmentedControl: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            presenter?.getInfoMovies(flow: .popular)
            self.flowSegmentedControl = .popular
            break
        case 1:
            presenter?.getInfoMovies(flow: .topRated)
            self.flowSegmentedControl = .topRated
            break
        case 2:
            presenter?.getInfoMovies(flow: .onTV)
            self.flowSegmentedControl = .onTV
            break
        case 3:
            presenter?.getInfoMovies(flow: .airingToday)
            self.flowSegmentedControl = .airingToday
            break
        default:
            break
        }
    }
    
    @objc private func buttonAction() {
        self.presenter?.showInfoPerfil()
    }
    
}

extension LaunchMoviesView: LaunchMoviesViewProtocol {
    // TODO: implement view output methods
    func showMovieList(dataMovies: [MovieEntity]) {
        self.dataModel = dataMovies
        DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
        }
    }
}


extension LaunchMoviesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as? MovieViewCell else { return UICollectionViewCell() }
        cell.setInformation(model: self.dataModel[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = self.dataModel[indexPath.row].id
        switch self.flowSegmentedControl {
        case .popular:
            presenter?.presentInfo(id: id, flow: Flow.movie)
        case .topRated:
            presenter?.presentInfo(id: id, flow: Flow.movie)
        case .onTV:
            presenter?.presentInfo(id: id, flow: Flow.tvShow)
        case .airingToday:
            presenter?.presentInfo(id: id, flow: Flow.tvShow)
        }
    }
}

extension LaunchMoviesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 320)
    }
}
