//
//  MerchantHelper.swift
//  MVisaSDKAppSwift
//
//  Created by Jain, Abhinav on 5/2/17.
//  Copyright © 2017 Visa In. All rights reserved.
//

import Foundation
import UIKit
import MVisaMerchantSDK

extension Helper {

    static func getRefundPaymentResponseStr(successful: Bool, response: MVisaRefundPaymentResponse?, error: MVisaError?) -> String {
        var responseStr = "SUCCESSFUL: " + String(successful) + "\n"
        if successful {
            responseStr = responseStr + "RESPONSE:\n"
            responseStr = responseStr + "refundAmount: " + getStr(field: response?.refundAmount as AnyObject?) + "\n"
        } else {
            responseStr = "ERROR:\n"
            for e in error!.errorCodes {
                responseStr = String(e) + "\n"
            }
        }
        return responseStr
    }

    static func getRequestPaymentResponseStr(successful: Bool, response: MVisaRequestPaymentResponse?, error: MVisaError?) -> String {
        var responseStr = "SUCCESSFUL: " + String(successful) + "\n"
        if successful {
            responseStr = responseStr + "RESPONSE:\n"
        } else {
            responseStr = "ERROR:\n"
            for e in error!.errorCodes {
                responseStr = String(e) + "\n"
            }
        }
        return responseStr
    }
}

