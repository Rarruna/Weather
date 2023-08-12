import UIKit
import SnapKit

class OtherTableViewCell: UITableViewCell {
    static let reuseId = "HourCell"
    
    private let collectionView = HourCollectionView()
    private let backView = UIView()
    private let dateLabel = UILabel()
    private let weekdayLabel = UILabel()
    private let maxTempLabel = UILabel()
    private let minTempLabel = UILabel()
    private let weatherIcon = UIImageView()
    private let separatorView = UIView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = ""
        weekdayLabel.text = ""
        maxTempLabel.text = ""
        minTempLabel.text = ""
        weatherIcon.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        setupView()
    }
    
    func configure(with cell: ByDate) {
        dateLabel.text = cell.date
        weatherIcon.image = UIImage(named: cell.icon)
        minTempLabel.text = cell.minTemp
        maxTempLabel.text = cell.maxTemp
        collectionView.reloadCellData(with: cell.times)
    }
}

private extension OtherTableViewCell {
    func setupView() {
        addSubview(backView)
        backView.addSubview(dateLabel)
        backView.addSubview(weekdayLabel)
        backView.addSubview(minTempLabel)
        backView.addSubview(maxTempLabel)
        backView.addSubview(weatherIcon)
        backView.addSubview(separatorView)
        backView.addSubview(collectionView)
        
        setupConstraints()
        setupBackground()
        setupDateLabel()
        setupWeekdayLabel()
        setupMaxTempLabel()
        setupMinTempLabel()
        setupWeatherIcon()
        setupSeparatorView()
    }
    
    func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
            make.right.equalTo(weekdayLabel.snp.left).inset(-2)
        }
        
        weekdayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
        }
        
        maxTempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
        }
        
        minTempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(maxTempLabel.snp.right).inset(-8)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalTo(minTempLabel.snp.right).inset(-16)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(24)
            make.width.equalTo(30)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupBackground() {
        backView.clipsToBounds = true
        backView.backgroundColor = .viewBackgroundColor
        backView.layer.cornerRadius = 16
    }
    
    func setupDateLabel() {
        dateLabel.font = .preferredFont(forTextStyle: .title2)
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.numberOfLines = 1
        dateLabel.textColor = .blackColor
    }
    
    func setupWeekdayLabel() {
        weekdayLabel.font = .preferredFont(forTextStyle: .title2)
        weekdayLabel.font = .systemFont(ofSize: 16)
        weekdayLabel.numberOfLines = 1
        weekdayLabel.textColor = .grayColor
    }
    
    func setupMaxTempLabel() {
        maxTempLabel.font = .preferredFont(forTextStyle: .title2)
        maxTempLabel.font = .boldSystemFont(ofSize: 16)
        maxTempLabel.numberOfLines = 1
        maxTempLabel.textColor = .blackColor
    }
    
    func setupMinTempLabel() {
        minTempLabel.font = .preferredFont(forTextStyle: .title2)
        minTempLabel.font = .boldSystemFont(ofSize: 16)
        minTempLabel.numberOfLines = 1
        minTempLabel.textColor = .grayColor
    }
    
    func setupWeatherIcon() {
        weatherIcon.clipsToBounds = true
        weatherIcon.contentMode = .scaleAspectFit
    }
    
    func setupSeparatorView() {
        separatorView.layer.borderWidth = 1
        separatorView.layer.borderColor = UIColor.separatorColor.cgColor
    }
}
