//
//  TFDateWeatherDto.swift
//  todayweather
//
//  Created by ngodacdu on 2/23/16.
//  Copyright © 2016 ngodacdu. All rights reserved.
//

import UIKit

class TFDateWeatherDto: NSObject {
    var hourlys: [TFHourWeatherDto]?
    var astronomy: TFAstronomyWeatherDto?
    var date: String?
    var maxtempC: String?
    var maxtempF: String?
    var mintempC: String?
    var mintempF: String?
    var uvIndex: String?
}
