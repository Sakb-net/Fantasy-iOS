



import UIKit

class FavTeamCell: UITableViewCell {
    var rowIndex : Int?
    var delegate : SelectTeamDelegate?
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var selectedTeamBT: UIButton!
    
    @IBAction func selectTeamAction(_ sender: Any) {
        delegate?.changeBTColor(bt: self.selectedTeamBT, index: rowIndex!)
    }
}


protocol SelectTeamDelegate {
    func changeBTColor (bt : UIButton, index : Int)
}
