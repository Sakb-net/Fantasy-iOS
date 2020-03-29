



import UIKit

class FixtureCell: UITableViewCell {
    var delegate : HideScoreLabel?
    @IBOutlet weak var firstClubName: UILabel!
    @IBOutlet weak var firstClubIV: UIImageView!
    @IBOutlet weak var secondClubName: UILabel!
    @IBOutlet weak var secondClubIV: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    func hideLabel (scoreLabel: UILabel, timeLabel : UILabel, type : Int){
        delegate?.hideScoreLabel(scoreLabel: scoreLabel, timeLabel : timeLabel, type : type)
    }
}
