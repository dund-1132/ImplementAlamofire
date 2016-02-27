//
//  TFApiPath.swift
//  todayweather
//
//  Created by ngodacdu on 2/21/16.
//  Copyright © 2016 ngodacdu. All rights reserved.
//

import Foundation
import Alamofire

/*
    - Bạn cần có một base url
    - Key bạn tạo từ website
*/
let URL = "http://api.worldweatheronline.com"
let WEATHER_ONLINE_KEY_API = "5bbc84a16d86187c0ec4f298b8a25"

/*
    - Số kết quả tìm kiếm trả về lớn nhất
    - Số ngày bạn muốn có thông tin thời tiết
*/
let SEARCH_NUM_RESULT = 5
let NUM_OF_DAY = 5

/*
    - Base URL
    - Path
    - Method
*/
public protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
}

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(
            NSCharacterSet.URLHostAllowedCharacterSet()
        )!
    }
}

/*
    Gồm 2 API là search api và location weather api
*/
public enum API {
    case Search(String)
    case LocationWeather(String, String)
}

extension API: TargetType {
    
    public var baseURL: String {
        return URL
    }
    
    public var path: String {
        switch self {
        case .Search(let searchString):
            let query = "?query=\(searchString.stringByReplacingOccurrencesOfString(" ", withString: "+"))"
            let num = "&num_of_results=\(SEARCH_NUM_RESULT)"
            let format = "&format=json"
            let key = "&key=\(WEATHER_ONLINE_KEY_API)"
            return "\(baseURL)/free/v2/search.ashx" + query + num + format + key
        case .LocationWeather(let lat, let lon):
            let q = "?q=\(lat),\(lon)"
            let num = "&num_of_days=\(NUM_OF_DAY)"
            let format = "&format=json"
            let key = "&key=\(WEATHER_ONLINE_KEY_API)"
            return "\(baseURL)/free/v2/weather.ashx" + q + num + format + key
        }
    }
    
    public var method: String {
        switch self {
        case .Search:
            return "GET"
        case .LocationWeather:
            return "GET"
        }
    }
    
}
