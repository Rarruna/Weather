import UIKit

class Converter {
    func getWeatherIconName(description: String) -> String {
        switch description {
        case "пасмурно", "небольшая облачность":
            return "partly_cloudy"
        case "дождь", "небольшой дождь":
            return "rain"
        case "гроза":
            return "thunder"
        case "облачно с прояснениями", "переменная облачность":
            return "sun_with_cloud"
        case "ясно":
            return "sun"
        case "небольшой снег", "снег":
            return "rain"
        default:
            return ""
        }
    }
    
    func convertDateOnRussian(timeIntervalSince1970 date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }

    func getWeekday(timeIntervalSince1970 date: Date) -> String {
        let component = Calendar.current.component(.weekday, from: date) - 1
        let weekdayEng = DateFormatter().weekdaySymbols[component]
        
        switch weekdayEng {
        case "Monday":
            return "понедельник"
        case "Tuesday":
            return "вторник"
        case "Wednesday":
            return "среда"
        case "Thursday":
            return "четверг"
        case "Friday":
            return "пятница"
        case "Saturday":
            return "суббота"
        case "Sunday":
            return "воскресенье"
        default:
            return ""
        }
    }
}
