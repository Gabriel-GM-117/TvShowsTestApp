import UIKit

class DetailProfileView: UIViewController {
    
    private let profileTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        label.textColor = .green
        label.text = "Profile"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defualtContactPhoto")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 120 / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .green
        label.text = Repository.userName
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleFavorites: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.textColor = .green
        label.text = "Favorite Shows"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var moviesDetailCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        }()

    // MARK: Properties
    var presenter: DetailProfilePresenterProtocol?
    var dataModel: [MovieEntity] = []

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.presentInfo()
        presenter?.presentDataMovies()
        setupViews()
        
    }
    
    func setupViews() {
        view.addSubview(profileTitle)
        view.addSubview(profileImage)
        view.addSubview(profileName)
        view.addSubview(titleFavorites)
        view.addSubview(moviesDetailCollectionView)
        moviesDetailCollectionView.delegate = self
        moviesDetailCollectionView.dataSource = self
        moviesDetailCollectionView.backgroundColor = self.view.backgroundColor
        view.backgroundColor = UIColor(hexString: "#27282b")

        NSLayoutConstraint.activate([
            profileTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            profileTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            profileTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            profileImage.topAnchor.constraint(equalTo: profileTitle.bottomAnchor, constant: 40),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            profileImage.heightAnchor.constraint(equalToConstant: 120),
            profileImage.widthAnchor.constraint(equalToConstant: 120),

            profileName.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: 20),
            profileName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileName.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            
            titleFavorites.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 100),
            titleFavorites.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleFavorites.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            moviesDetailCollectionView.topAnchor.constraint(equalTo: titleFavorites.bottomAnchor, constant: 15),
            moviesDetailCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            moviesDetailCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            moviesDetailCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}

extension DetailProfileView: DetailProfileViewProtocol {
    // TODO: implement view output methods
    func showInfoProfile(info: ResponseDetailUser) {
        guard let url = URL(string: Path.baseImage.stringURL + (info.avatar?.gravatar?.hash ?? "")) else { return }
        self.profileImage.load(url: url)
        profileName.text = info.name
    }
    
    func showMovieList(dataMovies: [MovieEntity]) {
        self.dataModel = dataMovies
        DispatchQueue.main.async {
            self.moviesDetailCollectionView.reloadData()
        }
    }
}

extension DetailProfileView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as? MovieViewCell else { return UICollectionViewCell() }
        cell.setInformation(model: self.dataModel[indexPath.row])
        return cell
    }

}

extension DetailProfileView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 320)
    }
}
