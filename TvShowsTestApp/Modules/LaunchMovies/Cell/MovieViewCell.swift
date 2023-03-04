import UIKit

class MovieViewCell: UICollectionViewCell {
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10)
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 8)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieView: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor(hexString: "#20414d")
        view.clipsToBounds = false
        view.layer.cornerRadius = 12.0
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor(hexString: "#050609").cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let movieFavoriteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconFavoriteOff")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    var modelData: MovieEntity?
    let imgOff = UIImage(named: "iconFavoriteOff")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    let imgOn = UIImage(named: "iconFavoriteOn")?.withTintColor(.red, renderingMode: .alwaysOriginal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        self.contentView.backgroundColor = self.superview?.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(movieView)
        movieView.addSubview(movieImageView)
        movieView.addSubview(movieName)
        movieView.addSubview(movieDescription)
        movieView.addSubview(movieFavoriteImage)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(checkFavorite))
        movieFavoriteImage.addGestureRecognizer(gesture)
        self.movieFavoriteImage.image = imgOff
       
        NSLayoutConstraint.activate([
            movieFavoriteImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            movieFavoriteImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            movieFavoriteImage.widthAnchor.constraint(equalToConstant: 30),
            movieFavoriteImage.heightAnchor.constraint(equalToConstant: 30),
            
            movieView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            movieView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            movieImageView.leadingAnchor.constraint(equalTo: movieView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: movieView.trailingAnchor),
            
            movieImageView.topAnchor.constraint(equalTo: movieView.topAnchor),
            movieImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            movieName.leadingAnchor.constraint(equalTo: movieView.leadingAnchor, constant: 10),
            movieName.trailingAnchor.constraint(equalTo: movieView.trailingAnchor, constant: -5),
            movieName.topAnchor.constraint(greaterThanOrEqualTo: movieImageView.bottomAnchor, constant: 10),
            movieName.heightAnchor.constraint(equalToConstant: 15),
            
            movieDescription.leadingAnchor.constraint(equalTo: movieView.leadingAnchor, constant: 10),
            movieDescription.trailingAnchor.constraint(equalTo: movieView.trailingAnchor, constant: -5),
            movieDescription.heightAnchor.constraint(equalToConstant: 30),
            
            movieDescription.topAnchor.constraint(greaterThanOrEqualTo: movieName.bottomAnchor, constant: 15),
            movieDescription.bottomAnchor.constraint(equalTo: movieView.bottomAnchor, constant: -10)
            
        ])
    }
    
    func setInformation(model: MovieEntity) {
        guard let url = URL(string: Path.baseImage.stringURL + model.imageURL) else { return }
        movieImageView.load(url: url)
        movieName.text = model.title
        movieDescription.text = model.overview
        self.movieFavoriteImage.image = UIImage(named: "iconFavoriteOff")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        self.modelData = model
        isFavorite()
    }
    
    private func createMovieObjt(_ valueData: MovieEntity) {
        let movieAddedToTable = SQLiteCommands.insertRowMovie(valueData)
        
        if movieAddedToTable == true {
            self.movieFavoriteImage.image = UIImage(named: "iconFavoriteOn")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            print("se creo celda")
        } else {
            self.movieFavoriteImage.image = UIImage(named: "iconFavoriteOff")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            //showError("Error", message: "")
            print("no se pudo crear celda")
        }
    }
    
    @objc func checkFavorite() {
        
        print("check")
        guard let data = self.modelData else { return }
        let existNulable = SQLiteCommands.adviseWithRowsMovie(data)
        guard let exist = existNulable else { return }
        
        if exist {
            self.movieFavoriteImage.image = imgOff
            let _ = SQLiteCommands.deleteRowMovie(movieID: data.id)
        } else {
            self.movieFavoriteImage.image = imgOn
            createMovieObjt(data)
        }
    }
    
    func isFavorite(){
        guard let data = self.modelData else { return }
        let existNulable = SQLiteCommands.adviseWithRowsMovie(data)
        guard let exist = existNulable else { return }
        
        if exist {
            self.movieFavoriteImage.image = imgOn
        } else {
            self.movieFavoriteImage.image = imgOff
        }
    }
}
