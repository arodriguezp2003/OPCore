//
//  ViewController.swift
//  OPCore
//
//  Created by Alejandro Rodriguez on 10/01/2020.
//  Copyright (c) 2020 Alejandro Rodriguez. All rights reserved.
//

import UIKit
import OPCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        OPAnalytics.shared.setUserID("123123")
        OPAnalytics.shared.logEvent(eventName: "Demo", parameters:["OK": true])
        let parameters = [
          NSLocalizedDescriptionKey: NSLocalizedString("The request failed.", comment: ""),
          NSLocalizedFailureReasonErrorKey: NSLocalizedString("The response returned a 404.", comment: ""),
          NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Does this page exist?", comment: ""),
          "ProductID": "123456",
          "View": "MainView"
        ]
        OPAnalytics.shared.registerError(code: -1001, parameters: parameters)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didTapFatalError(_ sender: Any) {
        fatalError("craps")
    }
    
}

