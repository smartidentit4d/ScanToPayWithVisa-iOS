//
//  MerchantViewController.swift
//  MVisaSDKAppSwift
//
//  Created by Jain, Abhinav on 5/2/17.
//  Copyright © 2017 Visa In. All rights reserved.
//

import Foundation
import UIKit
import MVisaMerchantSDK

extension ViewController: MVisaRequestPaymentDelegate {

     @IBAction func initiateMVisaMerchantSDKRequestPaymentFlow() {
        print("Initiating MVisaMerchant Request Payment flow")
        
        // Init SDK with one time config
        let onetimeConfig = MVisaConfig()
        MVisaMerchantSDK.setupOneTimeConfiguration(onetimeConfig)
        
        // Forming the MVisaMerchantPaymentRequest
        let request = MVisaPaymentRequest(payloadFormatIndicator: "01", pointOfInitiation: "01", mVisaMerchantID: "4111111111111111", merchantName: "Corner Store", merchantCategoryCode: "1234", cityName: "Mumbai", countryCode: "IN", currencyCode: "356", tipIndicator: "", tipAmount: "", tipPercentage: "", postalCode: "", mastercardPan1: "", mastercardPan2: "", npciid1: "", npciid2: "")
        
        // Launch the request payment flow (commented out using delegate and in place using completion block)
        //MVisaMerchantSDK.launchRequestPaymnetFlow(request: request, delegate: self)
        MVisaMerchantSDK.launchRequestPaymentFlow(request: request, delegate: self)
    }
    
    func requestPaymentFlowDidFinish(_ successful: Bool, withResponse requestPaymentResponse: MVisaRequestPaymentResponse?, withError error: MVisaError?) {
        print("Request Payment Flow Did Finish")
        
        // Close the MVisaSDK
        MVisaMerchantSDK.endMVisaFlow()
        
        // Use the response here
        // Printing the response in logs
        let responseStr = Helper.getRequestPaymentResponseStr(successful: successful, response: requestPaymentResponse, error: error)
        print(responseStr)
    }
}
