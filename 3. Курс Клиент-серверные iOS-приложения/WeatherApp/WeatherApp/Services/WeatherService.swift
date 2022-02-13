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
    
    func loadWeatherData(city: String){
        
        let path = "/data/2.5/forecast"
        let parameters: Parameters = [ "q": city, "units": "metric", "appid": apiKey ]
        let url = baseUrl+path
        
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseJSON { response in
            print(response.value)
        }
    }
}
