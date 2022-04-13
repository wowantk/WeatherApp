//
//  CurrentPositionManager.swift
//
import Foundation

protocol CurrentPositionManager: AnyObject {
    func findCurrentPlace(lan: Double, lot: Double, completion: @escaping (WeatherObject?) -> Void)
}


final class PositionManagerImpl: CurrentPositionManager {
    
    func findCurrentPlace(lan: Double, lot: Double, completion: @escaping (WeatherObject?) -> Void) {
        URLService.performRequset(URLBuilder: .init(type: .current(latitude: lan, longitude: lot))) { [weak self] isSuccess, response in
            if isSuccess {
                let wheather = self?.handle(response: response)
                completion(wheather)
            }
        }
    }
    
    private func handle(response: Wheather?) -> WeatherObject? {
        guard let response = response else {
            return nil
        }
        let location = response.name
        let temp = response.main.temp
        let description = response.weather.first?.main ?? ""
        return WeatherObject(location: location, temp: temp, description: description)
    }
    
}
