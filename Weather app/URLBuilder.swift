//
//  URLBuilder.swift
//

import Foundation


internal final class URLlBuilder {
    private var apiCurrentURL =  URLComponents(string: "https://api.openweathermap.org/data/2.5/weather?")
    private let apiKey = URLQueryItem(name: "appid", value: "32d3eaae37de69896ce7b715acb51275")
    
    internal init(type: typeOfRequest) {
        switch type {
        case .search(let city):
            setSearchUrl(nameOfCity: city)
        case .current(let latitude, let longitude):
            setCurrentWeatherUrl(latitude: latitude, longitude: longitude)
        }
    }
    
    internal func getURL() -> URL? {
        apiCurrentURL?.url
    }
    
    private func setSearchUrl(nameOfCity: String?) {
        guard let nameOfCity = nameOfCity else {
            return
        }
        let cityName = URLQueryItem(name: "q" , value: nameOfCity)
        let units = URLQueryItem(name: "units", value: "metric")
        self.apiCurrentURL?.queryItems?.append(cityName)
        self.apiCurrentURL?.queryItems?.append(apiKey)
        self.apiCurrentURL?.queryItems?.append(units)
        
    }
    
    
    private func setCurrentWeatherUrl(latitude: Double?, longitude: Double?) {
        guard let latitude = latitude, let longitude = longitude else {
            return
        }
        let latitudeKey = URLQueryItem(name: "lat", value: "\(latitude)")
        let longitudeKey = URLQueryItem(name: "lon", value: "\(longitude)")
        let units = URLQueryItem(name: "units", value: "metric")
        self.apiCurrentURL?.queryItems?.append(latitudeKey)
        self.apiCurrentURL?.queryItems?.append(longitudeKey)
        self.apiCurrentURL?.queryItems?.append(apiKey)
        self.apiCurrentURL?.queryItems?.append(units)
    }
    
}

enum typeOfRequest {
    case search(city: String?)
    case current(latitude: Double?, longitude: Double?)
}
