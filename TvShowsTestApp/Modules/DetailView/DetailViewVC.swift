import Foundation
import UIKit

class DetailViewVC: UIViewController {
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let movieDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieGenre: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moviePopularity: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieVoteAverage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var productionCompaniesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.register(DetailMovieCell.self, forCellWithReuseIdentifier: "DetailMovieCell")
        return collectionView
        }()
    

    // MARK: Properties
    var presenter: DetailViewPresenterProtocol?
    var dataMovie: DetailMovieResponse!
    var dataTvShow: DetailTvShowResponse!
    var idMovie: Int = 0
    var flow: Flow!
    
    init(data: Any, flow: Flow) {
        super.init(nibName: nil, bundle: nil)
        switch flow {
        case .movie:
            guard let dataInfo = data as? DetailMovieResponse else { return }
            self.dataMovie = dataInfo
            self.dataTvShow = nil
            self.flow = flow
        case .tvShow:
            guard let dataInfo = data as? DetailTvShowResponse else { return }
            self.dataTvShow = dataInfo
            self.dataMovie = nil
            self.flow = flow
        }
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#21242e")
        setUpView()
        switch self.flow {
        case .movie:
            setUpInfoMovie()
        case .tvShow:
            setUpInfoTvShow()
        case .none:
            break
        }
    }
    
    private func setUpView() {
        view.addSubview(movieName)
        view.addSubview(movieDate)
        view.addSubview(movieImageView)
        view.addSubview(movieGenre)
        view.addSubview(movieDescription)
        view.addSubview(moviePopularity)
        view.addSubview(movieVoteAverage)
        view.addSubview(productionCompaniesCollectionView)
        
        productionCompaniesCollectionView.delegate = self
        productionCompaniesCollectionView.dataSource = self
        productionCompaniesCollectionView.backgroundColor = self.view.backgroundColor
 
        NSLayoutConstraint.activate([
            self.movieName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.movieName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            self.movieName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            self.movieName.heightAnchor.constraint(equalToConstant: 30),
            
            self.movieDate.topAnchor.constraint(equalTo: self.movieName.bottomAnchor, constant: 10),
            self.movieDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            self.movieDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            self.movieDate.heightAnchor.constraint(equalToConstant: 20),
            
            self.movieImageView.topAnchor.constraint(equalTo: self.movieDate.bottomAnchor, constant: 20),
            self.movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            self.movieImageView.heightAnchor.constraint(equalToConstant: 180),
            self.movieImageView.widthAnchor.constraint(equalToConstant: 120),
            
            self.movieGenre.topAnchor.constraint(equalTo: self.movieDate.bottomAnchor, constant: 20),
            self.movieGenre.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            self.movieGenre.heightAnchor.constraint(equalToConstant: 20),

            self.movieDescription.topAnchor.constraint(equalTo: self.movieGenre.bottomAnchor, constant: 10),
            self.movieDescription.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            self.movieDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            self.movieDescription.heightAnchor.constraint(equalToConstant: 120),
            
            self.moviePopularity.topAnchor.constraint(equalTo: self.movieImageView.bottomAnchor, constant: 20),
            self.moviePopularity.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            self.moviePopularity.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            self.moviePopularity.heightAnchor.constraint(equalToConstant: 30),
            
            self.movieVoteAverage.topAnchor.constraint(equalTo: self.moviePopularity.bottomAnchor, constant: 20),
            self.movieVoteAverage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            self.movieVoteAverage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            self.movieVoteAverage.heightAnchor.constraint(equalToConstant: 30),
            
            self.productionCompaniesCollectionView.topAnchor.constraint(equalTo: self.movieVoteAverage.bottomAnchor, constant: 20),
            self.productionCompaniesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            self.productionCompaniesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            self.productionCompaniesCollectionView.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    private func setUpInfoMovie() {
        movieName.text = dataMovie?.title
        movieDate.text = dataMovie?.releaseDate
        guard let url = URL(string: Path.baseImage.stringURL + (dataMovie?.backdropPath ?? "")) else { return }
        movieImageView.load(url: url)
        movieGenre.text = dataMovie?.genres.first?.name
        movieDescription.text = dataMovie?.overview
        moviePopularity.text = "Popularidad: 🌐  \(dataMovie?.popularity ?? 0.0)"
        movieVoteAverage.text = "Votos: ⭐️ \(dataMovie?.voteAverage ?? 00)"
    }
    
    private func setUpInfoTvShow() {
        movieName.text = dataTvShow?.name
        movieDate.text = dataTvShow?.firstAirDate ?? dataTvShow?.lastAirDate
        guard let url = URL(string: Path.baseImage.stringURL + (dataTvShow?.posterPath ?? "")) else { return }
        movieImageView.load(url: url)
        movieGenre.text = dataTvShow?.genresTvShow?.first?.name
        movieDescription.text = dataTvShow?.overview
        moviePopularity.text = "Popularidad: 🌐  \(dataTvShow?.popularity ?? 0.0)"
        movieVoteAverage.text = "Votos: ⭐️ \(dataTvShow?.voteAverage ?? 00)"
    }
}

extension DetailViewVC: DetailViewViewProtocol {
   
    // TODO: implement view output methods
    func showMovieList(dataMovie: DetailMovieResponse) {
        //
    }
}


extension DetailViewVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataMovie?.productionCompanies.count ?? dataTvShow?.productionCompanies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMovieCell", for: indexPath) as? DetailMovieCell else { return UICollectionViewCell() }
        
        switch self.flow {
        case .movie:
            cell.setInformation(dataInfo: dataMovie?.productionCompanies[indexPath.row])
        case .tvShow:
            cell.setInformation(dataInfo: dataTvShow?.productionCompanies?[indexPath.row])
        case .none:
            break
        }

        return cell
    }
}

extension DetailViewVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
}
