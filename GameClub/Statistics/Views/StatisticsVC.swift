//
//  StatisticsVC.swift
//  GameClub
//
//  Created by Basma on 6/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class StatisticsVC: ParentViewController, UITableViewDelegate, UITableViewDataSource , SelectedDropDownType {
    
    func selectedType(selectedType: DropDownTypes, selectedItem: Any) {
        if selectedType == .team {
            let selectedTeam = selectedItem as! Teams
            self.teamsTF.text = selectedTeam.name
            self.teamLink = selectedTeam.link!
            getStatistics()
        } else if selectedType == .sortByStat {
            let selectedSortType = selectedItem as! Int
            if selectedSortType == 0 {
                self.sortByTF.text = "Highest Price".localized
                self.orderPlay = "heigh_price"
                getStatistics()
            }else if selectedSortType == 1 {
                self.sortByTF.text = "Lowest Price".localized
                self.orderPlay = "low_price"
                getStatistics()
            }else if selectedSortType == 2{
                self.sortByTF.text = "Highest Points".localized
                self.orderPlay = "heighest_point"
                getStatistics()
            }else {
                self.sortByTF.text = "Lowest Points".localized
                self.orderPlay = "lowest_point"
                getStatistics()
            }
           
        }else if selectedType == .player_loc {
            let selectedSortType = selectedItem as! Int
            if selectedSortType == 0 {
                self.playersTF.text = "Goalkeeper".localized
                self.player_loc = "goalkeeper"
                getStatistics()
            }else if selectedSortType == 1 {
                self.playersTF.text = "Defender".localized
                self.player_loc = "defender"
                getStatistics()
            }else if selectedSortType == 2{
                self.playersTF.text = "Mid".localized
                self.player_loc = "line"
                getStatistics()
            }else {
                self.playersTF.text = "Attacker".localized
                self.player_loc = "attacker"
                getStatistics()
            }
        }
    }
    var presenter = StatisticsPresenter()
    var teamLink = ""
    var orderPlay = ""
    var player_loc = ""
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
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        dropDownVC.selectDelegate = self
        dropDownVC.selectedType = .sortByStat
        present(dropDownVC, animated: true
            , completion: nil)
    }
    
    @IBAction func teamsAction(_ sender: Any) {
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        dropDownVC.selectDelegate = self
        dropDownVC.selectedType = .team
        present(dropDownVC, animated: true
            , completion: nil)
    }
    
    @IBAction func playersAction(_ sender: Any) {
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
               dropDownVC.selectDelegate = self
               dropDownVC.selectedType = .player_loc
               present(dropDownVC, animated: true
                   , completion: nil)
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
        getStatistics()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statisticsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "StatisticsHCell", for: indexPath) as! StatisticsHCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "StatisticsCell", for: indexPath) as! StatisticsCell
        if indexPath.row == 0 {
            return cell1
        }else{
            cell2.nameLbl.text = self.statisticsList[indexPath.row].name
            cell2.teamLbl.text = self.statisticsList[indexPath.row].team
            cell2.nextMatchLbl.text = self.statisticsList[indexPath.row].fix
            cell2.fromLbl.text = String(self.statisticsList[indexPath.row].form ?? 0)
            cell2.pointsLbl.text = String(self.statisticsList[indexPath.row].point ?? 0)
            cell2.priceLbl.text = String(self.statisticsList[indexPath.row].cost ?? 0)
            cell2.sellLbl.text = String(self.statisticsList[indexPath.row].sell_cost ?? 0)
            cell2.buyLbl.text = String(self.statisticsList[indexPath.row].buy_cost ?? 0)

            return cell2
        }

    }
    var statisticsList = [StatisticsModel]()
    func getStatistics (){
        presenter.getStatistics(teamLink: teamLink, order_play: orderPlay, loc_player: player_loc, onSuccess: { (response) in
    self.statisticsList = response
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.reloadData()
    }) { (errorMessage) in
    self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
    }
    }
}
