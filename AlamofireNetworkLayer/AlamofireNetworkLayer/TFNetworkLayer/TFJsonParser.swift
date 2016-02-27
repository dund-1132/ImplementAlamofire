//
//  TFJsonParser.swift
//  todayweather
//
//  Created by ngodacdu on 2/21/16.
//  Copyright © 2016 ngodacdu. All rights reserved.
//

import Foundation
import SwiftyJSON

class SSJsonParser: NSObject {
    
    class var sharedInstance : SSJsonParser {
        struct Static {
            static let instance : SSJsonParser = SSJsonParser()
        }
        return Static.instance
    }
    
    func parseJson(api : API, json : JSON) -> Any? {
        switch api {
        case .Search(_):
            return parserSearchLocationApi(json)
        case .LocationWeather(_, _):
            return parserLocationWeatherApi(json)
        }
    }
    
    //MARK: Search Location Api
    private func parserSearchLocationApi(json: JSON) -> [TFSearchLocationDto] {
        var searchLocations: [TFSearchLocationDto] = [TFSearchLocationDto]()
        if let searchApi: JSON = json["search_api"] {
            if let results = searchApi["result"].array {
                for result in results {
                    let searchLocation = TFSearchLocationDto()
                    if let firstAreaName: JSON = result["areaName"].array?.first {
                        searchLocation.areaName = firstAreaName["value"].string
                    }
                    if let firstRegion: JSON = result["region"].array?.first {
                        searchLocation.region = firstRegion["value"].string
                    }
                    if let firstWeatherUrl: JSON = result["weatherUrl"].array?.first {
                        searchLocation.weatherUrl = firstWeatherUrl["value"].string
                    }
                    searchLocation.latitude = result["latitude"].string
                    searchLocation.longitude = result["longitude"].string
                    if let firstCountry: JSON = result["country"].array?.first {
                        searchLocation.country = firstCountry["value"].string
                    }
                    searchLocation.population = result["population"].string
                    searchLocations.append(searchLocation)
                }
            }
        }
        return searchLocations
    }
    
    //MARK: Location Weather Api
    private func parserLocationWeatherApi(json: JSON) -> TFLocationWeatherDto {
        let locationWeatherDto = TFLocationWeatherDto()
        let data: JSON = json["data"]
        locationWeatherDto.dateWeathers = parserDateWeather(data["weather"])
        if let currentCondition = data["current_condition"].array?.first {
            locationWeatherDto.precipMM = currentCondition["precipMM"].string
            locationWeatherDto.temp_F = currentCondition["temp_F"].string
            locationWeatherDto.winddir16Point = currentCondition["winddir16Point"].string
            locationWeatherDto.winddirDegree = currentCondition["winddirDegree"].string
            locationWeatherDto.humidity = currentCondition["humidity"].string
            locationWeatherDto.cloudcover = currentCondition["cloudcover"].string
            locationWeatherDto.feelsLikeF = currentCondition["FeelsLikeF"].string
            locationWeatherDto.weatherCode = currentCondition["weatherCode"].string
            if let weatherIconUrl = currentCondition["weatherIconUrl"].array?.first {
                locationWeatherDto.weatherIconUrl = weatherIconUrl["value"].string
            }
            locationWeatherDto.temp_C = currentCondition["temp_C"].string
            locationWeatherDto.windspeedKmph = currentCondition["windspeedKmph"].string
            locationWeatherDto.windspeedMiles = currentCondition["windspeedMiles"].string
            locationWeatherDto.visibility = currentCondition["visibility"].string
            locationWeatherDto.feelsLikeC = currentCondition["FeelsLikeC"].string
            locationWeatherDto.observation_time = currentCondition["observation_time"].string
            if let weatherDesc = currentCondition["weatherDesc"].array?.first {
                locationWeatherDto.weatherDesc = weatherDesc["value"].string
            }
            locationWeatherDto.pressure = currentCondition["pressure"].string
        }
        return locationWeatherDto
    }
    
