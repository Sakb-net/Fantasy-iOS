//
//  MyTeamVC.swift
//  GameClub
//
//  Created by Basma on 3/30/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class MyTeamVC: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
       var goalKeepers = [MyTeam]()
       var defenders = [MyTeam]()
       var mids = [MyTeam]()
       var attackers = [MyTeam]()
       var subs = [MyTeam]()

       var presenter = MyTeamPresenter ()
       
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
    
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 3,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return self.defenders.count
        }else if collectionView.tag == 1 {
            return self.mids.count
        }else {
            return self.attackers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: "DefenderCell", for: indexPath) as! DefenderCell
        cell.playerNameLbel.text = self.defenders[indexPath.row].name_player
        if let points = self.defenders[indexPath.row].point_player {
        cell.playerPointsLbl.text = String(points)
        }
        cell.playerBT.sd_setImage(with: URL(string:Urls.baseUrl + self.defenders[indexPath.row].image_player!), for: .normal)
                   
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {

        let totalCellWidth = 62 * self.defenders.count
        let totalSpacingWidth = 30 * (self.defenders.count - 1)

        let leftInset = (self.defenderCV.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        cvConfig()
        getMyTeam()
        
    }
    
    func getMyTeam(){
        presenter.getMyTeam( onSuccess: { (goalKeepers, defenders, mids, attackers, subs, lineup) in
            self.hideLoader()
            self.goalKeepers = goalKeepers
            self.defenders = defenders
            self.mids = mids
            self.attackers = attackers
            self.defenderCV.delegate = self
            self.defenderCV.dataSource = self
            self.defenderCV.reloadData()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func cvConfig() {
        self.defenderCV?.collectionViewLayout = columnLayout
            self.defenderCV?.contentInsetAdjustmentBehavior = .always
        }

    }
    
extension MyTeamVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 115)
        
    }
    
}

class ColumnFlowLayout: UICollectionViewFlowLayout {

    let cellsPerRow: Int

    init(cellsPerRow: Int, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.cellsPerRow = cellsPerRow
        super.init()

        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }
        let marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        itemSize = CGSize(width: itemWidth, height: itemWidth)
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }

}
