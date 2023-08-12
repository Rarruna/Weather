import UIKit
import SnapKit

class FirstTableViewCell: UITableViewCell {
    static let reuseId = "TodayCell"
    
    private let backView = UIView()
    private let semicircleView = UIView()
    private let dateLabel = UILabel()
    private let weatherIcon = UIImageView()
    private let temperatureLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.masksToBounds = true
        setupBackground()
        setupSemicircle()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = ""
        temperatureLabel.text = ""
        descriptionLabel.text = ""
        weatherIcon.image = nil
    }
    
    func configure(with cell: ByDate) {
        dateLabel.text = cell.todayDate
        weatherIcon.image = UIImage(named: cell.icon)
        temperatureLabel.text = cell.temperature
        descriptionLabel.text = cell.description
    }
}

//MARK: - Private methods -
private extension FirstTableViewCell {
    func setupView() {
        addSubview(backView)
        backView.addSubview(semicircleView)
        backView.addSubview(dateLabel)
        backView.addSubview(weatherIcon)
        backView.addSubview(temperatureLabel)
        backView.addSubview(descriptionLabel)
        
        setupConstraints()
        setupDateLabel()
        setupWeatherIcon()
        setupDescriptionLabel()
        setupTemperatureLabel()
    }
    
    func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
            make.size.equalTo(110)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherIcon).inset(130)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
        
        semicircleView.snp.makeConstraints { make in
            make.centerX.width.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func setupBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.brightBlue.cgColor,
            UIColor.lightBlue.cgColor
        ]
        gradient.cornerRadius = backView.layer.cornerRadius
        gradient.frame = backView.bounds
        backView.contentMode = .scaleToFill
        backView.layer.cornerRadius = 24
        backView.layer.insertSublayer(gradient, at: 0)
    }
    
    func setupSemicircle() {
        semicircleView.clipsToBounds = true
        semicircleView.alpha = 0.9
        let xPoint = CGFloat(semicircleView.bounds.size.width / 2)
        let yPoint = CGFloat(semicircleView.bounds.size.height)
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: xPoint, y: yPoint),
            radius: semicircleView.bounds.size.width / 2,
            startAngle: .pi,
            endAngle: .pi * 2,
            clockwise: true
        )
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        semicircleView.layer.mask = circleShape
        semicircleView.layer.cornerRadius = backView.layer.cornerRadius
        setupGradient()
    }
    
    func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor.semicircleBlueColor,
            UIColor.semicircleBlueColorTransparent
        ]
        gradient.locations = [0, 0.8]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        semicircleView.layer.insertSublayer(gradient, at: 0)
    }
    
    func setupDateLabel() {
        dateLabel.font = .preferredFont(forTextStyle: .title2)
        dateLabel.font = .boldSystemFont(ofSize: 14)
        dateLabel.numberOfLines = 1
        dateLabel.textColor = .white
    }
    
    func setupWeatherIcon() {
        weatherIcon.clipsToBounds = true
        weatherIcon.contentMode = .scaleAspectFit
    }
    
    func setupDescriptionLabel() {
        descriptionLabel.font = .preferredFont(forTextStyle: .headline)
        descriptionLabel.font = .boldSystemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textColor = .white
    }
    
    func setupTemperatureLabel() {
        temperatureLabel.font = .boldSystemFont(ofSize: 48)
        temperatureLabel.textColor = .white
        temperatureLabel.numberOfLines = 1
    }
}
