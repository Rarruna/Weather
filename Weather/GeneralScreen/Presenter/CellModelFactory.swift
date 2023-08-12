import Foundation

final class CellInfoFactory {
    static private let converter = Converter()
    
    static func getInfoByDate(infos: [WeatherByDate]) -> ByDate {
        let maxTemp = getMaxTemperatureInDay(infos: infos)
        let minTemp = getMinTemperatureInDay(infos: infos)
        let times = getTimes(infos: infos)
        
        return convertByDate(info: infos.first!,
                             minTemp: minTemp,
                             maxTemp: maxTemp,
                             times: times)
    }
    
    static private func convertByDate(info: WeatherByDate,
                                      minTemp: String,
                                      maxTemp: String,
                                      times: [ByTime]) -> ByDate {
        let dateAndTime = info.fullDate
        let date = getDate(info: info)
        let todayDate = getTodayDate(info: info)

        let icon = converter.getWeatherIconName(description: info.description.first?.description ?? "")
        
        let temp = "\(lround(info.temperature.temp))°"
        let description = getDescription(info: info)
        
        return ByDate(dateAndTime: dateAndTime,
                      date: date,
                      todayDate: todayDate,
                      temperature: temp,
                      minTemp: minTemp,
                      maxTemp: maxTemp,
                      icon: icon,
                      description: description,
                      times: times)
    }
    
    static private func getTodayDate(info: WeatherByDate) -> String {
        let today = "Сегодня"
        let date = getDate(info: info)
        return today + ", " + date
    }
    
    static private func getDate(info: WeatherByDate) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(info.date))
        let shortDate = converter.convertDateOnRussian(timeIntervalSince1970: date)
        let dayOfWeek = converter.getWeekday(timeIntervalSince1970: date)
        return shortDate + ", " + dayOfWeek
    }
    
    static private func getDescription(info: WeatherByDate) -> String {
        let description = info.description.first?.description ?? ""
        let shortDescription = description.capitalized
        let feelsLikeTemp = String(lround(info.temperature.feelsLike))
        let feelsLikeString = "ощущается как"
        return "\(shortDescription), \(feelsLikeString) \(feelsLikeTemp)°"
    }
    
    static private func getMaxTemperatureInDay(infos: [WeatherByDate]) -> String {
        let maxTempInDay = infos.map { $0.temperature.tempMax }
        return "\(lround(maxTempInDay.max() ?? 0.0))°"
    }
    
    static private func getMinTemperatureInDay(infos: [WeatherByDate]) -> String {
        let minTempInDay = infos.map { $0.temperature.tempMin }
        return "\(lround(minTempInDay.min() ?? 0.0))°"
    }
    
    static private func getTimes(infos: [WeatherByDate]) -> [ByTime] {
        return infos.map { convertByTime(info: $0)}
    }
    
    static private func convertByTime(info: WeatherByDate) -> ByTime {
        let time = info.fullDate.suffix(8)
        let hour = String(time.prefix(5))
        let temperature = "\(lround(info.temperature.temp))°"
        let description = info.description[0].description
        let icon = converter.getWeatherIconName(description: description)

        return ByTime(hour: hour, temperature: temperature, icon: icon)
    }
}
