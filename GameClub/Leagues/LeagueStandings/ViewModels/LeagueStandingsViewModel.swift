//
//  LeagueStandingsViewModel.swift
//  GameClub
//
//  Created by Basma on 10/10/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
class LeagueStandingsViewModel {
    
    var players = [LeaguePlayer]()
    var matches = [MatchGroupStandings]()
    var reloadTableView: (()->())?
    var updateState: (()->())?
    var gameWeeks = [GWsPointsModel]()
    var cellsViewModels : [LeagueStandingsCellViewModel] = [LeagueStandingsCellViewModel](){
        didSet {
            self.reloadTableView?()
        }
    }
    
    var matchCellsViewModels : [MatchStandingsCellViewModel] = [MatchStandingsCellViewModel](){
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
        return cellsViewModels.count
    }
    
    var numberOfMatchCells : Int {
        return matchCellsViewModels.count
    }
   
    func createCellViewModel (player : LeaguePlayer) -> LeagueStandingsCellViewModel {
        return LeagueStandingsCellViewModel(name: "  " + (player.display_name ?? "Name"), rank: player.sort ?? "??", points: player.total_points ?? "??", GWPoints: player.gw_points ?? "??")
    }
    
    func createMatchCellViewModel (match : MatchGroupStandings) -> MatchStandingsCellViewModel {
        return MatchStandingsCellViewModel(firstTeam: match.first_team_name ?? "??", seacondTeam: match.second_team_name ?? "??", firstUsername: match.first_user_name ?? "??", secondUsername: match.second_user_name ?? "??", firstPoints: match.first_team_points ?? "??", secondPoints: match.second_team_points ?? "??")
    }
    
    func getCellVM(indexPath: IndexPath) -> LeagueStandingsCellViewModel {
        return cellsViewModels[indexPath.row - 1]
    }
    
    func getMatchCellVM(indexPath: IndexPath) -> MatchStandingsCellViewModel {
        return matchCellsViewModels[indexPath.row - 1]
    }
    
    private func createCellsVMs(players: [LeaguePlayer]) {
        self.players = players
        var leagueStandingsCellViewModel = [LeagueStandingsCellViewModel]()
        for player in players {
            leagueStandingsCellViewModel.append(createCellViewModel(player: player))
        }
        self.cellsViewModels = leagueStandingsCellViewModel
    }
    
    private func createMatchCellsVMs(matches: [MatchGroupStandings]) {
        self.matches = matches
        var matchStandingsCellViewModel = [MatchStandingsCellViewModel]()
        for match in matches {
            matchStandingsCellViewModel.append(createMatchCellViewModel(match: match))
        }
        self.matchCellsViewModels = matchStandingsCellViewModel
    }
    
    func getLeagueStandings(link : String, type : String, gameWeekLink : String)
    {
        state = .loading
        let url = Urls().getLeagueStandings(link: link, type : type)
        let parameters = ["link_subeldwry": gameWeekLink]
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                //                let statusCode = response!["StatusCode"].intValue
                let data = response!["data"].dictionaryValue
                let leagueStandings = LeagueStandingsModel(parametersJson: data)
                
                if let players = leagueStandings.users_group  {
                    if players.count == 0 {
                    self.state = State.empty
                }else {
                    self.state = State.loaded
                    self.createCellsVMs(players: players)
                }
                    
                }else {
                    
                }
                
                if let matches = leagueStandings.matches_group  {
                    if matches.count == 0 {
                    self.state = State.empty
                }else {
                    self.state = State.loaded
                    self.createMatchCellsVMs(matches: matches)
                }
                    
                }else {
                    
                }
            }else{
                self.state = State.error
            }
            
        }
    }
    func selectLeague(index : Int) -> LeaguePlayer{
        return players[index]
    }
    
    func returnGameWeeks() -> [GWsPointsModel]{
        return self.gameWeeks
    }
    
    func getGameWeeks (link: String, type : String){
        getPointsGWs(link: link, type: type, onSuccess: { (gameWeeks) in
            self.gameWeeks = gameWeeks
            self.getLeagueStandings(link : link, type: type, gameWeekLink : gameWeeks[0].link ?? "")
        }) { (errorMessage, code) in
            if code == 11 || code == 41{
                
            }else {
            }
        }
    }
    func getPointsGWs(link: String, type : String, onSuccess: @escaping ([GWsPointsModel]) -> Void, onFailure: @escaping (String?, Int) -> Void ) -> Void
    {
        let url = Urls().getStandingsGWs(link: link, type: type)
       
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue

                if let data = response!["data"].array{
                    var gwsPointsModels = [GWsPointsModel]()
                    let overall = GWsPointsModel()
                    overall.name = "Overall"
                    overall.lang_num_week = "Overall"
                    overall.link = ""
                    gwsPointsModels.append(overall)
                for item in data {
                    gwsPointsModels.append(GWsPointsModel(parametersJson: item.dictionaryValue))

                }
                    onSuccess(gwsPointsModels)
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message, statusCode)
                }
                }else{
                    onFailure("Something went wrong try again later!".localized, 1000)

                }
            
        }
    }
}
