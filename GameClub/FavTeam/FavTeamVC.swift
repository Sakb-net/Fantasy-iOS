



import UIKit

class FavTeamVC: ParentViewController {
    var delegate : SignUpDelegate?
    var isFavTeam = true
    var teams = [FavTeam]()
    var presenter = FavTeamPresenter()
    var teamSelected = [Bool]()
    var user : signUpUser!
    var selectedTeams = [SelectedTeam]()
    var favTeamLink = ""

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sendBT: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func sendAction(_ sender: Any) {
        let notifyTypeVC = NotifyTypeVC(nibName: "NotifyTypeVC", bundle: nil)
        notifyTypeVC.selectedTeams = selectedTeams
        self.navigationController?.pushViewController(notifyTypeVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        if isNetworkReachable{
            getTeams()
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    func initView(){
        roundViewCornersNoShadow(view: sendBT)
        if let navVCsCount = navigationController?.viewControllers.count {
            navigationController?.viewControllers.removeSubrange(2..<navVCsCount - 1)
        }
        if !isFavTeam{
            self.titleLbl.text = "Choose teams you want to follow".localized
        }else{
            sendBT.isHidden = true
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    
    func getTeams(){
        self.showLoader()
        presenter.getTeams(onSuccess: { (teams) in
            self.teams = teams
            for n in self.teams {
                self.teamSelected.append(false)
            }
            self.tableView.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    
}
extension FavTeamVC :  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavTeamCell", for: indexPath) as! FavTeamCell
        roundViewCornersNoShadow(view: cell.selectedTeamIV)
        cell.selectedTeamIV.layer.borderColor = UIColor.darkGray.cgColor
        cell.selectedTeamIV.layer.borderWidth = 1.0
        cell.teamLabel.text = self.teams[indexPath.row].name
        cell.selectionStyle = .none
        cell.rowIndex = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFavTeam {
            favTeamLink = teams[indexPath.row].link ?? ""
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            delegate?.chooseFavTeam(link: favTeamLink)
        }else {
            if !teamSelected[indexPath.row] {
                selectedTeams.append(SelectedTeam(index: indexPath.row, link: teams[indexPath.row].link ?? "", name: teams[indexPath.row].name ?? "", is_email: 0, is_notif: 0))
                teamSelected[indexPath.row] = true
            }
            print(selectedTeams)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if teamSelected[indexPath.row] {
        if selectedTeams.count > 0 {
            for n in 0...(selectedTeams.count - 1) {
                if selectedTeams.count > n {
                    if selectedTeams[n].index == indexPath.row {
                        selectedTeams.remove(at: n)
                    }
                }
            }
        }
        teamSelected[indexPath.row] = false
        }
        print(selectedTeams)
    }
}
struct SelectedTeam {
    var index : Int
    var link : String
    var name : String
    var is_email : Int
    var is_notif : Int

    }
    
