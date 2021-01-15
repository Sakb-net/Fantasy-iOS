



import UIKit
import SideMenu

class FixturesVC: ParentViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isTeam {
            return self.teams.count
        }else{
            return self.gws.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isTeam {
            return self.teams[row].name
        }else{
            return self.gws[row].lang_num_week
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentRound = row
        if isTeam {
            self.teamBT.setTitle(self.teams[row].name, for: .normal)
            self.teamLink = self.teams[row].link!
        }else {
            self.roundsBT.setTitle(self.gws[row].lang_num_week, for: .normal)
            self.gwLink = self.gws[row].link!
        }
    }
    
    var fixtures = [Fixtures]()
    var gws = [SubDaweryModel]()
    var titles = [String]()
    var currentRound = 0
    var presenter = FixturesPresenter()
    var teamLink = ""
    var gwLink = ""
    var teams = [FavTeam]()
    var isTeam = false
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var roundsBT: UIButton!
    @IBOutlet weak var teamBT: UIButton!
    @IBOutlet weak var chooseGWBT: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBAction func roundsAction(_ sender: Any) {
        isTeam = false
        self.picker.reloadAllComponents()
        pickerContainerView.isHidden = false
    }
    @IBAction func chooseTeamAction(_ sender: Any) {
        isTeam = true
        self.picker.reloadAllComponents()
        pickerContainerView.isHidden = false
    }
    @IBAction func chooseGWAction(_ sender: Any) {
        
        if isNetworkReachable{
            if isTeam {
                getFixturesByTeam(team_link: teamLink)
            }else {
                self.getFixtures (link : self.gwLink)
            }
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
        pickerContainerView.isHidden = true
    }
    @IBOutlet weak var tableView: UITableView!
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
               present(menu, animated: true, completion: nil)
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCorners(view: pickerContainerView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.picker.delegate = self
        self.picker.dataSource = self
        picker.setValue(UIColor.white, forKey: "textColor")
        
        if isNetworkReachable{
            getTeams()
            getGameWeeks()
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    func getFixtures (link : String){
        self.showLoader()
        self.presenter.getGWFixtures(link: link, onSuccess: { (fixtures) in
            self.fixtures = fixtures
            let count = self.fixtures.count
            if self.fixtures[count - 1].link_first == nil {
                self.fixtures.removeLast()
            }
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func getFixturesByTeam(team_link: String){
            self.showLoader()
            HomePresenter().getHomeDetails(team_link: teamLink, onSuccess: { (fixtures) in
                self.fixtures = fixtures
                self.tableView.isHidden = false
                self.tableView.reloadData()
                self.hideLoader()
            }) { (errorMessage, code)  in
                self.hideLoader()
                if code == 11 ||  code == 41{
                    
                }else {
                    if code == -2{
                        self.tableView.isHidden = true
                    }
                    self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
                }
            }
        }
    
    func getGameWeeks(){
        self.showLoader()
        presenter.getGWs(onSuccess: { (gws) in
            self.gws = gws.reversed()
            if self.gws[0].link == nil {
                self.gws.removeFirst()
            }
            self.roundsBT.setTitle(self.gws[0].lang_num_week, for: .normal)
            self.gwLink = self.gws[0].link!
            self.hideLoader()
            self.getFixtures (link : self.gwLink)
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func getTeams(){
        self.showLoader()
        FavTeamPresenter().getTeams(onSuccess: { (teams) in
            self.teams = teams
            self.teamBT.setTitle(self.teams[0].name ?? "", for: .normal)
            self.teamLink = self.teams[0].link!
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.fixtures[section].start_date! + " - " + self.fixtures[section].start_date_day!
//    }
//
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerText = UILabel()
//        headerText.adjustsFontSizeToFitWidth = true
//        headerText.textAlignment = .center
//        headerText.font = UIFont(name:"HelveticaNeueW23forSKY-Reg",size:15)
//
//        headerText.text = self.fixtures[section].start_date! + " - " + self.fixtures[section].start_date_day!
//
//        return headerText
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixtures.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainFixtureCell", for: indexPath) as! MainFixtureCell
        cell.delegate = self
        let date = stringToDate(dateString: self.fixtures[indexPath.row].date!)
               if date > Date() {
                cell.hideLabel(scoreLabel: cell.scoreLabel, timeLabel: cell.timeLabel, type: 0)
               } else {
                   cell.hideLabel(scoreLabel: cell.scoreLabel, timeLabel: cell.timeLabel, type: 1)
               }
        cell.firstClubName.text = self.fixtures[indexPath.row].code_first
        cell.secondClubName.text = self.fixtures[indexPath.row].code_second
        cell.timeLabel.text = self.fixtures[indexPath.row].time
        let firstScore = self.fixtures[indexPath.row].first_goon
        let secondScore = self.fixtures[indexPath.row].second_goon
        var firstScoreString = ""
        var secondScoreString = ""
        if let score1 = firstScore{
            firstScoreString = String(score1)
        }
        if let score2 = secondScore{
            secondScoreString = String(score2)
        }
        if "lang".localized == "en"{
            cell.scoreLabel.text = secondScoreString + " - " + firstScoreString
        }else if "lang".localized == "ar"{
            cell.scoreLabel.text = firstScoreString + " - " + secondScoreString
        }
        cell.firstClubIV.sd_setImage(with: URL(string: Urls.baseUrl+self.fixtures[indexPath.row].image_first! ), placeholderImage: UIImage(named: "placeholder"))
        cell.secondClubIV.sd_setImage(with: URL(string: Urls.baseUrl+self.fixtures[indexPath.row].image_second! ), placeholderImage: UIImage(named: "placeholder"))
            return cell
       }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let date = stringToDate(dateString: self.fixtures[indexPath.row].date!)
        if date < Date() {
            let matchDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MatchDetailsVC") as! MatchDetailsVC
                  matchDetailsVC.fixture = self.fixtures[indexPath.row]
            matchDetailsVC.page = 0
                  self.navigationController?.pushViewController(matchDetailsVC, animated: true)
        }
    }
    
   
    
    func stringToDate(dateString : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:dateString)!
        return date
    }
    
    func getCurrentDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        return result
    }
    }
extension FixturesVC : HideScoreLabel {
    func hideScoreLabel(scoreLabel: UILabel, timeLabel: UILabel, type: Int) {
        if type == 0 {
            scoreLabel.isHidden = true
            timeLabel.isHidden = false
        }else {
            scoreLabel.isHidden = false
            timeLabel.isHidden = true
        }
    }
}
