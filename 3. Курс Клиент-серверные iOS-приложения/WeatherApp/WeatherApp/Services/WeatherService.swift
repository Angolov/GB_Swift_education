//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Антон Головатый on 13.02.2022.
//

import Foundation
import Alamofire

//MARK: - WeatherService class declaration
final class WeatherService {
    
    let baseUrl = "http://api.openweathermap.org"
    let apiKey = "650012a23d65ea5accf85d16779f04c7"
    
    func loadWeatherData(city: String, completion: @escaping ([Weather]) -> Void){
        
        let path = "/data/2.5/forecast"
        let parameters: Parameters = [
            "q": city,
            "appid": apiKey,
            //"cnt": "1",
            "units": "metric"
        ]
        let url = baseUrl + path
        
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
            
            completion(weather)
        }
    }
}
