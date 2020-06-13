//
//  StatisticsVC.swift
//  GameClub
//
//  Created by Basma on 6/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class StatisticsVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sortByView: UIView!
    @IBOutlet weak var sortByTF: UITextField!
    @IBOutlet weak var sortByBT: UIButton!
    
    @IBOutlet weak var teamsView: UIView!
    @IBOutlet weak var teamsTF: UITextField!
    @IBOutlet weak var teamsBT: UIButton!
    
    @IBOutlet weak var playersView: UIView!
    @IBOutlet weak var playersTF: UITextField!
    @IBOutlet weak var playersBT: UIButton!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchBT: UIButton!
    
    @IBAction func sortByAction(_ sender: Any) {
//        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
//
//        dropDownVC.selectDelegate = self
//        dropDownVC.selectedType = .sortBy
//
//        present(dropDownVC, animated: true
//            , completion: nil)
    }
    
    @IBAction func teamsAction(_ sender: Any) {
//        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
//        
//        dropDownVC.selectDelegate = self
//        dropDownVC.selectedType = .team
//        
//        present(dropDownVC, animated: true
//            , completion: nil)
    }
    
    @IBAction func playersAction(_ sender: Any) {
    }
    
    @IBAction func searchAction(_ sender: Any) {
    }
    
    @IBAction func menuAction(_ sender: Any) {
           let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
           present(menu, animated: true, completion: nil)
       }
    @IBAction func backAction(_ sender: Any) {
     navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "StatisticsHCell", for: indexPath) as! StatisticsHCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "StatisticsCell", for: indexPath) as! StatisticsCell
        if indexPath.row == 0 {
            return cell1
        }else{
            return cell2
        }

    }
    
    

}
