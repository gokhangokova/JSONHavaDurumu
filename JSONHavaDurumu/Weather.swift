//
//  Weather.swift
//  JSONHavaDurumu
//
//  Created by Gokhan Gokova on 2.11.2018.
//  Copyright © 2018 Gokhan Gokova. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let weather = try? newJSONDecoder().decode(Weather.self, from: jsonData)

import Foundation

struct Weather: Decodable {
    let weather: [WeatherElement]
    let base: String
    let main: Main
    let visibility: Int
    let dt: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Main: Decodable {
    let temp: Double
    let pressure, humidity, tempMin, tempMax: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct WeatherElement: Decodable {
    let id: Int
    let main, description, icon: String
}
