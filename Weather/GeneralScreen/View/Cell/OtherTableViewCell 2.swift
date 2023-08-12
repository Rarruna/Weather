import UIKit

class OtherTableViewCell: UITableViewCell {

    static let reuseId = "HourCell"
    var collectionView = HourCollectionView()
    
    lazy var blackColor = UIColor(red: 0.166, green: 0.175, blue: 0.2, alpha: 1)
    lazy var grayColor =   UIColor(red: 0.561, green: 0.588, blue: 0.631, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        dateLabel.text = ""
        weekdayLabel.text = ""
        maxTempLabel.text = ""
        minTempLabel.text = ""
        weatherIcon.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
        collectionView.collectionViewLayout.collectionView?.reloadData()
    }

    private func setupView() {
        self.addSubview(backView)
        backView.addSubview(dateLabel)
        backView.addSubview(weekdayLabel)
        backView.addSubview(minTempLabel)
        backView.addSubview(maxTempLabel)
        backView.addSubview(weatherIcon)
        backView.addSubview(separatorView)
        backView.addSubview(collectionView)
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(-16)
            make.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(-8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.left.equalTo(backView).inset(20)
            make.right.equalTo(weekdayLabel).inset(1)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(backView).inset(20)
        }
        
        maxTempLabel.snp.makeConstraints { make in
            make.top.equalTo(backView).inset(20)
        }
        
        minTempLabel.snp.makeConstraints { make in
            make.top.equalTo(backView).inset(20)
            make.left.equalTo(maxTempLabel).inset(8)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(backView).inset(16)
            make.left.equalTo(minTempLabel).inset(16)
            make.right.equalTo(backView).inset(-20)
            make.height.equalTo(24)
            make.width.equalTo(30)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel).inset(20)
            make.centerX.equalTo(backView)
            make.width.equalTo(280)
            make.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(backView).inset(60)
            make.left.right.bottom.equalTo(backView)
        }
        
//        NSLayoutConstraint.activate([
//            
//            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
//            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
//            
//            dateLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
//            dateLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
//            dateLabel.trailingAnchor.constraint(equalTo: weekdayLabel.leadingAnchor, constant: 1),
//            
//            weekdayLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
//            
//            maxTempLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
//
//            minTempLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
//            minTempLabel.leadingAnchor.constraint(equalTo: maxTempLabel.trailingAnchor, constant: 8),
//            
//            weatherIcon.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16),
//            weatherIcon.leadingAnchor.constraint(equalTo: minTempLabel.trailingAnchor, constant: 16),
//            weatherIcon.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
//            weatherIcon.heightAnchor.constraint(equalToConstant: 24),
//            weatherIcon.widthAnchor.constraint(equalToConstant: 30),
//            
//            separatorView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
//            separatorView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
//            separatorView.widthAnchor.constraint(equalToConstant: 280),
//            separatorView.heightAnchor.constraint(equalToConstant: 1),
//            
//            collectionView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 60),
//            collectionView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 0),
//            collectionView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 0),
//            collectionView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 0)
//
//        ])
    }
    
    func configure(with cellModel: OtherCellModel) {
        
        self.dateLabel.text = "\(cellModel.date), "
        self.weekdayLabel.text = " \(cellModel.weekday)"
        self.minTempLabel.text = String("\(cellModel.minTemp)°")
        self.maxTempLabel.text = String("\(cellModel.maxTemp)°")
        self.weatherIcon.image = UIImage(named: cellModel.icon)
    }
    
    private(set) lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        let viewBackgroundColor = UIColor(red: 0.955, green: 0.96, blue: 0.971, alpha: 1)
        view.backgroundColor = viewBackgroundColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = blackColor
        
        return label
    }()
    
    private(set) lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = grayColor
        
        return label
    }()
    
    private(set) lazy var maxTempLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.preferredFont(forTextStyle: .title2)
         label.font = .boldSystemFont(ofSize: 16)
         label.numberOfLines = 1
         label.textColor = blackColor
         
         return label
     }()
    
    private(set) lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = grayColor
        
        return label
    }()

    private(set) lazy var weatherIcon: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor.systemRed
        return imageView
    }()
    
    private(set) lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.852, green: 0.877, blue: 0.917, alpha: 1).cgColor
        return view
    }()
}
