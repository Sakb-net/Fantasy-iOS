



import UIKit

class FavTeamCell: UITableViewCell {
    var rowIndex = 0
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var selectedTeamIV: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        self.accessoryType = selected ? .checkmark : .none
        if selected {
            selectedTeamIV.backgroundColor = UIColor.green
        }else {
            selectedTeamIV.backgroundColor = UIColor.clear
        }
    }
}


