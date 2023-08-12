protocol SearchPopUpViewProtocol: AnyObject {
    func transmitSearchInput(city: String)
    func removeView()
    func showEmptyFieldAlert()
}

final class SearchPopUpPresenter {
    private weak var view: SearchPopUpViewProtocol?
    
    func setView(_ view: SearchPopUpViewProtocol) {
        self.view = view
    }
}

extension SearchPopUpPresenter: SearchPopUpPresenterProtocol {
    func onCancelButtonClicked() {
        view?.removeView()
    }
    
    func onSearchButtonClicked(searchText: String) {
        if searchText == "" {
            view?.showEmptyFieldAlert()
        } else {
            view?.transmitSearchInput(city: searchText)
        }
        view?.removeView()
    }
}
