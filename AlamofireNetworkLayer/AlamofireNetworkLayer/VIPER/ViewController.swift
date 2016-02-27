//
//  ViewController.swift
//  AlamofireNetworkLayer
//
//  Created by ngodacdu on 2/27/16.
//  Copyright © 2016 ngodacdu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var handler: TFInterface?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didTouchUpInSideSearchButton(sender: AnyObject) {
        handler?.didTouchUpInSideSearchButton("Hanoi")
    }
}

