//
//  MyTeamVC.swift
//  GameClub
//
//  Created by Basma on 3/30/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class MyTeamVC: ParentViewController {

    @IBOutlet weak var defenderCV: UICollectionView!
    @IBOutlet weak var midCV: UICollectionView!
    @IBOutlet weak var attackCV: UICollectionView!

    @IBOutlet weak var subBT1: UIButton!
    @IBOutlet weak var subBT2: UIButton!
    @IBOutlet weak var subBT3: UIButton!
    @IBOutlet weak var subBT4: UIButton!
    
    @IBOutlet weak var subNameLbl1: UILabel!
    @IBOutlet weak var subNameLbl2: UILabel!
    @IBOutlet weak var subNameLbl3: UILabel!
    @IBOutlet weak var subNameLbl4: UILabel!

    @IBOutlet weak var subPointsLbl1: UILabel!
    @IBOutlet weak var subPointsLbl2: UILabel!
    @IBOutlet weak var subPointsLbl3: UILabel!
    @IBOutlet weak var subPointsLbl4: UILabel!
    
    @IBOutlet weak var goalKeeperBT: UIButton!
    
    @IBOutlet weak var goalKeeperNameLbl: UILabel!
    
    @IBOutlet weak var playerPointLbl: UILabel!
    
    @IBOutlet weak var captinCardBT: UIButton!
    @IBOutlet weak var substitutionsCardBT: UIButton!
    
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var pitchBT: UIButton!
    @IBOutlet weak var listBT: UIButton!
    
    @IBAction func menuAction(_ sender: Any) {
    }
    @IBAction func backAction(_ sender: Any) {
    }
    @IBAction func showPitchAction(_ sender: Any) {
    }
    @IBAction func showListAction(_ sender: Any) {
    }
    @IBAction func substitutionsCardAction(_ sender: Any) {
    }
    @IBAction func captinCardAction(_ sender: Any) {
    }
    @IBAction func goalkeeperAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
