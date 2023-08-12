import UIKit
import SnapKit

class HourCollectionCell: UICollectionViewCell {
    static let reuseId = "HourCell"
    
    private let timeLabel = UILabel()
    private let weatherIcon = UIImageView()
    private let tempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16
        clipsToBounds = false
    }
    
    func configure(with cell: ByTime) {
        tempLabel.text = cell.temperature
        weatherIcon.image = UIImage(named: cell.icon)
        timeLabel.text = cell.hour
    }
}

private extension HourCollectionCell {
    func setupUI() {
        addSubview(timeLabel)
        addSubview(weatherIcon)
        addSubview(tempLabel)
    
        backgroundColor = .cellBackgroundColor
        
        setupConstraints()
        setupTimeLabel()
        setupTempLabel()
        setupWeatherIcon()
    }
    
    func setupConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
        }

        weatherIcon.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(32)
            make.height.equalTo(26)
        }

        tempLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupTimeLabel() {
        timeLabel.font = .preferredFont(forTextStyle: .title2)
        timeLabel.font = .systemFont(ofSize: 16)
        timeLabel.textColor = .timeLabelTextColor
        timeLabel.numberOfLines = 1
    }
    
    func setupWeatherIcon() {
        weatherIcon.clipsToBounds = true
        weatherIcon.contentMode = .scaleAspectFit
    }
    
    func setupTempLabel() {
        tempLabel.font = .boldSystemFont(ofSize: 16)
        tempLabel.textColor = .tempLabelTextColor
        tempLabel.numberOfLines = 1
    }
}
