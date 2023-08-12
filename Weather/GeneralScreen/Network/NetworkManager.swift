import Foundation
import Alamofire

class NetworkManager {
    private static let sessionAF: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        let session = Alamofire.Session(configuration: configuration)
        
        return session
    }()
    
    static let sharedInstance = NetworkManager()
       
    private init() { }
    
    func loadWeather(with city: String,
                     completion: @escaping ((Result<Weather, Error>) -> () )) {
        let baseURL = "https://api.openweathermap.org"
        let path = "/data/2.5/forecast"
        let params = [
            "q": city,
            "appid": "71ab8f58aa3f3f7fb9d9a937349d5235",
            "lang": "ru",
            "units": "metric",
        ]
        
        AF.request(baseURL + path, method: .get, parameters: params).responseDecodable(of: Weather.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
