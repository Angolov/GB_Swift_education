//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Антон Головатый on 13.02.2022.
//

import Foundation
import Alamofire
import RealmSwift

//MARK: - WeatherService class declaration
final class WeatherService {
    
    let baseUrl = "http://api.openweathermap.org"
    let apiKey = "650012a23d65ea5accf85d16779f04c7"
    
    func loadWeatherData(city: String, completion: @escaping () -> Void){
        
        let path = "/data/2.5/forecast"
        let parameters: Parameters = [
            "q": city,
            "appid": apiKey,
            "units": "metric"
        ]
        let url = baseUrl + path
        
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseData { [weak self] response in
            guard let data = response.value,
                  let self = self else { return }
            
            let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
            weather.forEach { $0.city = city }
            self.saveWeatherData(weather, city: city)
            completion()
        }
    }
    
    func saveWeatherData(_ weathers: [Weather], city: String) {
        do {
            let realm = try Realm()
            let oldWeathers = realm.objects(Weather.self).filter("city == %@", city)
            realm.beginWrite()
            realm.delete(oldWeathers)
            realm.add(weathers)
            try realm.commitWrite()
            
        } catch {
            print(error) }
    }
}
