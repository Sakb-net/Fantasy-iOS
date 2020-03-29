



import UIKit

enum DropDownTypes: String {
    case City = "city"
    case sortBy = "sortBy"
    case team = "team"
    case position = "position"
    case playerAction = "player_action"
}

protocol SelectedDropDownType {
    func selectedType(selectedType:DropDownTypes, selectedItem:Any)
}

class DropDownVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dropDownTV: UITableView!
    @IBOutlet weak var containerView: CardView!
    
    var selectedType = DropDownTypes.City
    let presenter = DropDownPresenter()
    
    var countries = Country()
    var cities = [City]()
    var teams = [Teams]()
    
    var selectDelegate:SelectedDropDownType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDownTV.delegate = self
        dropDownTV.dataSource = self
        self.tableView.separatorStyle = .none

        if isNetworkReachable {
            if selectedType == .City {
                getCities()
            }else if selectedType == .team {
                getTeams()
            }
           
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch selectedType {
        case .City:
            return cities.count
        case .sortBy:
            return 4
        case .team:
            return teams.count
        case .position:
            return 0
        case .playerAction:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dropDownCell", for: indexPath)
        cell.textLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        cell.textLabel?.textColor = Color.theme.value
        cell.textLabel?.textAlignment = .right
        cell.textLabel?.numberOfLines = 0
        
        switch selectedType {
        case .City:
             cell.textLabel?.text = cities[indexPath.row].name
        case .sortBy:
            if indexPath.row == 0 {
                cell.textLabel?.text = "حسب الأعلى سعر"
            }else if indexPath.row == 1 {
                cell.textLabel?.text = "حسب الأقل سعر"
            }else if indexPath.row == 2 {
                cell.textLabel?.text = "السعر من الى"
            }else {
                cell.textLabel?.text = "حسب النقاط"
            }
            
        case .team:
            cell.textLabel?.text = teams[indexPath.row].name
        case .position: break
            
        case .playerAction:
            if indexPath.row == 0 {
                cell.textLabel?.text = "إضافة الى الفريق"
            }else {
                cell.textLabel?.text = "تفاصيل اللاعب"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedType == .City {
            self.selectDelegate.selectedType(selectedType: .City, selectedItem: cities[indexPath.row])
        }else if selectedType == .team{
            self.selectDelegate.selectedType(selectedType: .team, selectedItem: teams[indexPath.row])
        }else if selectedType == .sortBy{
            self.selectDelegate.selectedType(selectedType: .sortBy, selectedItem: indexPath.row)
        }else if selectedType == .playerAction{
            self.selectDelegate.selectedType(selectedType: .playerAction, selectedItem: indexPath.row)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func getCountries(){
        self.showLoader()
        presenter.getCountries(onSuccess: { (coutries) in
            self.countries = coutries
            self.dropDownTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func getCities(){
        self.showLoader()
        presenter.getCities(onSuccess: { (cities) in
            self.cities = cities
            self.dropDownTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func getTeams(){
        self.showLoader()
        presenter.getTeams(onSuccess: { (teams) in
            self.teams = teams
            self.dropDownTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
}
