//
//  LeagueRankingViewController.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/18/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import UIKit

class LeagueRankingViewController: ParentViewController {
    var viewModel = LeagueRankingViewModel()
    var typeSearch = ""
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var noDataLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeAwayTF: UITextField!
    @IBOutlet weak var homeAwayDropDown: UIButton!
    @IBOutlet weak var winLoseTF: UITextField!
    @IBOutlet weak var winLoseDropDown: UIButton!
    @IBOutlet weak var gameWeekTF: UITextField!
    @IBOutlet weak var gameWeekDropDown: UIButton!
    @IBAction func homeAwayDropDownAction(_ sender: Any) {
        let leagueRankingPopUp = LeagueRankingPopUp(nibName: "LeagueRankingPopUp", bundle: nil)
        leagueRankingPopUp.delegate = self
        leagueRankingPopUp.isWinPopUp = false
        present(leagueRankingPopUp, animated: true, completion: nil)
    }
    @IBAction func winLoseDropDownAction(_ sender: Any) {
        let leagueRankingPopUp = LeagueRankingPopUp(nibName: "LeagueRankingPopUp", bundle: nil)
        leagueRankingPopUp.delegate = self
        leagueRankingPopUp.isWinPopUp = true
        present(leagueRankingPopUp, animated: true, completion: nil)
    }
    @IBAction func gameWeekDropDownAction(_ sender: Any) {
        let subDaweryPopUp = SubDaweryPopUp(nibName: "SubDaweryPopUp", bundle: nil)
        subDaweryPopUp.delegate = self
        present(subDaweryPopUp, animated: true, completion: nil)
    }
    @IBAction func menuAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initView ()
        initViewModel ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isNetworkReachable {
            viewModel.getLeagueRankings(link: "")
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    func initViewModel (){
        viewModel.updateState = {[weak self] () in
            DispatchQueue.main.async {
                switch self?.viewModel.state {
                case .error:
                                       self?.indicator.stopAnimating()
                                       self?.indicator.alpha = 0.0
                                       self?.tableView.alpha = 0.0
                    self?.showAlert(title: "", message: "No data are available right now, try again later.".localized, shouldpop: false)
                case .loading:
                                       self?.indicator.startAnimating()
                                       self?.indicator.alpha = 1.0
                                       self?.tableView.alpha = 0.0
                                       self?.noDataLbl.alpha = 0.0
                    break
                case .loaded:
                                       self?.indicator.stopAnimating()
                                       self?.tableView.alpha = 1.0
                                       self?.indicator.alpha = 0.0
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
        viewModel.reloadTableView = { [weak self]() in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    func initView (){
        tableView.register(LeagueRankingHeaderCell.self, forCellReuseIdentifier: "LeagueRankingHeaderCell")
        tableView.register(LeagueRankingCell.self, forCellReuseIdentifier: "LeagueRankingCell")
        tableView.register(LeagueRankingExtendedCell.self, forCellReuseIdentifier: "LeagueRankingExtendedCell")
        tableView.register(UINib(nibName: "LeagueRankingExtendedCell", bundle: nil), forCellReuseIdentifier: "LeagueRankingExtendedCell")
        tableView.register(UINib(nibName: "LeagueRankingCell", bundle: nil), forCellReuseIdentifier: "LeagueRankingCell")
        tableView.register(UINib(nibName: "LeagueRankingHeaderCell", bundle: nil), forCellReuseIdentifier: "LeagueRankingHeaderCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        winLoseTF.delegate = self
        homeAwayTF.delegate = self
        gameWeekTF.delegate = self
    }
}
extension LeagueRankingViewController : UITableViewDelegate, UITableViewDataSource, LeagueRankingCellDelegate, SubDaweryPopUpDelegate, LeagueRankingPopUpDelegate {
    
    func returnChoiceType(type: String) {
        if type == "home" {
            viewModel.getHomeList()
        }else if type == "away" {
            viewModel.getAwayList()
        }
    }
    
    func returnSubDawery(model: SubDaweryModel) {
        gameWeekTF.text = model.lang_num_week ?? ""
        viewModel.getLeagueRankings(link: model.link ?? "")
    }
    
    func expandCell(section : Int) {
        if section != 0{
            if viewModel.cellsViewModels[section-1].isOpened{
            viewModel.cellsViewModels[section-1].isOpened = false
            let sections = IndexSet.init(integer: section)
            tableView.reloadSections(sections, with: .none)
        }else{
            viewModel.cellsViewModels[section-1].isOpened = true
            let sections = IndexSet.init(integer: section)
            tableView.reloadSections(sections, with: .none)
        }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cellsViewModels.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
             return 1
        }else{
            if self.viewModel.cellsViewModels[section-1].isOpened {
            return 2
        }else {
            return 1
        }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "LeagueRankingHeaderCell", for: indexPath) as! LeagueRankingHeaderCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "LeagueRankingCell", for: indexPath) as! LeagueRankingCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "LeagueRankingExtendedCell", for: indexPath) as! LeagueRankingExtendedCell

        if indexPath.section == 0 {
            tableView.rowHeight = 70
            return cell1
        }else {
            tableView.rowHeight = 70
            let cellViewModel = viewModel.getCellVM( index: indexPath.section )
            if indexPath.row == 0 {
                cell2.leagueRankingCellViewModel = cellViewModel
                cell2.delegate = self
                cell2.section = indexPath.section
                return cell2
            }else{
                tableView.rowHeight = 320
                cell3.expandedCellViewModel = cellViewModel.expandedCellViewModel
                return cell3
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
protocol LeagueRankingCellDelegate {
    func expandCell(section : Int)
}
