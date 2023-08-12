import UIKit
import SnapKit

class FirstTableViewCell: UITableViewCell {
    
    static let reuseId = "TodayCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(backView)
        self.addSubview(semicircleView)
        self.addSubview(dateLabel)
        self.addSubview(weatherIcon)
        self.addSubview(tempLabel)
        self.addSubview(descriptionLabel)
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.right.equalToSuperview().inset(-16)
            make.left.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(backView).inset(0)
            make.bottom.equalTo(weatherIcon).inset(13)
            make.centerX.equalTo(backView)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(backView).inset(80)
            make.centerX.equalTo(backView)
            make.height.width.equalTo(110)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backView)
            make.bottom.equalTo(descriptionLabel).inset(-30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel).inset(10)
            make.centerX.equalTo(backView)
            make.bottom.equalTo(backView).inset(-25)
        }
        
        semicircleView.snp.makeConstraints { make in
            make.centerX.equalTo(backView)
            make.bottom.equalTo(backView)
            make.width.equalTo(backView)
            make.height.equalTo(backView).inset(174)
        }

//        NSLayoutConstraint.activate([
//            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
//            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
//            
//            dateLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 0),
//            dateLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
//            dateLabel.bottomAnchor.constraint(equalTo: weatherIcon.topAnchor, constant: 13),
//            
//            weatherIcon.topAnchor.constraint(equalTo: backView.topAnchor, constant: 80),
//            weatherIcon.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
//            weatherIcon.heightAnchor.constraint(equalToConstant: 110),
//            weatherIcon.widthAnchor.constraint(equalToConstant: 110),
//
//            tempLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
//            tempLabel.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -30),
//            
//            descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
//            descriptionLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
//            descriptionLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -25),
//            
//            semicircleView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
//            semicircleView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 0),
//            semicircleView.widthAnchor.constraint(equalTo: backView.widthAnchor),
//            semicircleView.heightAnchor.constraint(equalToConstant: 174)
//            
//        ])
    }
    
    override func layoutSubviews() {
        self.layer.masksToBounds = true
        gradientLayerBackView.frame = bounds
        gradientLayerSemicircleView.frame = bounds
    }
    
    override func prepareForReuse() {
        dateLabel.text = ""
        tempLabel.text = ""
        descriptionLabel.text = ""
        weatherIcon.image = nil
    }
    
    func configure(with cellModel: ByDate) {
        self.dateLabel.text = cellModel.date
        self.weatherIcon.image = UIImage(named: cellModel.icon)
        self.tempLabel.text = cellModel.temp
        self.descriptionLabel.text = cellModel.descr
    }

    private(set) lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        view.layer.insertSublayer(gradientLayerBackView, at: 0)
        view.layer.cornerRadius = 24
        return view
    }()
    
    private(set) lazy var semicircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.insertSublayer(gradientLayerSemicircleView, at: 0)
        view.alpha = 0.9
        view.bounds = CGRect(x: 0, y: 0, width: 400, height: 320)
        let xPoint = CGFloat(view.bounds.size.width / 2)
        let yPoint = CGFloat(view.bounds.size.height / 1.6)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: xPoint, y: yPoint), radius: view.bounds.size.width / 2, startAngle: .pi, endAngle: .pi * 2, clockwise: true)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        view.layer.mask = circleShape
        view.layer.cornerRadius = 24
 
        return view
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .white
        
        return label
    }()
    
    private(set) lazy var weatherIcon: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.systemRed
        imageView.bounds = CGRect(x: 80, y: 80, width: 80, height: 80)
        return imageView
    }()
    
    private(set) lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 48)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private lazy var gradientLayerBackView: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(red: 0.354, green: 0.677, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.267, green: 0.633, blue: 1, alpha: 1).cgColor
        ]
        return gradientLayer
    }()
    
    private lazy var gradientLayerSemicircleView: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
          UIColor(red: 0.25, green: 0.608, blue: 0.967, alpha: 1).cgColor,
          UIColor(red: 0.25, green: 0.608, blue: 0.967, alpha: 0).cgColor
        ]
        gradientLayer.locations = [0, 0.8]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradientLayer.bounds = backView.bounds.insetBy(dx: -0.5*backView.bounds.size.width, dy: -0.5*backView.bounds.size.height)
        
        return gradientLayer
    }()
}
