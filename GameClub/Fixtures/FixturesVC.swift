



import UIKit
import SideMenu

class FixturesVC: ParentViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.fixtures.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.titles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentRound = row
        // when rounds is recieved from the api i can reload table data with diffrent rounds
        pickerContainerView.isHidden = true
    }
    
    var fixtures = [Fixtures]()
    var titles = [String]()
    var currentRound = 0

    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var roundsBT: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBAction func roundsAction(_ sender: Any) {
        pickerContainerView.isHidden = false
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

        self.showLoader()
            getFixtures(onSuccess: { (fixtures) in
                var roundCount = 0
                for item in fixtures{
                    roundCount += 1
                    self.titles.append("الجولة " + String(roundCount))
                }
                self.fixtures = fixtures
                self.tableView.reloadData()
                self.picker.reloadAllComponents()
                        self.hideLoader()
                    }) { (errorMessage) in
                        self.hideLoader()
                        self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
                    }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.fixtures.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.fixtures[section].start_date! + " - " + self.fixtures[section].start_date_day!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.adjustsFontSizeToFitWidth = true
        headerText.textAlignment = .center
        headerText.font = UIFont(name:"HelveticaNeueW23forSKY-Reg",size:15)

        headerText.text = self.fixtures[section].start_date! + " - " + self.fixtures[section].start_date_day!

        return headerText
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixtures[section].match_group!.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainFixtureCell", for: indexPath) as! MainFixtureCell
        cell.delegate = self
        let date = stringToDate(dateString: self.fixtures[indexPath.section].match_group![indexPath.row].date!)
               if date > Date() {
                cell.hideLabel(scoreLabel: cell.scoreLabel, timeLabel: cell.timeLabel, type: 0)
               } else {
                   cell.hideLabel(scoreLabel: cell.scoreLabel, timeLabel: cell.timeLabel, type: 1)
               }
        cell.firstClubName.text = self.fixtures[indexPath.section].match_group![indexPath.row].name_first
        cell.secondClubName.text = self.fixtures[indexPath.section].match_group![indexPath.row].name_second
        cell.timeLabel.text = self.fixtures[indexPath.section].match_group![indexPath.row].time
        let firstScore = self.fixtures[indexPath.section].match_group![indexPath.row].first_goon
        let secondScore = self.fixtures[indexPath.section].match_group![indexPath.row].second_goon
        var firstScoreString = ""
        var secondScoreString = ""
        if let score1 = firstScore{
            firstScoreString = String(score1)
        }
        if let score2 = secondScore{
            secondScoreString = String(score2)
        }
        cell.scoreLabel.text = firstScoreString + " - " + secondScoreString
        cell.firstClubIV.sd_setImage(with: URL(string: Urls.baseUrl+self.fixtures[indexPath.section].match_group![indexPath.row].image_first! ), placeholderImage: UIImage(named: "placeholder"))
        cell.secondClubIV.sd_setImage(with: URL(string: Urls.baseUrl+self.fixtures[indexPath.section].match_group![indexPath.row].image_second! ), placeholderImage: UIImage(named: "placeholder"))
            return cell
       }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let matchDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MatchDetailsVC") as! MatchDetailsVC
        matchDetailsVC.matchGroup = self.fixtures[indexPath.section].match_group![indexPath.row]
        self.navigationController?.pushViewController(matchDetailsVC, animated: true)
    }
    
   func getFixtures(onSuccess: @escaping ([Fixtures]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
        {
            let url = Urls().getFixtures()
            let parameters:[String:Any] = [
                "lang": HelperMethods.getCurrentLanguage()
            ]
            
            ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
                
                if response != nil
                {
                    let statusCode = response!["StatusCode"].intValue
                    if statusCode == 0 {
                        if let data = response!["data"].array {
                            var fixtures = [Fixtures]()
                            
                            for fixtureItem in data {
                                fixtures.append(Fixtures(parametersJson: fixtureItem.dictionaryValue))
                            }
                            onSuccess(fixtures)
                        }else{
                            onFailure("Oops, Error occured")
                        }
                    }else{
                        let message = response!["Message"].stringValue
                        onFailure(message)
                    }
                }
                else
                {
                    onFailure(error?.localizedDescription)
                }
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
