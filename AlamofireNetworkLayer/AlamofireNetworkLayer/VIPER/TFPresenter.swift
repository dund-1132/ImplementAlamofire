//
//  TFPresenter.swift
//  AlamofireNetworkLayer
//
//  Created by ngodacdu on 2/27/16.
//  Copyright © 2016 ngodacdu. All rights reserved.
//

import UIKit

class TFPresenter: NSObject, TFInterface {
    
    var input: TFInteractorInput?

    func didTouchUpInSideSearchButton(searchText: String) {
        input?.requestSearchApi(searchText)
    }
    
}

extension TFPresenter: TFInteractorOutput {
    
    func searchApiDidFinished(data: TFSearchLocationDto) {
        
    }
    
    func searchApiDidError(error: NSError) {
        
    }
    
}
