//
//  LeagueRankingCellViewModel.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/23/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import Foundation
struct LeagueRankingCellViewModel {
    var isOpened : Bool
    var rank : String
    var teamImageName : String
    var teamName : String
    var plays : String
    var win : String
    var draw : String
    var loss : String
    var teams : String
    var points : String
    var expandedCellViewModel : ExpandedCellViewModel
}
