import UIKit
import SnapKit
 
private let heightForTodayCell = CGFloat(343)
private let heightForHourCell = CGFloat(226)

class GeneralView: UIView {
    private let tableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Int, ByDate>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
    }
    
    func loadCellData(cellData: [ByDate]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ByDate>()
        snapshot.appendSections([0])
        snapshot.appendItems(cellData, toSection: 0)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

private extension GeneralView {
    func setupTableView() {
        addSubview(tableView)
        tableView.register(FirstTableViewCell.self,
                           forCellReuseIdentifier: FirstTableViewCell.reuseId)
        tableView.register(OtherTableViewCell.self,
                           forCellReuseIdentifier: OtherTableViewCell.reuseId)
        tableView.reloadData()

        tableView.snp.makeConstraints { make in
            make.top.equalTo(layoutMarginsGuide)
            make.left.right.bottom.equalToSuperview()
        }
        createDataSource()
    }
    
    func createDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, ByDate>(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
            
            switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: FirstTableViewCell.reuseId,
                        for: indexPath) as! FirstTableViewCell
                    tableView.rowHeight = heightForTodayCell
                    cell.configure(with: model)
                
                    return cell
                
                default:
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: OtherTableViewCell.reuseId,
                        for: indexPath) as! OtherTableViewCell
                    tableView.rowHeight = heightForHourCell
                    cell.configure(with: model)
                
                    return cell
            }
        })
    }
}
