import UIKit

class DetailMovieCell: UICollectionViewCell {
    
    let productionCompanieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let productionCompanieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(productionCompanieImageView)
        self.contentView.addSubview(productionCompanieName)

        NSLayoutConstraint.activate([
            productionCompanieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productionCompanieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productionCompanieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            productionCompanieName.topAnchor.constraint(equalTo: productionCompanieImageView.bottomAnchor, constant: 20),
            productionCompanieName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productionCompanieName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            productionCompanieName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            productionCompanieName.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    
    func setInformation(dataInfo: DetailDataCell?) {
        guard let url = URL(string: Path.baseImage.stringURL + (dataInfo?.imageURL ?? "")) else { return }
        self.productionCompanieImageView.load(url: url)
        self.productionCompanieName.text = dataInfo?.name
    }
    
    func setInformation(dataInfo: ProductionCompany?) {
        guard let url = URL(string: Path.baseImage.stringURL + (dataInfo?.logoPath ?? "")) else { return }
        self.productionCompanieImageView.load(url: url)
        self.productionCompanieName.text = dataInfo?.name
    }
}
