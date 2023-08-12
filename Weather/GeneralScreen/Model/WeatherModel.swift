import Foundation

// MARK: - Weather
struct Weather: Codable {
    let weatherByDate: [WeatherByDate]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case city
        case weatherByDate = "list"
    }
}

// MARK: - City
struct City: Codable {
    let name: String
}

// MARK: - WeatherByDate
struct WeatherByDate: Codable {
    let date: Int
    let temperature: Temperature
    let description: [Description]
    let fullDate: String

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "main"
        case description = "weather"
        case fullDate = "dt_txt"
    }
}

// MARK: - Temperature
struct Temperature: Codable {
    let temp, feelsLike, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Description
struct Description: Codable {
    let description: String
}

