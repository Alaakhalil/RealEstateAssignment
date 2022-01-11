//
//  AboutViewController.swift
//  RealEstate
//
//  Created by Alaa Khalil on 06/01/2022.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Go to the DTT website
    @IBAction func urlPressedButton(_ sender: Any) {
        if let url = URL(string: "https://www.d-tt.nl/"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }

}
