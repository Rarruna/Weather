import Foundation

struct ByDate: Hashable {
    let dateAndTime: String
    let date: String
    let todayDate: String
    let temperature: String
    let minTemp: String
    let maxTemp: String
    let icon: String
    let description: String
    let times: [ByTime]
}

struct ByTime: Hashable {
    let hour: String
    let temperature: String
    let icon: String
}



