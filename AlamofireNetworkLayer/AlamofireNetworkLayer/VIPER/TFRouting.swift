//
//  TFRouting.swift
//  AlamofireNetworkLayer
//
//  Created by ngodacdu on 2/27/16.
//  Copyright © 2016 ngodacdu. All rights reserved.
//

import UIKit

class TFRouting: NSObject {
    
    var viewController: ViewController?
    
    class var shareRouting: TFRouting {
        struct Static {
            static let instance = TFRouting()
        }
        return Static.instance
    }
    
    private func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func pushDetailViewController() {
        let detailViewController = mainStoryboard().instantiateViewControllerWithIdentifier("DetailViewController")
        if let currentDetailVC = detailViewController as? DetailViewController {
            viewController?.navigationController?.pushViewController(
                currentDetailVC,
                animated: true
            )
        }
    }

}
