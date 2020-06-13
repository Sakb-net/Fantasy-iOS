//
//  FixtureDetailsVC.swift
//  GameClub
//
//  Created by Basma on 5/31/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class FixtureDetailsVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    var matchGroup = MatchGroup()
    var playersName1 = ["احمد محمد","عمرو السومة","احمد محمد","عمرو السومة","احمد محمد", "احمد محمد","عمرو السومة","احمد محمد","عمرو السومة","احمد محمد"]
    var playersName2 = ["احمد محمد","عمرو السومة","احمد محمد", "احمد محمد", "احمد محمد", "احمد محمد"]
    var actionType1 = [0, 0, 1, 1, 2, 4, 5, 5, 6, 6]
    var actionType2 = [2, 2, 3, 4, 6, 6]

    var time1 = ["17'","50'","40'","80'","75'","(3)","50 نقطة","40 نقطة","80 نقطة","75 نقطة"]
    var time2 = ["17'","50'","40'","(2)","30 نقطة","17 نقطة"]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageTitleLbl: UILabel!
    @IBOutlet weak var firstClubName: UILabel!
    @IBOutlet weak var firstClubIV: UIImageView!
    @IBOutlet weak var secondClubName: UILabel!
    @IBOutlet weak var secondClubIV: UIImageView!
//    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let title = matchGroup.name_first! + " و " + matchGroup.name_second!
        pageTitleLbl.text = title
        firstClubName.text = matchGroup.name_first
        secondClubName.text = matchGroup.name_second
        firstClubIV.sd_setImage(with: URL(string: Urls.baseUrl+matchGroup.image_first! ), placeholderImage: UIImage(named: "placeholder"))
        secondClubIV.sd_setImage(with: URL(string: Urls.baseUrl+matchGroup.image_second! ), placeholderImage: UIImage(named: "placeholder"))
        
        let firstScore = matchGroup.first_goon
        let secondScore = matchGroup.second_goon
        
        var firstScoreString = ""
        var secondScoreString = ""
        if let score1 = firstScore{
            firstScoreString = String(score1)
        }
        if let score2 = secondScore{
            secondScoreString = String(score2)
        }
        scoreLabel.text = firstScoreString + " - " + secondScoreString
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playersName1.count + self.playersName2.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "PlayerActionCell", for: indexPath) as! PlayerActionCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
        var imageName = ""
        if  indexPath.row > 0 {
        if indexPath.row < self.playersName1.count + 1 {
        cell1.nameLbl.text = self.playersName1[indexPath.row - 1]
            cell1.timeLbl.text = self.time1[indexPath.row - 1]
            print(indexPath.row)
        if self.actionType1[indexPath.row - 1] == 0 {
            imageName = "sport"
            cell1.actionIV.isHidden = false
            cell1.actionNameLbl.isHidden = true
        }else if self.actionType1[indexPath.row - 1] == 1{
            cell1.actionNameLbl.text = "مساهمة"
        }else if self.actionType1[indexPath.row - 1] == 2 {
            imageName = "yellow"
            cell1.actionIV.isHidden = false
            cell1.actionNameLbl.isHidden = true
        }else if self.actionType1[indexPath.row - 1] == 3 {
            imageName = "red"
            cell1.actionIV.isHidden = false
            cell1.actionNameLbl.isHidden = true
        }else if self.actionType1[indexPath.row - 1] == 4 {
            cell1.actionNameLbl.text = "تصدي"
        }else if self.actionType1[indexPath.row - 1] == 5 {
            cell1.actionNameLbl.text = "نقاط إضافية"
        }else if self.actionType1[indexPath.row - 1] == 6 {
            cell1.actionNameLbl.text = "نظام النقاط الإضافية"
        }
        }else if indexPath.row - self.playersName1.count - 1 < self.actionType2.count{
            cell1.nameLbl.text = self.playersName2[indexPath.row - self.playersName1.count - 1]
            cell1.timeLbl.text = self.time2[indexPath.row - self.playersName1.count - 1]
            print(indexPath.row - self.playersName1.count - 1)
            if self.actionType2[indexPath.row - self.playersName1.count - 1] == 0 {
                        imageName = "sport"
                cell1.actionIV.isHidden = false
                cell1.actionNameLbl.isHidden = true
                    }else if self.actionType2[indexPath.row - self.playersName1.count - 1] == 1{
                cell1.actionNameLbl.text = "مساهمة"
                    }else if self.actionType2[indexPath.row - self.playersName1.count - 1] == 2 {
                        imageName = "yellow"
                cell1.actionIV.isHidden = false
                cell1.actionNameLbl.isHidden = true
                    }else if self.actionType2[indexPath.row - self.playersName1.count - 1] == 3 {
                        imageName = "red"
                cell1.actionIV.isHidden = false
                cell1.actionNameLbl.isHidden = true
                    }else if self.actionType2[indexPath.row - self.playersName1.count - 1] == 4 {
                        cell1.actionNameLbl.text = "تصدي"
                    }else if self.actionType2[indexPath.row - self.playersName1.count - 1] == 5 {
                        cell1.actionNameLbl.text = "نقاط إضافية"
                    }else if self.actionType2[indexPath.row - self.playersName1.count - 1] == 6 {
                        cell1.actionNameLbl.text = "نظام النقاط الإضافية"
                    }
        }
        }
        cell1.actionIV.image = UIImage(named: imageName)
        if indexPath.row == 0 {
            cell2.clubNameLbl.text = self.matchGroup.name_first
            return cell2
        }else if indexPath.row == self.playersName1.count {
            cell2.clubNameLbl.text = self.matchGroup.name_second
            return cell2
        }else {
            return cell1
        }
    }
    
}
