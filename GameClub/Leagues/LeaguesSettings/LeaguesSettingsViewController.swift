//
//  LeaguesSettingsViewController.swift
//  GameClub
//
//  Created by Basma on 9/24/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class LeaguesSettingsViewController: ParentViewController {
    var link = ""
    var leagueType = ""
    var isOpened = [false, false, false, false, false, false]
    var headerTitles = [String]()
    var service = LeagueSettingsAPIservice()
    var details = MyLeagueDetails()
    var player : LeaguePlayer?
    var gameWeekLinkForUpdate = ""
    var gameWeeks = [GWsPointsModel]()
    var selectedGameWeek = GWsPointsModel()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if "lang".localized == "en" {
            headerTitles = ["League Code","League Details","Delete Player","Change Admin","Delete League"]
        }else if "lang".localized == "ar" {
            headerTitles = ["كود الدوري","تفاصيل الدوري","حذف لاعب من الدوري","تغيير مدير الدوري","حذف الدوري"]
        }
        if isNetworkReachable {
            getLeagueDetails()
            getGameWeeks ()
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
        initView ()
    }
    
    func getLeagueDetails(){
        showLoader()
        service.getLeagueDetails(link: link, leagueType: leagueType, onSuccess: { (details) in
            self.details = details
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    func addAdminToLeague(){
        showLoader()
        service.addAdminToLeague(link: player?.link_group ?? "", leagueType: leagueType, username: player?.user_name ?? "", onSuccess: { (success) in
            if success{
                self.navigationController?.popViewController(animated: true)
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: "Successfully Added!".localized, shouldpop: false)
                }
                self.player = nil
            }else {
                self.showAlert(title: "", message: "Try again later!", shouldpop: false)
            }
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    func deletePlayerFromLeague(){
        showLoader()
        service.deletePlayerFromLeague(link: player?.link_group ?? "", leagueType: leagueType, username: player?.user_name ?? "", onSuccess: { (success) in
            if success{
                self.showAlert(title: "", message: "Successfully Removed!".localized, shouldpop: false)
                self.player = nil
            }else {
                self.showAlert(title: "", message: "Try again later!", shouldpop: false)
            }
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func updateLeagueInfo(name : String){
        showLoader()
        service.updateLeagueInfo(link: link, leagueType: leagueType, link_subeldwry: selectedGameWeek.link ?? "", name: name, onSuccess: { (success) in
            if success{
                self.showAlert(title: "", message: "Successfully Updated!".localized, shouldpop: false)
            }else {
                self.showAlert(title: "", message: "Try again later!", shouldpop: false)
            }
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: "Try again later!", shouldpop: false)
        }
    }
    
    func DeleteLeague(){
        showLoader()
        service.DeleteLeague(link: link, leagueType: leagueType, onSuccess: { (success) in
            if success{
                self.navigationController?.popViewController(animated: true)
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: "Successfully Deleted!".localized, shouldpop: false)
                }
            }else {
                self.showAlert(title: "", message: "Try again later!", shouldpop: false)
            }
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: "Try again later!", shouldpop: false)
        }
    }
    func initView (){
        tableView.allowsSelection = false
        tableView.register(LeagueSettingsHeaderCell.self, forCellReuseIdentifier: "LeagueSettingsHeaderCell")
        tableView.register(UINib(nibName: "LeagueSettingsHeaderCell", bundle: nil), forCellReuseIdentifier: "LeagueSettingsHeaderCell")
        tableView.register(LeagueCodeCell.self, forCellReuseIdentifier: "LeagueCodeCell")
        tableView.register(UINib(nibName: "LeagueCodeCell", bundle: nil), forCellReuseIdentifier: "LeagueCodeCell")
        tableView.register(InviteFriendCell.self, forCellReuseIdentifier: "InviteFriendCell")
        tableView.register(UINib(nibName: "InviteFriendCell", bundle: nil), forCellReuseIdentifier: "InviteFriendCell")
        tableView.register(LeagueDetailsCell.self, forCellReuseIdentifier: "LeagueDetailsCell")
        tableView.register(UINib(nibName: "LeagueDetailsCell", bundle: nil), forCellReuseIdentifier: "LeagueDetailsCell")
        tableView.register(DeletePlayerCell.self, forCellReuseIdentifier: "DeletePlayerCell")
        tableView.register(UINib(nibName: "DeletePlayerCell", bundle: nil), forCellReuseIdentifier: "DeletePlayerCell")
        tableView.register(DeleteLeagueCell.self, forCellReuseIdentifier: "DeleteLeagueCell")
        tableView.register(UINib(nibName: "DeleteLeagueCell", bundle: nil), forCellReuseIdentifier: "DeleteLeagueCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getGameWeeks (){
        self.showLoader()
        PointsPresenter().getPointsGWs(onSuccess: { (gameWeeks) in
            self.gameWeeks = gameWeeks
            self.hideLoader()
        }) { (errorMessage, code) in
            self.hideLoader()
            if code == 11 || code == 41{
                
            }else {
                self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
            }
        }
    }
}
extension LeaguesSettingsViewController: UITableViewDelegate, UITableViewDataSource, expandCellDelegate, LeagueSettingsDelegate, SelectedPlayer, SelectedGameWeek {
    func DeleteUserLeague() {
        if isNetworkReachable {
            DeleteLeague()
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    func saveNewInfo(name: String?) {
        if isNetworkReachable {
            guard let link = selectedGameWeek.link, link != "" else {
                self.showAlert(title: "", message: "Choose GameWeek!".localized, shouldpop: false)
                return
            }
            guard let leagueName = name, leagueName != "" else {
                self.showAlert(title: "", message: "Write Name!".localized, shouldpop: false)
                return
            }
            
            updateLeagueInfo(name : leagueName)
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    func selectedGameWeek(selectedItem: GWsPointsModel, textField: UITextField) {
        selectedGameWeek = selectedItem
        textField.text = selectedItem.lang_num_week
        gameWeekLinkForUpdate = selectedItem.link ?? ""
    }
    
    func chooseRound(textField: UITextField) {
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        dropDownVC.selectGWDelegate = self
        dropDownVC.selectedType = .gameWeek
        dropDownVC.gameWeeks = gameWeeks
        dropDownVC.gameWeekFromMyLeagues = true
        dropDownVC.textField = textField
        present(dropDownVC, animated: true
            , completion: nil)
    }
    
    func addAdminOrDeletePlayer(isAdmin : Bool) {
        if isNetworkReachable {
            if player != nil {
                if isAdmin {
                    addAdminToLeague()
                }else {
                    deletePlayerFromLeague()
                }
            }else {
                showAlert(title: "", message: "Choose Player".localized, shouldpop: false)
            }
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    func selectedPlayerType(selectedItem: LeaguePlayer, textField: UITextField) {
        self.player = selectedItem
        textField.text = selectedItem.display_name
    }
    
    func openPopUp(textField : UITextField) {
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        dropDownVC.selectPlayerDelegate = self
        dropDownVC.selectedType = .league_players
        dropDownVC.leagueDetails = details
        dropDownVC.textField = textField
        present(dropDownVC, animated: true
            , completion: nil)
    }
    
    func expandCell(tableView: UITableView, indexPath: IndexPath, button : UIButton) {
        if isOpened[indexPath.section]{
            isOpened[indexPath.section] = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            //            button.setImage(UIImage(named: "back_arrow2"), for: .normal)
        }else{
            isOpened[indexPath.section] = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            //            button.setImage(UIImage(named: "back_arrow"), for: .normal)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isOpened[section] {
            return 2
        }else {
            return 1
        }  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "LeagueSettingsHeaderCell") as! LeagueSettingsHeaderCell
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "LeagueCodeCell") as! LeagueCodeCell
        //        let cell2 = tableView.dequeueReusableCell(withIdentifier: "InviteFriendCell") as! InviteFriendCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "LeagueDetailsCell") as! LeagueDetailsCell
        let cell4 = tableView.dequeueReusableCell(withIdentifier: "DeletePlayerCell") as! DeletePlayerCell
        let cell5 = tableView.dequeueReusableCell(withIdentifier: "DeleteLeagueCell") as! DeleteLeagueCell
        if indexPath.row == 0 {
            headerCell.headerLbl.text = self.headerTitles[indexPath.section]
            headerCell.delegate = self
            headerCell.tableView = tableView
            headerCell.indexPath = indexPath
            return headerCell
        }else {
            if indexPath.section == 0 {
                cell1.codeTF.text = details.group_eldwry?.code
                return cell1
            }
                //            else if indexPath.section == 1 {
                //                roundViewCornersNoShadow(view: cell2.sendBT)
                //                return cell2
                //            }
            else if indexPath.section == 1 {
                roundViewCornersNoShadow(view: cell3.saveBT)
                cell3.delegate = self
                cell3.leagueNameTF.delegate = self
                cell3.leagueTF.delegate = self
                return cell3
            }else if indexPath.section == 2 {
                cell4.delegate = self
                cell4.isAdmin = false
                cell4.playerTF.delegate = self
                roundViewCornersNoShadow(view: cell4.removeBT)
                return cell4
            }else if indexPath.section == 3 {
                cell4.delegate = self
                cell4.isAdmin = true
                cell4.playerTF.delegate = self
                roundViewCornersNoShadow(view: cell4.removeBT)
                cell4.contentLbl.text = "Choose player you want to be admin instead of you.".localized
                cell4.removeBT.setTitle("Change Admin".localized, for: .normal)
                return cell4
            }else {
                roundViewCornersNoShadow(view: cell5.deleteBT)
                cell5.delegate = self
                return cell5
            }
        }
    }
}
protocol LeagueSettingsDelegate {
    func openPopUp(textField : UITextField)
    func addAdminOrDeletePlayer(isAdmin : Bool)
    func chooseRound(textField : UITextField)
    func saveNewInfo(name : String?)
    func DeleteUserLeague()
}
