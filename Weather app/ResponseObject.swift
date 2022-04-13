import Foundation

struct Wheather: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let name: String
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
}

struct Weather: Codable {
    let main, weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
    }
}

struct Wind: Codable {
    let speed: Double
}

