typealias WeatherWithCity = ([WeatherByDate], String) -> Void
fileprivate let defaultCity = "Москва"

final class GeneralPresenter {
    private weak var view: GeneralViewProtocol?
                
    func setView(view: GeneralViewProtocol) {
        self.view = view
    }
}

// MARK: - GeneralPresenterProtocol
extension GeneralPresenter: GeneralPresenterProtocol {
    func getWeather(city: String?) {
        loadWeather(city: city, completion: { [weak self] weatherByDate, city in
            guard let self, weatherByDate.count > 1 else {
                self?.view?.showCityErrorAlert(city: city)
                return
            }
            let cellInfo = self.getCellInfo(weatherByDate)
            self.view?.setDataForCells(cellInfo)
            self.view?.loadNavigationControllerTitle(with: city)
        })
    }
}

private extension GeneralPresenter {
    func loadWeather(city: String? = nil, completion: @escaping WeatherWithCity) {
        NetworkManager.sharedInstance.loadWeather(with: city ?? defaultCity) { weatherResponse in
            
            switch weatherResponse {
            case .success(let weather):
                let city = weather.city.name
                let weatherByDate = weather.weatherByDate
                completion(weatherByDate, city)
            case .failure(let error):
                self.view?.showCityErrorAlert(city: city ?? "")
                print("Filed to load weather with error: \(error.localizedDescription)")
            }
        }
    }
    
    func getCellInfo(_ weather: [WeatherByDate]) -> [ByDate] {
        let dictonary = Dictionary(grouping: weather, by: { $0.fullDate.prefix(10) })
        return dictonary.sorted { $0.0 < $1.0 }
                        .map ({ CellInfoFactory.getInfoByDate(infos: $0.value) })
    }
}
