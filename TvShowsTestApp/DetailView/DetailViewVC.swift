//
//  DetailViewView.swift
//  TvShowsTestApp
//
//  Created by Gabriel GM on 26/02/23.
//  
//

import Foundation
import UIKit

class DetailViewVC: UIViewController {
    
    let movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
//        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let movieDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10)
        label.textColor = .lightGray
//        label.backgroundColor = .cyan
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
//            .scaleAspectFill
        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 12.0
//        label.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieGenre: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .white
//        label.backgroundColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10)
        label.textColor = .white
        
//        label.backgroundColor = .brown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moviePopularity: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
//        label.backgroundColor = .magenta
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieVoteAverage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
//        label.backgroundColor = .blue
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
//        collectionView.backgroundColor = self.view.backgroundColor
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
//            self.dataMovie = data as? DetailMovieResponse
            self.dataTvShow = nil
            self.flow = flow
        case .tvShow:
            guard let dataInfo = data as? DetailTvShowResponse else { return }
            self.dataTvShow = dataInfo
//            self.dataTvShow = data as? DetailTvShowResponse
            self.dataMovie = nil
            self.flow = flow
        }
//        if flow == 1 {
//            self.dataMovie = data as? DetailMovieResponse
//            self.dataTvShow = nil
//            self.flow = flow
//        } else {
//            self.dataTvShow = data as? DetailTvShowResponse
//            self.dataMovie = nil
//            self.flow = flow
//        }
//        self.idMovie = idMovie
//        self.dataInformation = dataMovie
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

    // MARK: Lifecycle
    
//    override func loadView() {
//        super.loadView()
//        self.view.backgroundColor = UIColor(hexString: "#1b202e")
//
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#21242e")
//        view.backgroundColor = .cyan
        setUpView()
//        presenter?.getInfoMovie(idMovie: idMovie)
//        if flow == 1 {
//            setUpInfoMovie()
//        } else {
//            setUpInfoTvShow()
//        }
        switch self.flow {
        case .movie:
            setUpInfoMovie()
        case .tvShow:
            setUpInfoTvShow()
        case .none:
            break
        }
//        setUpInformationMovie()
        
        
    }
    
    
    private func setUpView() {
  
//        productionCompaniesCollectionView.delegate = self
//        productionCompaniesCollectionView.dataSource = self
//        view.backgroundColor = UIColor(hexString: "#050609")
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
        
        
//        view.addConstraint(NSLayoutConstraint(item: movieCategorySegmented,
//                                              attribute: .top,
//                                              relatedBy: .equal,
//                                              toItem: view.safeAreaLayoutGuide,
//                                              attribute: .top,
//                                              multiplier: 1,
//                                              constant: 20))

        
        NSLayoutConstraint.activate([
//            self.movieCategorySegmented.heightAnchor.constraint(equalToConstant: 50),
            self.movieName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            self.movieName.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            self.movieName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            self.movieName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            self.movieName.heightAnchor.constraint(equalToConstant: 30),
            

            self.movieDate.topAnchor.constraint(equalTo: self.movieName.bottomAnchor, constant: 10),
            self.movieDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            self.movieDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
//            self.movieDate.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            self.movieDate.heightAnchor.constraint(equalToConstant: 20),
            
            self.movieImageView.topAnchor.constraint(equalTo: self.movieDate.bottomAnchor, constant: 20),
            self.movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
//            self.movieImageView.trailingAnchor.constraint(equalTo: self.movieGenre.leadingAnchor, constant: 15),
//            self.movieImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.movieImageView.heightAnchor.constraint(equalToConstant: 180),
            self.movieImageView.widthAnchor.constraint(equalToConstant: 120),
            
            
            self.movieGenre.topAnchor.constraint(equalTo: self.movieDate.bottomAnchor, constant: 20),
            self.movieGenre.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            //self.movieGenre.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            self.movieGenre.heightAnchor.constraint(equalToConstant: 20),
//            self.movieGenre.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            greaterThanOrEqualTo
            
            self.movieDescription.topAnchor.constraint(equalTo: self.movieGenre.bottomAnchor, constant: 10),
            self.movieDescription.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            self.movieDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            self.movieDescription.heightAnchor.constraint(equalToConstant: 120),
//            self.movieDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            self.moviePopularity.topAnchor.constraint(equalTo: self.movieImageView.bottomAnchor, constant: 20),
            self.moviePopularity.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            self.moviePopularity.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            self.moviePopularity.heightAnchor.constraint(equalToConstant: 30),
//            self.moviePopularity.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            self.movieVoteAverage.topAnchor.constraint(equalTo: self.moviePopularity.bottomAnchor, constant: 20),
            self.movieVoteAverage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            self.movieVoteAverage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            //self.movieVoteAverage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            self.movieVoteAverage.heightAnchor.constraint(equalToConstant: 30),
            
            self.productionCompaniesCollectionView.topAnchor.constraint(equalTo: self.movieVoteAverage.bottomAnchor, constant: 20),
            self.productionCompaniesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            self.productionCompaniesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            self.productionCompaniesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
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
//        movieImageView.image
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
//        movieImageView.image
    }
}

extension DetailViewVC: DetailViewViewProtocol {
   
    
    // TODO: implement view output methods
    
    func showMovieList(dataMovie: DetailMovieResponse) {
        print("informacion de pelicula: \(dataMovie)")
//        self.dataInformation = dataMovie
       
    }
}


extension DetailViewVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataMovie?.productionCompanies.count ?? dataTvShow?.productionCompanies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMovieCell", for: indexPath) as? DetailMovieCell else { return UICollectionViewCell() }
//
        
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
//        return CGSize(width: myCellWidth, height: myCellWidth)
        return CGSize(width: 160, height: 160)
    }
}
