//
//  GlobalConstant.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import UIKit
import SystemConfiguration
import SwiftyUserDefaults


// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
struct APIS {
//    static var BASE_URL = "http://paymentsolution.leadconcept.business/api/"
    static var BASE_URL = "http://paymentsolution.demo.leadconcept.net/api/"
    static var BASE_URL_Image = "http://paymentsolution.demo.leadconcept.net/api/user/"
    static var BASE_URL1 = "http://paymentsolution.demo.leadconcept.net/"
    static var Login:String = BASE_URL+"login"
    static var SignUp:String = BASE_URL+"signup"
    static var Logout:String = BASE_URL+"logout"
    static var SendPhoneCode:String = BASE_URL+"send-phone-verification-code"
    static var VerifyPhoneCode:String = BASE_URL+"verify-phone-verification-code"
    static var SendEmailCode:String = BASE_URL+"send-email-verification-code"
    static var VerifyEmailCode:String = BASE_URL+"verify-email-verification-code"
    static var SendForgetEmailCode:String = BASE_URL+"send-forget-email-code"
    static var VerifyForgetEmailCode:String = BASE_URL+"verify-forget-email-code"
    static var UpdatePassword:String = BASE_URL+"update-password"
    static var GetOffers:String = BASE_URL+"get-offers"
    static var CreateOffer:String = BASE_URL+"create-offer"
    static var RemoveOffer:String = BASE_URL+"remove-offer"
    static var EditOffer:String = BASE_URL+"edit-offer"
    static var UpdateOffer:String = BASE_URL+"update-offer"
    static var MatchOffer:String = BASE_URL+"match-offers"
    static var UpdateSetting:String = BASE_URL+"update-setting"
    static var FindOperator:String = BASE_URL+"find_operator"
    static var HideCancelHistory:String = BASE_URL+"hide-cancel-history"
    static var GetOrderHistory:String = BASE_URL+"get-history"
    static var GetFunds:String = BASE_URL+"get-funds"
    static var SaveDeviceToken:String = BASE_URL+"save_device_token"
    static var UpdateTradeSetting:String = BASE_URL+"update_trade_settings"
    static var GetTradeSetting:String = BASE_URL+"get_trade_settings"
    static var GetMatchOfferUser:String = BASE_URL+"get-match-offer-user"
    static var GetBuyer:String = BASE_URL+"get_buyer"
    static var GetOperator:String = BASE_URL+"get_operator"
    static var ChangeOperatorStatus:String = BASE_URL+"change_operator_status"
    static var TradeCancel:String = BASE_URL+"trade-cancel"
    static var ChangeOfferStatus:String = BASE_URL1+"change_offer_status"
    static var TradeInProcess:String = BASE_URL+"trade_inprocess"
    static var ReportStatusOff:String = BASE_URL+"get_report_status_off"
    static var ReportStatusOn:String = BASE_URL+"get_report_status"
    static var ContactUs:String = BASE_URL+"addcontact"
    static var UploadImage:String = BASE_URL_Image+"upload-image"
    static var AmountTransfer:String = BASE_URL+"amount/transfer"
    static var ChangePrifileImage:String = BASE_URL_Image+"change-photo"
    static var ChangePaymentStatus:String = BASE_URL+"change_payment_status"
    static var GetMatchOfferFromBuyer:String = BASE_URL+"get_match_offer_from_buyer"
    static var GetMatchOfferFromSeller:String = BASE_URL+"get_match_offer_from_seller"
    static var GetGameSetting:String = BASE_URL+"getGameSetting"
    static var GetPlatforms:String = BASE_URL+"getPlateforms"
    static var AmountTip:String = BASE_URL+"amount/tip"
    static var UserUpdatePlatform:String = BASE_URL+"user-update-plateform"
    static var GetUserTransferHistory:String = BASE_URL+"getUserTransferHistory/all"
    static var getUserTransferHistoryCancel:String = BASE_URL+"getUserTransferHistory/cancel"
    static var GetAudious:String = BASE_URL+"getaudios"
    static var GetAllTutorials:String = BASE_URL+"get-all-tutorials"
    static var GetAnnouncement:String = BASE_URL+"get-announcementuser"
    static var GetPaymentMethods:String = BASE_URL+"getPaymentMethods"
    static var GatTransactionHistory:String = BASE_URL+"transaction-histories"
    static var RedeemZippyCoupon:String = BASE_URL+"amount/zippys"
    static var UpdateGameTransfer:String = BASE_URL+"update-game-transfer"
    static var RemoveGameTransfer:String = BASE_URL+"remove-game-transfer"
}


let HEADER_KEY = "x-api-key"
let HEADER_VALUE = "CODEX@123"
let HEADER = ["x-api-key": HEADER_VALUE]
let appDelegate = UIApplication.shared.delegate as? AppDelegate
let uDefaults = UserDefaults.standard
let user = "admin"
let pass = "1234"

let APIservice = APIService.sharedService()
//let MANAGER = LocationManager.shared
//let DEVICE = UIDevice.current.deviceName

//SCREEN SIZES
let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let screenMaxLength = max(screenWidth, screenHeight)
let screenMinLength = max(screenWidth, screenHeight)


//MARK GET authentic HEADER
/**
 * getHeader // to create header
 * Authenticate // _headerKey
 * create header using UserID and authenticationID
 * header format userID:AuthenticationID
 * after create format convert in base64 string
 */
let Authenticate = "AUTHENTICATE"
let AuthID = "ad4ad9c6c590d61574f4b70a4d63c75b"
let authText = ""
/*
 Authentication process
 MD5(H3!loL0@d$_{userID})
 userID_MD5
 convert to base 64
 */
func Authentication()-> [String : String] {
    
//    let userID = getUserObject()?.userId ?? CONSTANTs.ZERO
//    let convertString = String(format: "%@_%d", authText,userID)
//    let convertedMD5String : String = Utility.shared().MD5(convertString)!
//    let userIDAndMD5String = String(format: "%d_%@", userID,convertedMD5String)
//    let string = userIDAndMD5String
//
//    let utf8str = string.data(using: String.Encoding.utf8)
//    let base64Encoded = utf8str?.base64EncodedString()
//    //debugPrint(base64Encoded ?? "")
//    return [Authenticate : base64Encoded! as String] as [String : String]
    
    return [Authenticate : AuthID] as [String : String]
}

/*!
 * MARK: Regex
 * strEmailRegex: Email Format
 * strUrlRegEx: Url Format
 * strPhoneNumberRegex: Phone number format
 */
struct Regex
{
    static let strEmailRegex = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" + "\\@" + "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" + "(" +
        "\\." + "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" + ")+"
    static let strUrlRegEx = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?"
    static let strPhoneNumberRegex = "^((\\+)|(00)|(\\*)|())[0-9]{10,14}((\\#)|())$"
}

