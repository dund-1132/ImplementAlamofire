//
//  TFNetworkLayer.swift
//  todayweather
//
//  Created by ngodacdu on 2/21/16.
//  Copyright © 2016 ngodacdu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias NetworkStartHandler = () -> ()
typealias NetworkErrorHandler = (NSError) -> ()
typealias NetworkFishHandler  = (Any?) -> ()

class SSNetworkLayer: NSObject {
    
    var start: NetworkStartHandler?
    var error: NetworkErrorHandler?
    var finish: NetworkFishHandler?
    
    var request: Request?
    var api: API!
    var parameters: [String : AnyObject]?
    var headers: [String : String]?
    
    func setStartHandler(start : NetworkStartHandler) {
        self.start = start
    }
    
    func setErrorHandler(error : NetworkErrorHandler) {
        self.error = error
    }
    
    func setFinishHandler(finish : NetworkFishHandler) {
        self.finish = finish
    }
    
    private func queryStringFromDictionary(parameters: [String : AnyObject]) -> String  {
        var parts: Array<String> = [String]()
        for (key,value) in parameters {
            let part: String = String(format: "%@=%@", key,value.description)
            parts.append(part)
        }
        let joinedString = (parts as NSArray).componentsJoinedByString("&")
        return joinedString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet())!
    }
    
    private func getMethod(api: API) -> Alamofire.Method {
        let requestMethod: Alamofire.Method
        switch api.method {
        case "POST":
            requestMethod = .POST
            break
        case "PUT":
            requestMethod = .PUT
            break
        default:
            requestMethod = .GET
            break
        }
        return requestMethod
    }
    
    //MARK: Request URL    
    func requestApi(api api: API, parameters: [String : AnyObject]?, headers: [String : String]?) {
        self.api = api
        self.parameters = parameters
        self.headers = headers
        
        start?()
        
        Alamofire.request(
            getMethod(api),
            api.path,
            parameters: parameters,
            encoding: .JSON,
            headers: headers
            ).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
                switch response.result {
                case .Success(let json):
                    let response = SSJsonParser.sharedInstance.parseJson(api, json: JSON(json))
                    self.finish?(response)
                    break
                case .Failure(let error):
                    self.error?(error)
                    break
                }
        }
    }


}
