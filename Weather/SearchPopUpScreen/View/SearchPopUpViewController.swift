import UIKit

class SearchPopUpViewController: UIViewController, UITextFieldDelegate  {
    private let presenter: SearchPopUpPresenterProtocol
    var searchCityCompletion: ((String) -> ())?
    var closeAlertCompletion: (() -> ())?

    private var searchPopupView: SearchPopUpView {
        return self.view as! SearchPopUpView
    }

    init(presenter: SearchPopUpPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = SearchPopUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActions()
        view.backgroundColor = .disableColor
    }

    private func setActions() {
        searchPopupView.setCancelButtonAction { [weak self] in
            self?.presenter.onCancelButtonClicked()
        }
        
        searchPopupView.setSearchButtonAction { [weak self] searchText in
            self?.presenter.onSearchButtonClicked(searchText: searchText)
        }
    }
}

//MARK: - SearchPopUpViewProtocol
extension SearchPopUpViewController: SearchPopUpViewProtocol {
    func transmitSearchInput(city: String) {
        searchCityCompletion?(city)
    }
    
    func removeView() {
        removeFromParent()
        view.removeFromSuperview()
        view =  nil
        closeAlertCompletion?()
    }
    
    func showEmptyFieldAlert() {
        let alert = UIAlertController(title: "Введите название города!",
                                      message: "Поле не может быть пустым",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: {
            action in
            self.closeAlertCompletion?()
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

protocol SearchPopUpPresenterProtocol {
    func onCancelButtonClicked()
    func onSearchButtonClicked(searchText: String)
}
