//
//  LeagueRankingViewModel.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/23/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import Foundation
class LeagueRankingViewModel {
    var leagueRankingModelsCount = 0
    var filterList = [LeagueRankingModel]()

    var leagueRankingModels = [LeagueRankingModel]()
    var reloadTableView: (()->())?
    var updateState: (()->())?
    
    var cellsViewModels : [LeagueRankingCellViewModel] = [LeagueRankingCellViewModel](){
        didSet {
            self.reloadTableView?()
        }
    }
    
    var state : State = .empty {
        didSet {
            self.updateState?()
        }
    }
    
    var numberOfCells : Int {
        return leagueRankingModelsCount
    }
    var filterType = "no"
    
    
    func createCellViewModel (leagueRankingModel : LeagueRankingModel) -> LeagueRankingCellViewModel {
        let expandedCellViewModel = ExpandedCellViewModel(form: leagueRankingModel.form ?? [FormModel()], lastResultDate: leagueRankingModel.current_match?.date_day ?? "", nextMatchDate: leagueRankingModel.next_match?.date_day ?? "", lastResultFirstName: leagueRankingModel.current_match?.first_team_name ?? "", lastResultSecondName: leagueRankingModel.current_match?.second_team_name ?? "", nextMatchFirstName: leagueRankingModel.team_code ?? "", nextMatchSecondName: leagueRankingModel.next_match?.second_team_name ?? "", lastResultFirstImage: leagueRankingModel.current_match?.first_team_image ?? "", lastResultSecondImage: leagueRankingModel.current_match?.second_team_image ?? "", nextMatchFirstImage: leagueRankingModel.team_image ?? "", nextMatchSecondImage: leagueRankingModel.next_match?.second_team_image ?? "", lastResultFirstScore: leagueRankingModel.current_match?.first_team_goon ?? "", lastResultSecondScore: leagueRankingModel.current_match?.second_team_goon ?? "", nextMatchTime: leagueRankingModel.next_match?.time ?? "")
        return LeagueRankingCellViewModel(isOpened: leagueRankingModel.isOpend,filterType:filterType, rank: leagueRankingModel.index ?? "", teamImageName: leagueRankingModel.team_image ?? "", teamName: leagueRankingModel.team_code ?? "", plays: leagueRankingModel.count_played ?? "", win: leagueRankingModel.won ?? "", draw: leagueRankingModel.draw ?? "", loss: leagueRankingModel.loss ?? "", teams: "2", points: leagueRankingModel.points ?? "", expandedCellViewModel: expandedCellViewModel)
    }
    
    func getCellVM(index: Int) -> LeagueRankingCellViewModel {
        return cellsViewModels[index - 1]
    }
    
    private func createCellsVMs(leagueRankingModels: [LeagueRankingModel]) {
        self.leagueRankingModels = leagueRankingModels
        var leagueRankingCellViewModel = [LeagueRankingCellViewModel]()
        for league in leagueRankingModels {
            leagueRankingCellViewModel.append(createCellViewModel(leagueRankingModel: league))
        }
        self.cellsViewModels = leagueRankingCellViewModel
    }
    
    func getLeagueRankings(link: String)
    {
        state = .loading
        let url = "https://devfantasy.sakb-co.com.sa/api/v1/ranking_eldwry?subeldwry_link=" + link
        
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                
                if let data = response!["data"]["ranking_eldwry"].array {
                    
                    var leagueRankingModels = [LeagueRankingModel]()
                    for n in 0...data.count - 1 {
                        var model = LeagueRankingModel(parametersJson: data[n].dictionaryValue)
                        model.index = String(n+1)
                        leagueRankingModels.append(model)
                    }
                    self.leagueRankingModels = leagueRankingModels
                    self.filterList = leagueRankingModels
                    self.createCellsVMs(leagueRankingModels: leagueRankingModels)
                    self.leagueRankingModelsCount = leagueRankingModels.count
                    self.state = State.loaded
                }else {
                    
                }
            }else{
                self.state = State.error
            }
            
        }
    }
    func getHomeList(){
        var homeList = [LeagueRankingModel]()
        for item in filterList {
            if item.current_match?.location_type == "home"{
                homeList.append(item)
            }
        }
        self.createCellsVMs(leagueRankingModels: homeList)
    }
    
    func getAwayList(){
        var awayList = [LeagueRankingModel]()
        for item in filterList {
            if item.current_match?.location_type == "away"{
                awayList.append(item)
            }
        }
        self.createCellsVMs(leagueRankingModels: awayList)
    }
    
    func getWinList() {
        var winModels = [LeagueRankingModel]()
        for model in filterList {
            if let forms = model.form {
                for form in forms {
                    if form.state == "w" {
                        filterType = "w"
                        model.filterType = "w"
                        winModels.append(model)
                        break
                    }
                }
            }
        }
        self.createCellsVMs(leagueRankingModels: winModels)
    }
    
    func getLossList() {
        var lossModels = [LeagueRankingModel]()
        for model in filterList {
            if let forms = model.form {
                for form in forms {
                    if form.state == "l" {
                        filterType = "l"
                        model.filterType = "l"
                        lossModels.append(model)
                        break
                    }
                }
            }
        }
        self.createCellsVMs(leagueRankingModels: lossModels)
    }
    
    func selectLeague(index : Int) -> LeagueRankingModel{
        return leagueRankingModels[index]
    }
}
