//
//  NotifyTypeVC.swift
//  GameClub
//
//  Created by Basma on 11/24/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class NotifyTypeVC: ParentViewController {
    
    var selectedTeams = [SelectedTeam]()
    var buttonsSelected = [ButtonSelectedState]()

    @IBOutlet weak var backBT: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var sendBT: UIButton!
    @IBAction func sendAction(_ sender: Any) {
        let arrayString = createArrayString ()
        if isNetworkReachable{
            sendTeamSellected(arrayString : arrayString)
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }

    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initView ()
        createSelectedButtonsArray ()
    }
    
    func initView (){
        if "lang".localized == "en"{
            self.backBT.transform = CGAffineTransform(scaleX: -1, y: 1);
        }
        roundViewCornersNoShadow(view: sendBT)
        roundViewCorners(view: containerView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(NotifyTypeCell.self, forCellReuseIdentifier: "NotifyTypeCell")
        tableView.register(UINib(nibName: "NotifyTypeCell", bundle: nil), forCellReuseIdentifier: "NotifyTypeCell")
        tableView.register(NotifyTypeHeaderCell.self, forCellReuseIdentifier: "NotifyTypeHeaderCell")
        tableView.register(UINib(nibName: "NotifyTypeHeaderCell", bundle: nil), forCellReuseIdentifier: "NotifyTypeHeaderCell")
    }
    func createSelectedButtonsArray (){
        for item in selectedTeams {
            buttonsSelected.append(ButtonSelectedState(emailBTSelected: false, notifiBTSelected: false))
        }
    }
    
    func sendTeamSellected(arrayString : String){
        self.showLoader()
        FavTeamPresenter().addFollowingTeam(teamsArrayString: arrayString, onSuccess: { (success) in
            if success {
                let startPageVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "StartPageVC") as! StartPageVC
                self.navigationController?.pushViewController(startPageVC, animated: true)
            }
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func createArrayString() -> String{
        
        var arrayString = ""
        for n in 0...selectedTeams.count - 1 {
            
            if buttonsSelected[n].emailBTSelected {
                selectedTeams[n].is_email = 1
            }
            if buttonsSelected[n].notifiBTSelected {
                selectedTeams[n].is_notif = 1
            }
            
            arrayString += #"{"link":"\#(selectedTeams[n].link)","is_email":"\#(selectedTeams[n].is_email)""#
            arrayString += #","is_notif":"\#(selectedTeams[n].is_notif)"}"#
            
            if n != selectedTeams.count-1 {
                arrayString += ","
            }else {
                arrayString = "[\(arrayString)]"
            }
        }
        print(arrayString)
        return arrayString
    }

}
extension NotifyTypeVC : UITableViewDelegate, UITableViewDataSource, NotifyTypeDelegate {
    func getNotifiedByEmail(bt: UIButton, index: Int, isChecked : Bool) {
        if !isChecked {
            bt.backgroundColor = UIColor.green
            buttonsSelected[index].emailBTSelected = true
        }else {
            bt.backgroundColor = Color.notifyBTSelected.value
            buttonsSelected[index].emailBTSelected = false
        }
        tableView.reloadData()
    }
    
    func getNotifiedByNotifi(bt: UIButton, index: Int, isChecked : Bool) {
        if !isChecked {
            bt.backgroundColor = UIColor.green
            buttonsSelected[index].notifiBTSelected = true
        }else {
            bt.backgroundColor = Color.notifyBTSelected.value
            buttonsSelected[index].notifiBTSelected = false
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedTeams.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "NotifyTypeHeaderCell") as! NotifyTypeHeaderCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifyTypeCell") as! NotifyTypeCell
        if indexPath.row == 0 {
            return headerCell
        }else {
            cell.teamLbl.text = selectedTeams[indexPath.row - 1].name
            cell.delegate = self
            if buttonsSelected[indexPath.row - 1].emailBTSelected {
                cell.emailBT.backgroundColor = UIColor.green
            }else {
                cell.emailBT.backgroundColor = Color.notifyBTSelected.value
            }
            if buttonsSelected[indexPath.row - 1].notifiBTSelected {
                cell.notificationBT.backgroundColor = UIColor.green
            }else {
                cell.notificationBT.backgroundColor = Color.notifyBTSelected.value
            }
            cell.index = indexPath.row - 1
            cell.emailBTChecked = buttonsSelected[indexPath.row - 1].emailBTSelected
            cell.notifyBTChecked = buttonsSelected[indexPath.row - 1].notifiBTSelected
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }else {
            return 60
        }
    }
    
}
struct ButtonSelectedState {
    var emailBTSelected : Bool
    var notifiBTSelected : Bool
}
