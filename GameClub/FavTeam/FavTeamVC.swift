



import UIKit

class FavTeamVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    var teams = [FavTeam]()
    var presenter = FavTeamPresenter()
    var teamSelected = [Int]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getTeams()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavTeamCell", for: indexPath) as! FavTeamCell
        roundViewCornersNoShadow(view: cell.selectedTeamBT)
        cell.selectedTeamBT.layer.borderColor = UIColor.darkGray.cgColor
        cell.selectedTeamBT.layer.borderWidth = 1.0
        cell.teamLabel.text = self.teams[indexPath.row].name
        cell.delegate = self
        cell.rowIndex = indexPath.row
        return cell
    }
    
    func getTeams(){
        self.showLoader()
        presenter.getTeams(onSuccess: { (teams) in
            self.teams = teams
            for n in self.teams {
                self.teamSelected.append(0)
            }
            self.tableView.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }

}

extension FavTeamVC : SelectTeamDelegate {
    func changeBTColor(bt : UIButton, index : Int) {
        bt.backgroundColor = UIColor.green
        let homeVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}
