//
//  HousesViewController.swift
//  RealEstate
//
//  Created by Alaa Khalil on 06/01/2022.
//

import UIKit

class HousesViewController: UIViewController {

    @IBOutlet weak var housesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension HousesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = housesTableView.dequeueReusableCell(withIdentifier: "HouseCell") as! HouseCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "HouseDetails", bundle: nil).instantiateViewController(withIdentifier: "HouseDetailController") as! HouseDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)

    }
    
}
