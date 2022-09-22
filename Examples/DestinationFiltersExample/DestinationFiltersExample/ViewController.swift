//
//  ViewController.swift
//  DestinationFiltersExample
//
//  Created by Prayansh Srivastava on 9/21/22.
//

import UIKit
import Segment


class ViewController: UIViewController {

    @IBOutlet weak var textView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        // On press
        Analytics.main.track(name: "Button Clicked")
        textView.text = "Somethin new"
    }
    
}

