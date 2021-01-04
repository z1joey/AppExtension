//
//  ViewController.swift
//  AppExtension
//
//  Created by joey on 12/29/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var someLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if UIApplication.isFirstLaunch() {
            someLabel.text = "First Launch"
        } else {
            someLabel.text = "Hello World"
        }
    }
}
