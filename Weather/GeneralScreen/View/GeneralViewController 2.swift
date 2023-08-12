import UIKit

class GeneralViewController: UIViewController {
        
    private var presenter = GeneralPresenter()
    
    private let tableView = UITableView()
    private var safeArea: UILayoutGuide!
            
    private var cellData: CellModel?

    private lazy var heightForTodayCell = CGFloat(343)
    private lazy var heightForHourCell = CGFloat(226)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FirstTableViewCell.self, forCellReuseIdentifier: FirstTableViewCell.reuseId)
        tableView.register(OtherTableViewCell.self, forCellReuseIdentifier: OtherTableViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter.setViewDelegate(delegate: self)
        presenter.getWeatherForGeneral()
        setupNavigationController()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.view.setNeedsDisplay()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        tableView.separatorStyle = .none
        setupTableView()
    }
}

// MARK: - TableView Delegate, DataSource

extension GeneralViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard cellData?.date != nil else { return 1 }

            print("numberOfRowsInSection searchCity \(presenter.searchCity ?? presenter.defaultCity)")
        return cellData!.date.count

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return heightForTodayCell
        } else {
            return heightForHourCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard cellData?.date != nil else { return UITableViewCell() }

        if indexPath.row == 0 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.reuseId, for: indexPath) as! FirstTableViewCell
            
            let data = cellData?.date[indexPath.row]

            cell.configure(with: data!)
            
            return cell
            
        } else {

            
            let cell = tableView.dequeueReusableCell(withIdentifier: OtherTableViewCell.reuseId, for: indexPath) as! OtherTableViewCell
                
            let tableViewIndexPath = indexPath.row - 1
        
//            let data = self.cellData?[tableViewIndexPath][tableViewIndexPath]
//            let cellModel = OtherCellModelFactory.cellModel(from: data!, weatherData: otherCellResults!)

//            cell.configure(with: cellModel)
            cell.selectionStyle = .none
            
            cell.collectionView.parentTableViewIndexPath = tableViewIndexPath
//            cell.collectionView.hourCellResults = hourCellResults
//            cell.collectionView.hourCellResults = weatherArray
            
            return cell
        }
    }
}

extension GeneralViewController: GeneralViewProtocol {
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    internal func setupNavigationController() {
        createCustomNavigationBar()

        let searchRightButton = createCustomButton(
            imageName: "magnifyingglass",
            selector: #selector(searchRightButtonTapped)
        )
        let themeRightButton = createCustomButton(
            imageName: "sun.max",
            selector: #selector(themeRightButtonTapped)
        )
        let customTitleView = createCustomTitleView(
            cityName: presenter.searchCity ?? presenter.defaultCity
        )
        let mapLeftButton = createCustomButton(
            imageName: "mappin.circle",
            selector: #selector(mapLeftButtonTapped)
        )

        navigationItem.leftBarButtonItem = mapLeftButton
        navigationItem.rightBarButtonItems = [searchRightButton, themeRightButton]
        navigationItem.titleView = customTitleView

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc private func searchRightButtonTapped() {
        let searchPopUpViewController = SearchPopUpViewController()
        self.addChild(searchPopUpViewController)
        searchPopUpViewController.view.frame = self.view.frame
        self.view.addSubview(searchPopUpViewController.view)
        searchPopUpViewController.didMove(toParent: self)
    }

    @objc private func themeRightButtonTapped() {
        print("themeRightButtonTapped")
    }

    @objc private func mapLeftButtonTapped() {
        print("mapLeftButtonTapped")
    }
}
// MARK: - Presenter Delegate

extension GeneralViewController: GeneralPresenterDelegate {
    
    func setDataForCells(_ data: CellModel) {
        self.cellData = data
    }
}
