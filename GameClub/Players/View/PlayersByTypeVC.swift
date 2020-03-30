//
//  PlayersByTypeVC.swift
//  GameClub
//
//  Created by Basma on 3/8/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class PlayersByTypeVC: ParentViewController, UITableViewDelegate, UITableViewDataSource, SelectedDropDownType {
    func searchFromTo(from: String, to: String) {
        self.fromPrice = from
        self.toPrice = to
        self.teamLink = ""
        self.orderPlay = ""
        getPlayers()
    }
    
    func selectedType(selectedType: DropDownTypes, selectedItem: Any) {
        if selectedType == .team {
            let selectedTeam = selectedItem as! Teams
            self.teamsTF.text = selectedTeam.name
            self.teamLink = selectedTeam.link!
            getPlayers()
        } else if selectedType == .sortBy {
            let selectedSortType = selectedItem as! Int
            if selectedSortType == 0 {
                self.sortByTF.text = "حسب الأعلى سعر"
                self.orderPlay = "heigh_price"
                getPlayers()
            }else if selectedSortType == 1 {
                self.sortByTF.text = "حسب الأقل سعر"
                self.orderPlay = "low_price"
                getPlayers()
            }else if selectedSortType == 2{
                self.priceView.isHidden = false
                self.tableView.isHidden = true
            }else {
                self.sortByTF.text = "حسب النقاط"
                self.orderPlay = "point"
                getPlayers()
            }
        }else if selectedType == .playerAction {
            let selectedSortType = selectedItem as! Int
            if selectedSortType == 0 {
                if !isReplace{
                presenter.addPlayer(link: self.player.link!, onSuccess: { (player) in
                    self.showAlert(title: "", message: "تمت إضافة اللاعب", shouldpop: false)
                    self.hideLoader()
                }) { (errorMessage) in
                    self.hideLoader()
                    self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
                }
                }else{
                    presenter.replacePlayer(deleted_player_link: deleted_player_link, player_link: self.player.link!, eldwry_link: eldawry_link, onSuccess: { (player) in
                        self.delegate?.getPlayerBack(bt: self.bt!)
                        UserDefaults.standard.set(0, forKey: self.btName)

                        self.showAlert(title: "", message: "تمت إضافة اللاعب", shouldpop: false)
                        self.hideLoader()
                    }) { (errorMessage) in
                        self.hideLoader()
                        self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
                    }
                }
            }else {
                let playerDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PlayerDetailsVC") as! PlayerDetailsVC
                playerDetailsVC.player = self.player
                self.navigationController?.pushViewController(playerDetailsVC, animated: true)
            }
        }
    }
    
    var presenter = PlayersPresenter()
    var type : String?
    var players = [Player]()
    var player = Player ()
    var teamLink = ""
    var wordSearch = ""
    var orderPlay = ""
    var fromPrice = ""
    var toPrice = ""
    var locPlayer = ""
    var isReplace = false
    var deleted_player_link = ""
    var eldawry_link = ""
    var bt : UIButton?
    var btName = ""
    var playerActionType = 0
    var delegate : playerDeletedDelegate?
    
    
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
    
    @IBAction func sortByAction(_ sender: Any) {
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        
        dropDownVC.selectDelegate = self
        dropDownVC.selectedType = .sortBy
        
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
    }
    
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
                      present(menu, animated: true, completion: nil)
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var searchBT: UIButton!
    
    @IBAction func searchAction(_ sender: Any) {
        self.fromPrice = self.fromTF.text!
        self.toPrice = self.toTF.text!
        self.orderPlay = ""
        self.teamLink = ""
        guard let from = self.fromTF.text, from != "" else {
                   self.showAlert(title: "", message: "ادخل الرقم الاول", shouldpop: false)
                   return
               }
        guard let to = self.toTF.text, to != "" else {
            self.showAlert(title: "", message: "ادخل الرقم الثاني", shouldpop: false)
            return
        }
        self.priceView.isHidden = true
        self.tableView.isHidden = false
        getPlayers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig ()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getPlayers()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersHeaderCell", for: indexPath) as! PlayersHeaderCell
            return cell

        }else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCV", for: indexPath) as! PlayerCV
        cell.nameLbl.text = self.players[indexPath.row-1].name
        if let cost = self.players[indexPath.row-1].cost{
            cell.costLbl.text  = String(cost)
        }
        let team = self.players[indexPath.row-1].team
        let position = self.players[indexPath.row-1].location_player
        cell.positionLbl.text = team! + " " + position!
            if let playerPoints = self.players[indexPath.row-1].point {
            cell.pointsLbl.text = String(playerPoints)
            }
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        dropDownVC.selectDelegate = self
        dropDownVC.selectedType = .playerAction
        present(dropDownVC, animated: true, completion: nil)
        self.player = self.players[indexPath.row-1]
    }
    
    func getPlayers(){
        self.showLoader()
        presenter.getPlayers(type: type!, teamLink: teamLink, word_search: wordSearch, order_play: orderPlay, from_price: fromPrice, to_price: toPrice, loc_player: locPlayer, onSuccess: { (players) in
            self.players = players
            self.tableView.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func viewConfig (){
        roundViewCornersNoShadow(view: self.sortByView)
        roundViewCornersNoShadow(view: self.teamsView)
        roundViewCornersNoShadow(view: self.playersView)
        roundViewCorners(view: self.priceView)
    }
    
}
protocol replacementListenner {
    func showPlayer(bt : UIButton)
}
