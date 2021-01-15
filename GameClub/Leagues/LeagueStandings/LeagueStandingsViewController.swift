//
//  LeagueStandingsViewController.swift
//  GameClub
//
//  Created by Basma on 10/7/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class LeagueStandingsViewController: ParentViewController {
    
    var league = ""
    var link = ""
    var viewModel = LeagueStandingsViewModel()
    var StandingsType = "classic"
    var tapType = 0
    
    @IBOutlet weak var headStandingsBT: UIButton!
    @IBOutlet weak var headMatchesBT: UIButton!
    @IBOutlet weak var headOptionsStack: UIStackView!
    @IBOutlet weak var noDataLbl: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leagueNameLbl: UILabel!
    @IBOutlet weak var sortByTF: UITextField!
    @IBOutlet weak var downBT: UIButton!
    @IBAction func menuAction(_ sender: Any) {
        openMenu()
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    @IBAction func downAction(_ sender: Any) {
        openGameWeekList ()
    }
    @IBAction func standingsAction(_ sender: Any) {
        tapType = 0
        self.tableView.reloadData()
        
    }
    @IBAction func matchesAction(_ sender: Any) {
        tapType = 1
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if isNetworkReachable {
            viewModel.getGameWeeks(link: link, type: StandingsType)
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
        initView ()
        initViewModel()
    }
    func initViewModel () {
        viewModel.updateState = {[weak self] () in
            DispatchQueue.main.async {
                switch self?.viewModel.state {
                case .error:
                    self?.indicator.stopAnimating()
                    self?.tableView.alpha = 0.0
                    self?.showAlert(title: "", message: "Standings are not available right now, try again later.".localized, shouldpop: false)
                case .loading:
                    self?.indicator.startAnimating()
                    self?.indicator.alpha = 1.0
                    self?.tableView.alpha = 0.0
                    self?.noDataLbl.alpha = 0.0
                    break
                case .loaded:
                    self?.indicator.stopAnimating()
                    self?.tableView.alpha = 1.0
                    break
                case .empty:
                    self?.indicator.stopAnimating()
                    self?.tableView.alpha = 0.0
                    self?.indicator.alpha = 0.0
                    self?.noDataLbl.alpha = 1.0
                    break
                    
                case .none: break
                    
                }
            }
        }
        reloadTableView ()
        
    }
    
    func reloadTableView (){
        viewModel.reloadTableView = { [weak self]() in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func initView (){
        if StandingsType == "head"{
            headOptionsStack.isHidden = false
        }
        roundViewCorners(view: containerView)
        roundViewCornersNoShadow(view: headMatchesBT)
        roundViewCornersNoShadow(view: headStandingsBT)
        tableView.register(LeagueStandingsHeaderCell.self, forCellReuseIdentifier: "LeagueStandingsHeaderCell")
        tableView.register(LeagueStandingCell.self, forCellReuseIdentifier: "LeagueStandingCell")
        tableView.register(LeagueStandingCell.self, forCellReuseIdentifier: "StandingMatchCell")
        tableView.register(UINib(nibName: "LeagueStandingCell", bundle: nil), forCellReuseIdentifier: "LeagueStandingCell")
        tableView.register(UINib(nibName: "StandingMatchCell", bundle: nil), forCellReuseIdentifier: "StandingMatchCell")
        tableView.register(UINib(nibName: "LeagueStandingsHeaderCell", bundle: nil), forCellReuseIdentifier: "LeagueStandingsHeaderCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        leagueNameLbl.text = league
    }
    
    func openGameWeekList (){
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        dropDownVC.selectGWDelegate = self
        dropDownVC.selectedType = .gameWeek
        dropDownVC.gameWeeks = (self.viewModel.gameWeeks)
        dropDownVC.gameWeekFromMyLeagues = true
        dropDownVC.textField = self.sortByTF
        self.present(dropDownVC, animated: true
            , completion: nil)
    }
    
}
extension LeagueStandingsViewController : UITableViewDelegate, UITableViewDataSource, SelectedGameWeek {
    
    func selectedGameWeek(selectedItem: GWsPointsModel, textField: UITextField) {
        textField.text = selectedItem.lang_num_week
        if isNetworkReachable {
            viewModel.getLeagueStandings(link: link, type: StandingsType, gameWeekLink: selectedItem.link ?? "")
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tapType == 0 {
            return viewModel.numberOfCells + 1
        }else {
            return viewModel.numberOfMatchCells
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 50
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "LeagueStandingsHeaderCell") as! LeagueStandingsHeaderCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueStandingCell") as! LeagueStandingCell
        let matchCell = tableView.dequeueReusableCell(withIdentifier: "StandingMatchCell") as! StandingMatchCell
        if tapType == 0 {
            if indexPath.row == 0 {
                return headerCell
            }else {
                let cellViewModel = viewModel.getCellVM( indexPath: indexPath )
                cell.leagueStandingsCellViewModel = cellViewModel
                return cell
            }
            
        }else {
            tableView.rowHeight = 100
            
            let matchCellViewModel = viewModel.getMatchCellVM( indexPath: indexPath )
            matchCell.matchStandingsCellViewModel = matchCellViewModel
            return matchCell
        }
    }

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {}
}
}
