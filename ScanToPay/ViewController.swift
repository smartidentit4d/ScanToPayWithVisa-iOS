//
//  MainViewController.swift
//  ScanToPay
//
//  Created by Vivek Jayakumar on 13/12/17.
//  Copyright © 2017 Vivek Jayakumar. All rights reserved.
//

import UIKit
import MVisaSDK
//import MVisaMerchantSDK
import Alamofire

class ViewController: UITableViewController {

    @IBOutlet weak var cardTypeLabel: UITextField!
    @IBOutlet weak var lastFourLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: MVisaPayMerchantDelegate {

    @IBAction func initiateMVisaSDKPayMerchantFlow() {
        print("Initiating MVisa Pay Merchant flow")
        // Init SDK with one time config
        let onetimeConfig = MVisaConfig()
        MVisaSDK.setupOneTimeConfiguration(onetimeConfig)

        // Card details for forming MVisaPayMerchantRequest
        if  cardTypeLabel.text?.isEmpty ?? true || lastFourLabel.text?.isEmpty ?? true {
            notifyUser("Empty Data", message: "Enter sample card information")
            return
        }

        // Prepare consumer card list to be used to create Pay Friend Request
        let card1 = MVisaCardDetails(lastFourDigits: lastFourLabel.text!, cardType: cardTypeLabel.text!, issuerLogo: nil, cardArtColor: nil, cardArtOverlay: nil, networkType: .visa)
        let cardDetails = [card1, card1]

        let randomIndex = Int(arc4random_uniform(UInt32(cardDetails.count)))

        // Forming the MVisaPayMerchantRequest
        let payMerchantRequest = MVisaPayMerchantRequest(cards: cardDetails, currencyCode: "840", defaultCardIndex: randomIndex)

        // Launch the pay merchant flow (commented out using delegate and in place using completion block)
        //MVisaSDK.launchPayMerchantFlow(request: payMerchantRequest, delegate: self)
        MVisaSDK.launchPayMerchatFlow(request: payMerchantRequest) {
            (successful:Bool, payMerchantResponse:MVisaPayMerchantResponse?, error: MVisaError?) in
            self.payMerchantFlowDidFinish(successful, withResponse: payMerchantResponse, withError: error)
        }

    }

    func payMerchantFlowDidFinish(_ successful: Bool, withResponse payMerchantResponse: MVisaPayMerchantResponse?, withError error: MVisaError?) {
        print("Pay Merchant Flow Did Finish")

        // Close the MVisaSDK
        MVisaSDK.endMVisaFlow()

        // Use the response here
        // Printing the response in logs
        let responseStr = Helper.getPayMerchantResponseStr(successful: successful, response: payMerchantResponse, error: error)
        print(responseStr)

        let merchant = [
            "acquiringBin": "xxxxxx",
            "city": payMerchantResponse?.cityName!,
            "countryCode": payMerchantResponse?.countryCode!,
            "pan": payMerchantResponse?.mVisaMerchantPan!,
            "name": payMerchantResponse?.merchantName!
            ] as! [String: String]


        let transaction = [
            "amount": payMerchantResponse?.currencyCode,
            "currencyCode": payMerchantResponse?.currencyCode
            ] as! [String: String]

        let parameters = ["merchant": merchant, "transaction": transaction]

        Alamofire.request(Constants.payMerchantEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                debugPrint(response)
            }

    }
}

extension UIViewController {
    // Alert dialog to show to user
    func notifyUser(_ title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)

        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)

        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

}

