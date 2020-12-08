//
//  ConfirmTransfersVC.swift
//  GameClub
//
//  Created by Basma on 9/5/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class ConfirmTransfersVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    var allSubs : [[MyTeam]]?
    var presenter = PitchPresenter()
    var delegate : replacementListenner?
    var payementSuccessDelegate : PayementSuccessDelegate?
    var cardType = ""
    var active_cardgray = 0
    var active_cardgold = 0
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gwStateLbl: UILabel!
    @IBOutlet weak var freeTransferLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var remainMoneyLbl: UILabel!
    @IBOutlet weak var goldenCard: UIButton!
    @IBOutlet weak var silvirCard: UIButton!
    @IBOutlet weak var confirmBt: UIButton!
    @IBOutlet weak var cancelBt: UIButton!
    @IBOutlet weak var backBT: UIButton!

    @IBAction func silvirCardAction(_ sender: Any) {
        cardType = "silver_card"
        openCardPopUp ()
    }
    @IBAction func goldenCardAction(_ sender: Any) {
        cardType = "golden_card"
//        openCardPopUp ()
        if isNetworkReachable{
            goldCardPay(playerListString: presenter.createSubString (allSubs: allSubs!))
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    @IBAction func confirmAction(_ sender: Any) {
        let playersListString = presenter.createSubString(allSubs: allSubs!)
        if isNetworkReachable{
            savePlayerList(playerListString : playersListString)
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        print(presenter.createSubString (allSubs: allSubs!))
        if isNetworkReachable{
            getCardsState(cardType : "gray")
            getCardsState(cardType : "gold")
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allSubs!.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "SubHeaderCell", for: indexPath) as! SubHeaderCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "SubCell", for: indexPath) as! SubCell
        if indexPath.row == 0 {
            return cell1
        }else {
            cell2.inPlayerLbl.text = self.allSubs![indexPath.row - 1][1].name_player
            cell2.inTeamLbl.text = self.allSubs![indexPath.row - 1][1].team
            cell2.inPlayerImg.sd_setImage(with: URL(string: Urls.baseUrl + self.allSubs![indexPath.row - 1][1].image_player! ), placeholderImage: UIImage(named: "placeholder"))

            cell2.outPlayerLbl.text = self.allSubs![indexPath.row - 1][0].name_player
            cell2.outTeamLbl.text = self.allSubs![indexPath.row - 1][0].team
            cell2.outPlayerImg.sd_setImage(with: URL(string: Urls.baseUrl + self.allSubs![indexPath.row - 1][0].image_player! ), placeholderImage: UIImage(named: "placeholder"))

            return cell2
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {}
    }
    
    func configView(){
        if "lang".localized == "en"{
            self.backBT.transform = CGAffineTransform(scaleX: -1, y: 1);
        }
        roundViewCornersNoShadow(view: confirmBt)
        roundViewCornersNoShadow(view: cancelBt)
        roundViewCornersNoShadow(view: silvirCard)
        roundViewCornersNoShadow(view: goldenCard)

        let endDate = UserDefaults.standard.string(forKey: "END_DATE") ?? ""
        let gameWeek = UserDefaults.standard.string(forKey: "GAME_WEEK") ?? ""
        let mainLblString = "End date for GW ".localized + gameWeek + ": " + endDate
        mainLbl.text = mainLblString
        descLbl.text = "You are about to change " + String(allSubs!.count) + " players"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        let freeTransfers = UserDefaults.standard.integer(forKey: "count_free_weekgamesubstitute")
        let changePoints =  UserDefaults.standard.integer(forKey: "change_point")

        if allSubs!.count >= freeTransfers {
            freeTransferLbl.text = "You used \(freeTransfers) free transfers."
            let extraTransfers = allSubs!.count - freeTransfers
            pointsLbl.text = "Extra transfer cost (\(extraTransfers * changePoints) points)"
        }else {
            let remainTransfers = freeTransfers - allSubs!.count
            freeTransferLbl.text = "You used \(remainTransfers) free transfers."
            pointsLbl.text = "Extra transfer cost (0 points)"
        }
        gwStateLbl.text = "Transfers will take place for \(gameWeek) GW before the end date."
    }
    
    func savePlayerList(playerListString : String){
        self.showLoader()
        PlayersPresenter().subList(playersString: playerListString, active_cardgray: active_cardgray, active_cardgold: active_cardgold,onSuccess: { (isSuccess) in
                    self.hideLoader()
            
            self.navigationController?.popViewController(animated: true)
            self.delegate?.subIsSuccess()
                }) { (errorMessage) in
                    self.hideLoader()
                  
                }
    }
    
    func getCardsState(cardType : String){
        self.showLoader()
        presenter.getGSCardState(cardType: cardType,onSuccess: { (details) in
                    self.hideLoader()
            if cardType == "gray" && details.active_card == 0 {
                self.silvirCard.isEnabled = false
                self.silvirCard.alpha = 0.5
            }
            self.remainMoneyLbl.text = "Money remainder \(details.remide_sum_cost ?? 0)"
                }) { (errorMessage) in
                    self.hideLoader()
                  
                }
    }
    
    func goldCardPay(playerListString : String){
        presenter.goldCardPayment(array_players: presenter.createSubString (allSubs: allSubs!),onSuccess: { (checkoutid, shopperResultUrl) in
                self.hideLoader()
                        let provider = OPPPaymentProvider(mode: OPPProviderMode.test)
                        let checkoutSettings = OPPCheckoutSettings()
                        checkoutSettings.paymentBrands = ["VISA", "MASTER", "MADA"]
                        checkoutSettings.shopperResultURL = shopperResultUrl
                        
                        let checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutid, settings: checkoutSettings)
                        
                        checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
                            guard let transaction = transaction else {
                                // Handle invalid transaction, check error
                                self.showAlert(title: "", message: error!.localizedDescription, shouldpop: false)
                                return
                            }
                            
                            if transaction.type == .synchronous {
                                // If a transaction is synchronous, just request the payment status
                                // You can use transaction.resourcePath or just checkout ID to do it
                                print(transaction.resourcePath ?? "")
                                self.presenter.confirmPayment(checkout_id: checkoutid, resourcePath: transaction.resourcePath ?? "", onSuccess: { (message) in
                                    self.navigationController?.popViewController(animated: true)
                                    DispatchQueue.main.async {
                                        self.payementSuccessDelegate?.PayementSuccess(message: message)

                                    }
                                    
                                }) { (errorMessage) in
                                    self.hideLoader()
                                    self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
                                }
                            } else if transaction.type == .asynchronous {
                                // The SDK opens transaction.redirectUrl in a browser
                                // See 'Asynchronous Payments' guide for more details
                            } else {
                                // Executed in case of failure of the transaction for any reason
                            }
                        }, cancelHandler: {
                            // Executed if the shopper closes the payment page prematurely
                        })
                    
                    
                }) { (errorMessage) in
self.hideLoader()
                }
    }
    func openCardPopUp (){
        let cardPopUp = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "CardPopUp") as! CardPopUp
        cardPopUp.popUpType = cardType
        cardPopUp.delegate = self
        present(cardPopUp, animated: true
        , completion: nil)
    }
}
extension ConfirmTransfersVC : cardActivationDelegat {
    func isCardActivated(cardType: String) {
        if cardType == "silver_card" {
            active_cardgray = 1
            pointsLbl.text = "Extra transfer cost (0 points)"
            silvirCard.isEnabled = false
            silvirCard.alpha = 0.5
        }
    }
}
protocol PayementSuccessDelegate {
    func PayementSuccess(message : String)
}
