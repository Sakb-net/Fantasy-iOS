




import Foundation

enum AppEnvironments {
    case development, production
}

class Urls {
    
    static let apiAccessKey = "access-token"
    static let apiTypeDev = "type-dev"
    static let apiValDev = "val-dev"
    static let apiLang = "lang"
    
    static let apiAccessKeyValue = User.shared().access_token ?? ""
    static let baseUrl = "http://sakbfantasy.sakb-co.com.sa/"
    
    private let currentWorkingEnvironment = AppEnvironments.development
    
    private var developmentServerBaseURL:String
    {
        return "http://sakbfantasy.sakb-co.com.sa/api/v1/"
    }
    
    private var ProducationServerBaseURL:String
    {
        return "http://sakbfantasy.sakb-co.com.sa/api/v1/"
    }
    
    private func getCurrentBaseUrl() -> String{
        if currentWorkingEnvironment == .development {
            return developmentServerBaseURL
        }else{
            return ProducationServerBaseURL
        }
    }
    
    func urlEncoding(originalString: String) -> String {
        return originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    func addFollowingTeam() -> String{
        return "\(getCurrentBaseUrl())addFollowingTeam"
    }
    
    func goldCardConfirmPayment() -> String{
        return "\(getCurrentBaseUrl())confirmPayment/card"
    }
    
    func goldCardPayment() -> String{
        return "\(getCurrentBaseUrl())payment/card"
    }
    
    func getStandingsGWs(link : String, type : String) -> String{
        return "\(getCurrentBaseUrl())group_eldwry/subeldwrys/\(type)/\(link)"
    }
    
    func getLeagueStandings(link : String, type : String) -> String{
        return "\(getCurrentBaseUrl())group_eldwry/standings/\(type)/\(link)"
    }
    
    func DeleteLeague (link : String, type : String) -> String{
        return "\(getCurrentBaseUrl())group_eldwry/stop/\(type)/\(link)"
    }
    
    func updateLeague (link : String, type : String) -> String{
        return "\(getCurrentBaseUrl())group_eldwry/update/\(type)/\(link)"
    }
    
    func deletePlayerFromLeague (link : String, type : String) -> String{
        return "\(getCurrentBaseUrl())group_eldwry/delete_player/\(type)/\(link)"
    }
    
    func addAdminToLeague (link : String, type : String) -> String{
        return "\(getCurrentBaseUrl())group_eldwry/add_admin/\(type)/\(link)"
    }
    
    func getLeagueDetails (link : String, type : String) -> String{
        return "\(getCurrentBaseUrl())group_eldwry/setting_admin/\(type)/\(link)"
    }
    
    func leaveLeague (link : String, type : String) -> String{
        return "\(getCurrentBaseUrl())group_eldwry/leave/\(type)/\(link)"
    }
    
    func joinLeague(type : String) -> String{
        return "\(getCurrentBaseUrl())group_eldwry/join/\(type)"
    }
    
    func createLeague(type : String) -> String{
        return "\(getCurrentBaseUrl())group_eldwry/create/\(type)"
    }
    
    func getMyLeagues(type : String) -> String{
        return "\(getCurrentBaseUrl())group_eldwry/\(type)"
    }
    
    func cancelCards() -> String{
        return "\(getCurrentBaseUrl())cancel_players_card"
    }
    
    func getGSCardState(type : String) -> String{
        return "\(getCurrentBaseUrl())status_card/\(type)"
    }
    func addSubList() -> String{
        return "\(getCurrentBaseUrl())confirm_substitutePlayer"
    }
    
    func getPlayerMatchDetails(link : String) -> String{
        return "\(getCurrentBaseUrl())fixtures/\(link)"
    }
    
    func getStatistics() -> String{
        return "\(getCurrentBaseUrl())statistics"
    }
    
    func get_subeldwry(link : String) -> String{
        return "\(getCurrentBaseUrl())subeldwry/\(link)/fixtures"
    }
    
    func get_subeldwry() -> String{
        return "\(getCurrentBaseUrl())subeldwry"
    }
    
    func check_btns_status() -> String{
        return "\(getCurrentBaseUrl())check_btns_status"
    }
    
    func triple_captain_card() -> String{
        return "\(getCurrentBaseUrl())triple_captain_card"
    }
    
    func bench_players_card() -> String{
        return "\(getCurrentBaseUrl())bench_players_card"
    }
    
    func getHomePoints() -> String{
        return "\(getCurrentBaseUrl())home_points_eldwry"
    }
    
    func getPoints() -> String{
        return "\(getCurrentBaseUrl())points_subeldwry"
    }
    
    func getPointsGW() -> String{
        return "\(getCurrentBaseUrl())points_eldwry"
    }
    
    func getPublicPoints() -> String{
        return "\(getCurrentBaseUrl())public_points_eldwry"
    }
    
    func getPlayerDetails() -> String{
        return "\(getCurrentBaseUrl())player"
    }
    
    func changePassword() -> String {
        return "\(getCurrentBaseUrl())change_password"
    }
    
    func getInstructions() -> String {
        return "\(getCurrentBaseUrl())instraction"
    }
    
    func addCaptinOrAssist() -> String {
        return "\(getCurrentBaseUrl())add_captain_assist"
    }
    
    func change_playerByLink() -> String {
        return "\(getCurrentBaseUrl())add_direct_insideChange"
    }
    
    func change_player() -> String {
        return "\(getCurrentBaseUrl())add_insideChange"
    }
    
    func prizes() -> String {
        return "\(getCurrentBaseUrl())award"
    }
    
    func check_insideChange() -> String {
        return "\(getCurrentBaseUrl())check_insideChange"
    }
    
    func nameMyTeam() -> String {
        return "\(getCurrentBaseUrl())add_myteam"
    }
    
    func getMySavedTeam() -> String {
        return "\(getCurrentBaseUrl())player_myteam"
    }
    
    func getMyTeam() -> String {
        return "\(getCurrentBaseUrl())player_master"
    }
    
    func auto_selection_player() -> String {
        return "\(getCurrentBaseUrl())auto_selection_player"
    }
    
    func reset_all_player()-> String {
        return "\(getCurrentBaseUrl())reset_all_player"
    }
    
    func addPlayer() -> String {
        return "\(getCurrentBaseUrl())add_player"
    }
    
    func replacePlayer() -> String {
        return "\(getCurrentBaseUrl())change_player"
    }
    
    func deletePlayer() -> String {
        return "\(getCurrentBaseUrl())delete_player"
    }
    
    func getPlayerFilter() -> String {
        return "\(getCurrentBaseUrl())filterPlayer"
    }
    
    func getPlayersByType() -> String {
        return "\(getCurrentBaseUrl())players_by_type"
    }
    
    func getFixtures() -> String {
        return "\(getCurrentBaseUrl())fixtures"
    }
    
    func getTerms() -> String {
        return "\(getCurrentBaseUrl())terms"
    }
    
    func getCountryURL() -> String {
        return "\(getCurrentBaseUrl())get_country"
    }
    
    func getCityURL() -> String {
        return "\(getCurrentBaseUrl())get_city"
    }
    
    func getLoginURL() -> String {
        return "\(getCurrentBaseUrl())login/email"
    }
    
    func getRegisterURL() -> String {
        return "\(getCurrentBaseUrl())register"
    }
    
    func getHomeURL() -> String {
        return "\(getCurrentBaseUrl())home"
    }
    
    func getAlbumsURL() -> String {
        return "\(getCurrentBaseUrl())albums"
    }
    
    func getAlbumImagesURL() -> String {
        return "\(getCurrentBaseUrl())albums/single"
    }
    
    func getVideosURL() -> String {
        return "\(getCurrentBaseUrl())videos"
    }
    
    func getVedioDetailsURL() -> String {
        return "\(getCurrentBaseUrl())videos/single"
    }
    
    func getNewsURL() -> String {
        return "\(getCurrentBaseUrl())news"
    }
    
    func getNewsDetailsURL() -> String {
        return "\(getCurrentBaseUrl())news/single"
    }
    
    func getCommentsURL() -> String {
        return "\(getCurrentBaseUrl())comments"
    }
    
    func getAddCommentURL() -> String {
        return "\(getCurrentBaseUrl())add_comment"
    }
    
    func getMatchesURL() -> String {
        return "\(getCurrentBaseUrl())matches"
    }
    
    func getTeam() -> String {
        return "\(getCurrentBaseUrl())get_teams"
    }
    
    func getProductsURL() -> String {
        return "\(getCurrentBaseUrl())product_category"
    }
    
    func getCartProductsURL() -> String {
        return "\(getCurrentBaseUrl())product_cart"
    }
    
    func getAddCartItemsURL() -> String {
        return "\(getCurrentBaseUrl())product/addupdate_cart"
    }
    
    func getDeleteCartItemsURL() -> String {
        return "\(getCurrentBaseUrl())product/delete_cart"
    }
    
    func getCheckoutURL() -> String {
        return "\(getCurrentBaseUrl())product/checkout"
    }
    
    func getPaymentStatusURL() -> String {
        return "\(getCurrentBaseUrl())product/resultcallback"
    }
    
    func updateProfile() -> String {
        return "\(getCurrentBaseUrl())update_profile"
    }
    
    func getChampioships() -> String {
        return "\(getCurrentBaseUrl())champions"
    }
    
    func getTeams() -> String {
        return "\(getCurrentBaseUrl())teams"
    }
    
    func getPlayers() -> String {
        return "\(getCurrentBaseUrl())subteams"
    }
    
    func getAboutClub() -> String {
        return "\(getCurrentBaseUrl())about"
    }
    
    func getCalender() -> String {
        return "\(getCurrentBaseUrl())calendar"
    }
    
    func getAudience() -> String {
        return "\(getCurrentBaseUrl())audience"
    }
    
    func getMatchesDetails() -> String {
        return "\(getCurrentBaseUrl())matches/single"
    }
    
    func sendMessage() -> String {
        return "\(getCurrentBaseUrl())add_contact_us"
    }
    
    func getContacts() -> String {
        return "\(getCurrentBaseUrl())contact_us"
    }
    
    func uploadImage() -> String {
        return "\(getCurrentBaseUrl())uploadImage"
    }
}
