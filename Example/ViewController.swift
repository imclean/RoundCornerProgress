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
        progressView.progress = 0.1
        progressView.paidTick.image = UIImage(named: "PaidTick")
        let attributed = NSMutableAttributedString(string: "£80 of £80", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
        attributed.addAttributes( [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 14)], range: NSMakeRange(attributed.string.characters.count - 3, 3))
        progressView.progressLabel.attributedText = attributed
        progressView.requestImage.image = UIImage(named: "RequestImage")
        progressView.requestText.text = NSLocalizedString("Request payment", comment: "")
        progressView.requestText.textColor = UIColor(red:0.20, green:0.65, blue:0.71, alpha:1.00)
        progressView.requestText.font = UIFont.systemFont(ofSize: 12)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.progressView.progress = 0.0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

