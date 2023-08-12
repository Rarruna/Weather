import UIKit
import SnapKit

class GeneralViewController: UIViewController {
    private var presenter: GeneralPresenterProtocol
    private var searchBarButton = UIBarButtonItem()
                    
    private var generalView: GeneralView {
        return self.view as! GeneralView
    }
    
    init(presenter: GeneralPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = GeneralView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getWeather(city: nil)
        hideSearchButton(isHidden: false)
        view.setNeedsDisplay()
    }
    
    private func setupNavigationController() {
        createCustomNavigationBar()

        searchBarButton = createCustomButton(
            imageName: "magnifyingglass",
            selector: #selector(showSearchPopUpView)
        )
        navigationItem.rightBarButtonItem = searchBarButton
    }
    
    private func hideSearchButton(isHidden: Bool) {
        let hidingAlpha: CGFloat = isHidden ? 0 : 1
        searchBarButton.customView?.alpha = hidingAlpha
    }
}
// MARK: - Presenter Delegate
extension GeneralViewController: GeneralViewProtocol {
    func setDataForCells(_ data: [ByDate]) {
        generalView.loadCellData(cellData: data)
    }

    func loadNavigationControllerTitle(with title: String) {
        let titleView = createCustomTitleView(cityName: title)
        navigationItem.titleView = titleView
    }
    
    func showCityErrorAlert(city: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Не удалось найти город с названием '\(city)'",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: {
            action in
            self.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Actions
private extension GeneralViewController {
    @objc func showSearchPopUpView() {
        let presenter = SearchPopUpPresenter()
        let searchPopUpViewController = SearchPopUpViewController(presenter: presenter)
        presenter.setView(searchPopUpViewController)
        addChild(searchPopUpViewController)
        
        searchPopUpViewController.view.frame = view.frame
        view.addSubview(searchPopUpViewController.view)
        searchPopUpViewController.didMove(toParent: self)
        
        searchPopUpViewController.searchCityCompletion = { [weak self] city in
            self?.presenter.getWeather(city: city)
            self?.hideSearchButton(isHidden: false)
        }
        searchPopUpViewController.closeAlertCompletion = { [weak self] in
            self?.hideSearchButton(isHidden: false)
        }
        hideSearchButton(isHidden: true)
    }
}

protocol GeneralViewProtocol: AnyObject {
    func setDataForCells(_ data: [ByDate])
    func loadNavigationControllerTitle(with title: String)
    func showCityErrorAlert(city: String)
}