    private func parserDateWeather(json: JSON) -> [TFDateWeatherDto] {
        var dateWeathers: [TFDateWeatherDto] = [TFDateWeatherDto]()
        if let jsonArray = json.array {
            for dateJson in jsonArray {
                let dateWeather: TFDateWeatherDto = TFDateWeatherDto()
                dateWeather.date = dateJson["date"].string
                dateWeather.maxtempC = dateJson["maxtempC"].string
                dateWeather.mintempC = dateJson["mintempC"].string
                dateWeather.mintempF = dateJson["mintempF"].string
                dateWeather.hourlys = parserHourWeather(dateJson["hourly"])
                dateWeather.uvIndex = dateJson["uvIndex"].string
                dateWeather.astronomy = parserAstronomy(dateJson["astronomy"])
                dateWeather.maxtempF = dateJson["maxtempF"].string
                dateWeathers.append(dateWeather)
            }
        }
        return dateWeathers
    }
    
    private func parserHourWeather(json: JSON) -> [TFHourWeatherDto] {
        let hourWeatherDtos: [TFHourWeatherDto] = [TFHourWeatherDto]()
        if let jsonArray = json.array {
            for hourJson in jsonArray {
                let hourWeatherDto = TFHourWeatherDto()
                hourWeatherDto.winddirDegree = hourJson["winddirDegree"].string
                hourWeatherDto.pressure = hourJson["pressure"].string
                if let weatherIconUrl = hourJson["weatherIconUrl"].array?.first {
                    hourWeatherDto.weatherIconUrl = weatherIconUrl["value"].string
                }
                hourWeatherDto.chanceofremdry = hourJson["chanceofremdry"].string
                hourWeatherDto.windGustMiles = hourJson["WindGustMiles"].string
                hourWeatherDto.windChillF = hourJson["WindChillF"].string
                hourWeatherDto.visibility = hourJson["visibility"].string
                hourWeatherDto.time = hourJson["time"].string
                hourWeatherDto.dewPointF = hourJson["DewPointF"].string
                hourWeatherDto.chanceofsunshine = hourJson["chanceofsunshine"].string
                hourWeatherDto.chanceofrain = hourJson["chanceofrain"].string
                hourWeatherDto.chanceofwindy = hourJson["chanceofwindy"].string
                hourWeatherDto.windspeedMiles = hourJson["windspeedMiles"].string
                hourWeatherDto.chanceoffog = hourJson["chanceoffog"].string
                hourWeatherDto.windGustKmph = hourJson["WindGustKmph"].string
                hourWeatherDto.chanceofsnow = hourJson["chanceofsnow"].string
                hourWeatherDto.tempF = hourJson["tempF"].string
                hourWeatherDto.windspeedKmph = hourJson["windspeedKmph"].string
                hourWeatherDto.windChillC = hourJson["WindChillC"].string
                hourWeatherDto.heatIndexF = hourJson["HeatIndexF"].string
                hourWeatherDto.precipMM = hourJson["precipMM"].string
                hourWeatherDto.weatherCode = hourJson["weatherCode"].string
                hourWeatherDto.chanceofthunder = hourJson["chanceofthunder"].string
                if let weatherDesc = hourJson["weatherDesc"].array?.first {
                    hourWeatherDto.weatherDesc = weatherDesc["value"].string
                }
                hourWeatherDto.chanceofhightemp = hourJson["chanceofhightemp"].string
                hourWeatherDto.feelsLikeF = hourJson["FeelsLikeF"].string
                hourWeatherDto.chanceoffrost = hourJson["chanceoffrost"].string
                hourWeatherDto.winddir16Point = hourJson["winddir16Point"].string
                hourWeatherDto.heatIndexC = hourJson["HeatIndexC"].string
                hourWeatherDto.dewPointC = hourJson["DewPointC"].string
                hourWeatherDto.tempC = hourJson["tempC"].string
                hourWeatherDto.chanceofovercast = hourJson["chanceofovercast"].string
                hourWeatherDto.humidity = hourJson["humidity"].string
                hourWeatherDto.feelsLikeC = hourJson["FeelsLikeC"].string
                hourWeatherDto.cloudcover = hourJson["cloudcover"].string
            }
        }
        return hourWeatherDtos
    }
    
    private func parserAstronomy(json: JSON) -> TFAstronomyWeatherDto {
        let astronomy = TFAstronomyWeatherDto()
        astronomy.moonset = json["moonset"].string
        astronomy.moonrise = json["moonrise"].string
        astronomy.sunset = json["sunset"].string
        astronomy.sunrise = json["sunrise"].string
        return astronomy
    }
    
}

