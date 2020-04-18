//
//  InstructionsVC.swift
//  GameClub
//
//  Created by Basma on 4/16/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class InstructionsVC: ParentViewController , UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.instructions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionsCell", for: indexPath) as! InstructionsCell
        self.bgLayers[indexPath.row].frame = cell.headerView.frame
        cell.headerView.layer.insertSublayer(self.bgLayers[indexPath.row], at: 0)
        cell.index = indexPath.row
        cell.delegate = self
        cell.isExpanded = self.isExpanded[indexPath.row]
        cell.titleLbl.text = self.instructions[indexPath.row].title
        cell.contentTV.text = self.instructions[indexPath.row].content

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isExpanded[indexPath.row] && indexPath.row == self.cellIndex[indexPath.row]{
            return 209
        }else {
            return 70
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            if isExpanded[indexPath.row] && indexPath.row == self.cellIndex[indexPath.row]{
                return 209
            }else {
                return 70
            }
        
    }
    var pageNum = 0
    var isExpanded = [Bool]()
    var cellIndex = [Int]()
    var presenter = InstructionsPresenter ()
    var instructions = [InstructionModel]()
    var colors = [Colors]()
    var bgLayers = [CAGradientLayer]()

    @IBOutlet weak var conainerV: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuBT: UIButton!
    @IBOutlet weak var backBT: UIButton!
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if pageNum == 1{self.titleLabel.text = "المساعدة"}
        roundViewCorners(view: conainerV)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getInstructions()
    }
    
    func getInstructions(){
           self.showLoader()
           presenter.getInstructions(onSuccess: { (role, help) in
            if self.pageNum == 0{
            self.instructions = role
            }else {
                self.instructions = help
            }
            for item in self.instructions {
                self.isExpanded.append(true)
            }
            for i in 0..<self.instructions.count {
                self.cellIndex.append(i)
            }
            for n in 0..<self.instructions.count {
                self.colors.append(Colors())
            }
            for n in 0..<self.instructions.count {
                let backgroundLayer = self.colors[n].gl!
                self.bgLayers.append(backgroundLayer)
            }
            
               self.tableView.reloadData()
               self.hideLoader()
           }) { (errorMessage) in
               self.hideLoader()
               self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
           }
       }

}
extension InstructionsVC : InstructionsDelegate {
    func showHideTV (contentTV : UITextView, bottomConstraint : [NSLayoutConstraint], isExpanded : Bool, index : Int){
        self.cellIndex[index] = index
        if !self.isExpanded[index] {
            self.isExpanded[index] = true
            contentTV.isHidden = false
            bottomConstraint[0].isActive = true
            bottomConstraint[1].isActive = true
        }else {
            self.isExpanded[index] = false
            contentTV.isHidden = true
            bottomConstraint[0].isActive = false
            bottomConstraint[1].isActive = false
        }
        self.tableView.reloadData()
    }
}
class Colors {
    var gl:CAGradientLayer!

    init() {
        let colorTop = UIColor(red: 0.0 / 255.0, green: 185.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0).cgColor

        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}
