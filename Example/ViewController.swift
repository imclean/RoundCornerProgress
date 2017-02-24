//
//  ViewController.swift
//  Example
//
//  Created by Chi-Quyen Le on 12/10/16.
//  Copyright © 2016 Phuc Nguyen. All rights reserved.
//

import UIKit
import RoundCornerProgressView

class ViewController: UIViewController {

    @IBOutlet weak var progressView: RoundCornerProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 1.0
        progressView.paidTick.image = UIImage(named: "PaidTick")
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.progressView.progress = 1.0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

