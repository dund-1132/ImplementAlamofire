//
//  TFLocationWeatherDto.swift
//  todayweather
//
//  Created by  on 2/24/16.
//  Copyright © 2016 ngodacdu. All rights reserved.
//

import UIKit

class TFLocationWeatherDto: NSObject {
    var dateWeathers: [TFDateWeatherDto]?
    var precipMM: String?
    var temp_F: String?
    var winddir16Point: String?
    var winddirDegree: String?
    var humidity: String?
    var cloudcover: String?
    var feelsLikeF: String?
    var weatherCode: String?
    var weatherIconUrl: String?
    var temp_C: String?
    var windspeedKmph: String?
    var windspeedMiles: String?
    var visibility: String?
    var feelsLikeC: String?
    var observation_time: String?
    var weatherDesc: String?
    var pressure: String?
}
