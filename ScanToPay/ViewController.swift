//
//  MainViewController.swift
//  ScanToPay
//
//  Created by Vivek Jayakumar on 13/12/17.
//  Copyright © 2017 Vivek Jayakumar. All rights reserved.
//

import UIKit
import MVisaSDK
import Alamofire

class ViewController: UITableViewController {

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
        let card1 = MVisaCardDetails(lastFourDigits: "5678", cardType: "FDNB Platinum", issuerLogo: nil, cardArtColor: nil, cardArtOverlay: nil, networkType: .visa)
        let card2 = MVisaCardDetails(lastFourDigits: "1357", cardType: "FDNB Credit", issuerLogo: nil, cardArtColor: UIColor.brown, cardArtOverlay: nil, networkType: .visa)

        let cardDetails = [card1, card2]
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

