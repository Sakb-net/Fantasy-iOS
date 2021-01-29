//
//  LeagueRankingExtendedCell.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/19/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import UIKit

class LeagueRankingExtendedCell: UITableViewCell {
    var filterType = "no"
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var fourthLbl: UILabel!
    @IBOutlet weak var fifthLbl: UILabel!
    @IBOutlet weak var lastResultDateLbl: UILabel!
    @IBOutlet weak var nextMatchDateLbl: UILabel!
    @IBOutlet weak var lastResultFirstNameLbl: UILabel!
    @IBOutlet weak var lastResultSecondNameLbl: UILabel!
    @IBOutlet weak var nextMatchFirstNameLbl: UILabel!
    @IBOutlet weak var nextMatchSecondNameLbl: UILabel!
    @IBOutlet weak var lastResultFirstIV: UIImageView!
    @IBOutlet weak var lastResultSecondIV: UIImageView!
    @IBOutlet weak var nextMatchFirstIV: UIImageView!
    @IBOutlet weak var nextMatchSecondIV: UIImageView!
    @IBOutlet weak var lastResultScoreLbl: UILabel!
    @IBOutlet weak var nextMatchTimeLbl: UILabel!
    
    var expandedCellViewModel : ExpandedCellViewModel? {
        didSet {
            fillStackView()
            fillData()
        }
    }
    func fillStackView(){
        let labels = [firstLbl, secondLbl, thirdLbl, fourthLbl, fifthLbl]
        if let forms = expandedCellViewModel?.form {
            if forms.count > 0 && forms.count <= labels.count{
                if filterType == "no"{
                    for n in 0...forms.count - 1{
                        roundViewCorners(view: labels[n]!)
                        labels[n]?.text = forms[n].state
                        if forms[n].state == "w" {
                            labels[n]?.backgroundColor = Color.winColor.value
                        }else if forms[n].state == "l" {
                            labels[n]?.backgroundColor = Color.lossColor.value
                        }else{
                            labels[n]?.backgroundColor = Color.drawColor.value
                        }
                        
                    }
                }else if filterType == "w" {
                    var i = 0
                    for n in 0...forms.count - 1{
                        roundViewCorners(view: labels[i]!)
                        labels[i]?.text = forms[n].state
                        if forms[n].state == "w" {
                            labels[i]?.backgroundColor = Color.winColor.value
                            i += 1
                        }
                    }
                }else if filterType == "l"{
                    var i = 0
                    for n in 0...forms.count - 1{
                        roundViewCorners(view: labels[i]!)
                        labels[i]?.text = forms[n].state
                        if forms[n].state == "l" {
                            labels[i]?.backgroundColor = Color.lossColor.value
                            i += 1
                        }
                    }
                }
            }
        }else{
            
        }
        
    }
    func fillData(){
        
        lastResultDateLbl.text = expandedCellViewModel?.lastResultDate
        nextMatchDateLbl.text = expandedCellViewModel?.nextMatchDate
        lastResultFirstNameLbl.text = expandedCellViewModel?.lastResultFirstName
        lastResultSecondNameLbl.text = expandedCellViewModel?.lastResultSecondName
        nextMatchFirstNameLbl.text = expandedCellViewModel?.nextMatchFirstName
        nextMatchSecondNameLbl.text = expandedCellViewModel?.nextMatchSecondName
        lastResultFirstIV.sd_setImage(with: URL(string: "https://devfantasy.sakb-co.com.sa/" + (expandedCellViewModel?.lastResultFirstImage ?? "") ), placeholderImage: UIImage(named: "placeholder"))
        lastResultSecondIV.sd_setImage(with: URL(string: "https://devfantasy.sakb-co.com.sa/" + (expandedCellViewModel?.lastResultSecondImage ?? "") ), placeholderImage: UIImage(named: "placeholder"))
        nextMatchFirstIV.sd_setImage(with: URL(string: "https://devfantasy.sakb-co.com.sa/" + (expandedCellViewModel?.nextMatchFirstImage ?? "") ), placeholderImage: UIImage(named: "placeholder"))
        nextMatchSecondIV.sd_setImage(with: URL(string: "https://devfantasy.sakb-co.com.sa/" + (expandedCellViewModel?.nextMatchSecondImage ?? "") ), placeholderImage: UIImage(named: "placeholder"))
        
        if "lang".localized == "en"{
            lastResultScoreLbl.text = expandedCellViewModel!.lastResultFirstScore + "-" + expandedCellViewModel!.lastResultSecondScore
        }else if "lang".localized == "ar"{
            lastResultScoreLbl.text = expandedCellViewModel!.lastResultSecondScore + "-" + expandedCellViewModel!.lastResultFirstScore
        }
        nextMatchTimeLbl.text = expandedCellViewModel?.nextMatchTime
    }
    
    func roundViewCorners(view : UIView){
        view.layer.cornerRadius = 17
        view.clipsToBounds = true
    }
    
}
