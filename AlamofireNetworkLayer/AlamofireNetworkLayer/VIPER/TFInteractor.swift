//
//  TFInteractor.swift
//  AlamofireNetworkLayer
//
//  Created by ngodacdu on 2/27/16.
//  Copyright © 2016 ngodacdu. All rights reserved.
//

import UIKit

protocol TFInteractorOutput {
    func searchApiDidFinished(data: TFSearchLocationDto)
    func searchApiDidError(error: NSError)
}

protocol TFInteractorInput {
    func requestSearchApi(searchText: String)
}

class TFInteractor: NSObject, TFInteractorInput {
    
    var output: TFInteractorOutput?

    func requestSearchApi(searchText: String) {
        let network = SSNetworkLayer()
        weak var weakSelf = self
        network.setFinishHandler { (result) -> () in
            if let data = result as? TFSearchLocationDto {
                weakSelf?.output?.searchApiDidFinished(data)
            }
        }
        network.setErrorHandler { (error) -> () in
            weakSelf?.output?.searchApiDidError(error)
        }
        network.requestApi(
            api: .Search(searchText),
            parameters: nil,
            headers: nil
        )
    }
    
}
