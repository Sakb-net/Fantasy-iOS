//
//  PrizesVC.swift
//  GameClub
//
//  Created by Basma on 6/6/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class PrizesVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    let titles = ["  جائزة المركز الأول:", "  جائزة المركز الثاني:", "  جائزة المركز الثالث:"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.titles.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.titles[section]
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.adjustsFontSizeToFitWidth = true
        headerText.textAlignment = .right
        headerText.font = UIFont(name:"HelveticaNeueW23forSKY-Reg",size:15)

        headerText.text = self.titles[section]

        return headerText
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrizeCell", for: indexPath) as! PrizeCell
        roundViewCornersNoShadow(view: cell.markView)

        return cell
    }
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: containerView)
        roundViewCornersNoShadow(view: tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

}
