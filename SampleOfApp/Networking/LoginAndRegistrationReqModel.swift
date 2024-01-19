//
//  LoginAndRegistrationReqModel.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD
import FirebaseAuth

typealias forgotPasswordBlock = (_ success:Bool) -> Void

class LoginAndRegistrationReqModel: NSObject
{
    var progressBlock: ((Double?,NSError?,String?) -> Void)? = nil
    static var objLoginAndRegistrationReqModel: LoginAndRegistrationReqModel? = nil
    /*!
     * MARK: Singleton Class method
     * Model Instance will be created only once
     */
    class func sharedModel() -> LoginAndRegistrationReqModel
    {
        /*!
         *sharedModel of LaunchModel class.
         */
        if objLoginAndRegistrationReqModel == nil
        {
            objLoginAndRegistrationReqModel = LoginAndRegistrationReqModel()
        }
        return objLoginAndRegistrationReqModel!
    }
    
    /**
     * Login API CALL
     */
    func initLogin(strEmail : String, strPassword : String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void) {
        let parameters = ["email":strEmail,"password":strPassword] as [String : Any]
        
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.Login, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * SignUp API CALL
     */
    func initSignUp(username:String, email:String, phoneNO: String, password:String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        let parameters = ["username":username,"email":email,"phone":phoneNO,"password":password] as [String : Any]
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.SignUp, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("JSON:", json as Any)
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * Logout API CALL
     */
    func initLogout(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.Logout, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * Send-Phone-Verification-Code API CALL
     */
    func initSendPhoneCode(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.SendPhoneCode, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
          
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * Verify-Phone-Verification-Code API CALL
     */
    func initVerifyPhoneCode(code: String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        let parameters = ["code":code] as [String : Any]
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.VerifyPhoneCode, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * Send-Email-Verification-Code API CALL
     */
    func initSendEmailCode(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.SendEmailCode, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
          
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * Verify-Email-Verification-Code API CALL
     */
    func initVerifyEmailCode(code: String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        let parameters = ["code":code] as [String : Any]
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.VerifyEmailCode, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    /**
     * Send-Forget-Email-Code  API CALL
     */
    func initForgetEmailCode(email: String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        let parameters = ["email":email] as [String : Any]
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.SendForgetEmailCode, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * VerifyForgetEmailCode API CALL
     */
    func initVerifyForgetEmailCode(email: String,code: String,request_token: String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        let parameters = ["email":email,"code":code,"request_token":request_token] as [String : Any]
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.VerifyForgetEmailCode, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * UpdatePassword API CALL
     */
    func initUpdatePassword(email: String,password: String,confirm_password: String,reset_token: String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        let parameters = ["email":email,"password": password,"confirm_password": confirm_password,"reset_token":reset_token] as [String : Any]
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.UpdatePassword, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * GetOffers API CALL
     */
    func initGetOffers(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: APIS.GetOffers, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
//                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
//            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    /**
     * CreateOffer API CALL
     */
    func initCreateOffer(price : Int, methods : [String], completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var parameters:[String: Any]
        parameters = ["price" : price,"methods":methods]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.CreateOffer, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * RemoveOffer API CALL
     */
    func initRemoveOffer(offerId : Int, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var parameters:[String: Any]
        parameters = ["offerId" : offerId]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.RemoveOffer, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * UpdateOffer API CALL
     */
    func initUpdateOffer(offerId : Int, price : Int, methods : [String], completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var parameters:[String: Any]
        parameters = ["offerId" : offerId,"price" : price,"methods":methods]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.UpdateOffer, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * UpdateSetting API CALL
     */
    func initUpdateSetting(username: String, email : String, phone: String, facebookUser: String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var parameters:[String: Any]
        parameters = ["username" : username,"email":email,"phone":phone,"facebookusername":facebookUser]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.UpdateSetting, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * MatchOffer API CALL
     */
    func initMatchOffer(price : Int, methods : [String], completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var parameters:[String: Any]
        parameters = ["price" : price,"methods":methods]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.MatchOffer, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * GetMatchOfferUser API CALL
     */
    func initGetMatchOfferUser(offerID : Int, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var parameters:[String: Any]
        parameters = ["offerId" : offerID]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.GetMatchOfferUser, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * FindOperator API CALL
     */
    func initFindOperator(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: APIS.FindOperator, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * GetOrderHistory API CALL
     */
    func initGetOrderHistory(page : Int,completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
        {
            if(Utility.customObject(forKey: "user") == nil) {
                return
            }
            var url = APIS.GetOrderHistory
            if(page != 1)
            {
                url = APIS.GetOrderHistory+"?page=\(page)"
            }
            let apiService = APIService()
            apiService.makeApiRequest(.get, url: url, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
                
                guard error == nil else {
                    ////SVProgressHUD.dismiss()
                    completion(false,nil,error)
                    return
                }
                ////SVProgressHUD.dismiss()
                completion(status!,json,error)
            })
        }
    
    
    /**
     * HideCancelHistory API CALL
     */
    func initHideCancelHistory(page : Int,completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
        {
            if(Utility.customObject(forKey: "user") == nil) {
                return
            }
            var url = APIS.HideCancelHistory
            if(page != 1)
            {
                url = APIS.HideCancelHistory+"?page=\(page)"
            }
            let apiService = APIService()
            apiService.makeApiRequest(.get, url: url, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
                
                guard error == nil else {
                    ////SVProgressHUD.dismiss()
                    completion(false,nil,error)
                    return
                }
                ////SVProgressHUD.dismiss()
                completion(status!,json,error)
            })
        }
    
    
    /**
     * GetFunds API CALL
     */
    func initGetFunds(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: APIS.GetFunds, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
//                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
//            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * DeviceToken API CALL
     */
    func initDeviceToken(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let deviceToken = UserDefaults.standard.string(forKey: "device_token")
        let parameters = ["device_token" : deviceToken]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.SaveDeviceToken, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                ////SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            ////SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * GetTradeSetting API CALL
     */
    func initGetTradeSetting(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: APIS.GetTradeSetting, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                ////SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            ////SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * UpdateTradeSettings API CALL
     */
    func initUpdateTradeSettings(parameters : [String:Any], completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.UpdateTradeSetting, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                ////SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            ////SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * GetBuyer API CALL
     */
    func initGetBuyer(parameters : [String:Any], completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.GetBuyer, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                ////SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            ////SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * ChangeOfferStatus API CALL
     */
    func initChangeOfferStatus(parameters : [String:Any], completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.ChangeOfferStatus, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                ////SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            ////SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * GetOperator API CALL
     */
    func initGetOperator(parameters : [String:Any], completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.GetOperator, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                ////SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            ////SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * ChangeOpratorStaus API CALL
     */
    func initChangeOpratorStaus(parameters : [String:Any], completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.ChangeOperatorStatus, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                ////SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            ////SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * CancelTrade API CALL
     */
    func initTradeCancel(parameters : [String:Any], completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.TradeCancel, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                ////SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            ////SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * GetTradeProcess API CALL
     */
    func initGetTradeProcess(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: APIS.TradeInProcess, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
//                ////SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
//            ////SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * ReportStatusOn API CALL
     */
    func initReportStatusOn(id : Int,completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: APIS.ReportStatusOn+"/\(id)", parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
                ////SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            ////SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * ReportStatusOff API CALL
     */
    func initReportStatusOff(id : Int,completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: APIS.ReportStatusOff+"/\(id)", parameters: nil , requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
                ////SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * ContactUs API CALL
     */
    func initContactUs(firstName:String, lastName:String, email: String, phoneNo:String, message:String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let parameters = ["firstname":firstName,"lastname":lastName, "email":email, "phone":phoneNo, "message":message] as [String : Any]
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.ContactUs, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("JSON:", json as Any)
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * tUploadImage API CALL
     */
    func initUploadImage(upload_image:UIImage, completion: @escaping(Bool,NSDictionary?,Error?) -> Void) {
       
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var headers:[String : String]
        if(Utility.customObject(forKey: "user") != nil) {
            let user = Utility.customObject(forKey: "user")
            let token = user?.token
            let auth = "Bearer "+token!
            headers = ["x-api-key": HEADER_VALUE,"Authorization": auth]
        }
        else {
            headers = ["x-api-key": HEADER_VALUE]
        }
   
        //print("Header:",HEADER)
//        print("Params:",parameters)
        
        //SVProgressHUD.show()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//            for i in 0..<upload_image.count {
//                let image = upload_image[i]
                //let img = attachObj["image"] as! NSData
                //let imgData = image.jpegData(compressionQuality: 1.0)!
                let imgData = upload_image.jpegData(compressionQuality: 0.6)!
                multipartFormData.append(imgData, withName: "upload_image", fileName: "imageTopSwap4356345786.jpg", mimeType: "image/*")
//            }
            //multipartFormData.append(imgData, withName: "test_image", fileName: "image.jpg", mimeType: "image/*")
        }, usingThreshold: UInt64.init(), to: APIS.UploadImage, method: .post, headers: headers) { (result) in
            switch result {
            case .success(let upload,_, _):
                upload.uploadProgress(closure: { (progress) in
                    if let progressBlock = self.progressBlock {
                        if #available(iOS 11.0, *) {
                            //let fileCompleteCount = progress.fileCompletedCount
                            //let fileTotalCount = progress.fileTotalCount
                            //let fileStatus = "\(fileCompleteCount)/\(fileTotalCount)"
                            progressBlock(Double(progress.fractionCompleted),nil,"")
                        }
                        else {
                            // Fallback on earlier versions
                            progressBlock(Double(progress.fractionCompleted),nil,"")
                        }
                    }
                })
                upload.authenticate(user: user, password: pass).responseJSON { response in
                    guard response.result.error == nil else {
                        //SVProgressHUD.dismiss()
                        let jsonString = String(data: response.data!, encoding: .utf8)!
                        print("Error:",response.description)
                        print("Response:",jsonString)
                        return
                    }
                    
                    var data: NSDictionary?
                    var status: Bool
                    if let result = response.result.value {
                        data = (result as! NSDictionary)
                        status = true
                    }
                    else {
                        data = nil
                        status = false
                    }
                    //SVProgressHUD.dismiss()
                    completion(status,data,response.result.error)
                }
            case .failure(error:_):
                completion(false,nil,nil)
            }
        }
    }
    
    
    /**
     * AmountTransfer API CALL
     */
    func initAmountTransfer(amount: Int, game_id: String, transfer_type: String, optionalEmail: String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
        {
            if(Utility.customObject(forKey: "user") == nil) {
                return
            }
            var parameters:[String: Any] = [:]
            if(optionalEmail=="")
            {
                parameters = ["amount":amount, "game_id":game_id, "transfer_type":transfer_type] as [String : Any]
            }
            else
            {
                if(game_id == "")
                {
                    parameters = ["amount":amount, "transfer_type":transfer_type,"Player_Transfer_username":optionalEmail] as [String : Any]
                }
                else
                {
                    var keyName = ""
                    if(transfer_type=="Ethereum")
                    {
                        keyName = "Ethereum_address"
                    }
                    else{
                        keyName = "BitCoin_address"
                    }
                    parameters = ["amount":amount, "game_id":game_id, "transfer_type":transfer_type,keyName:optionalEmail] as [String : Any]
                }
            }
            print("Params==",parameters as Any)
            let apiService = APIService()
            apiService.makeApiRequest(.post, url: APIS.AmountTransfer, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
                
                guard error == nil else {
                    //SVProgressHUD.dismiss()
                    completion(false,nil,error)
                    return
                }
                //SVProgressHUD.dismiss()
                completion(status!,json,error)
            })
        }
    /**
     * Redeem Zippy's Coupon API CALL
     */
    func initRedeemZippy(coupon_code: String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let parameters = ["coupon_code":coupon_code] as [String : Any]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.RedeemZippyCoupon, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * AmountTip API CALL
     */
    func initAmountTip(amount: Int, transfer_type: String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let parameters = ["amount":amount, "transfer_type":transfer_type] as [String : Any]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.AmountTip, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * ChangeProfileImage API CALL
     */
    func initChangeProfileImg(upload_image:UIImage, completion: @escaping(Bool,NSDictionary?,Error?) -> Void) {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var headers:[String : String]
        if(Utility.customObject(forKey: "user") != nil) {
            let user = Utility.customObject(forKey: "user")
            let token = user?.token
            let auth = "Bearer "+token!
            headers = ["x-api-key": HEADER_VALUE,"Authorization": auth]
            print("auth==",auth)
        }
        else {
            headers = ["x-api-key": HEADER_VALUE]
        }
//        print("Params:",parameters)
        
        //SVProgressHUD.show()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//            for i in 0..<upload_image.count {
//                let image = upload_image[i]
                //let img = attachObj["image"] as! NSData
                //let imgData = image.jpegData(compressionQuality: 1.0)!
                let imgData = upload_image.jpegData(compressionQuality: 0.6)!
                multipartFormData.append(imgData, withName: "profile_image", fileName: "imageTopSwap4356345786.jpg", mimeType: "image/*")
//            }
            //multipartFormData.append(imgData, withName: "test_image", fileName: "image.jpg", mimeType: "image/*")
        }, usingThreshold: UInt64.init(), to: APIS.ChangePrifileImage, method: .post, headers: headers) { (result) in
            switch result {
            case .success(let upload,_, _):
                upload.uploadProgress(closure: { (progress) in
                    if let progressBlock = self.progressBlock {
                        if #available(iOS 11.0, *) {
                            //let fileCompleteCount = progress.fileCompletedCount
                            //let fileTotalCount = progress.fileTotalCount
                            //let fileStatus = "\(fileCompleteCount)/\(fileTotalCount)"
                            progressBlock(Double(progress.fractionCompleted),nil,"")
                        }
                        else {
                            // Fallback on earlier versions
                            progressBlock(Double(progress.fractionCompleted),nil,"")
                        }
                    }
                })
                upload.authenticate(user: user, password: pass).responseJSON { response in
                    guard response.result.error == nil else {
                        //SVProgressHUD.dismiss()
                        let jsonString = String(data: response.data!, encoding: .utf8)!
                        print("Error auth==",response.description)
                        print("Response auth==",jsonString)
                        return
                    }
                    
                    var data: NSDictionary?
                    var status: Bool
                    if let result = response.result.value {
                        data = (result as! NSDictionary)
                        status = true
                    }
                    else {
                        data = nil
                        status = false
                    }
                    //SVProgressHUD.dismiss()
                    print("Data auth==",data as Any)
                    completion(status,data,response.result.error)
                }
            case .failure(error:_):
                completion(false,nil,nil)
            }
        }
    }
    
    
    /**
     * ChangePaymentStatus API CALL
     */
    func initChangePaymentStatus(offerId:Int, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let parameters = ["id":offerId] as [String : Any]
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.ChangePaymentStatus, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("JSON:", json as Any)
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * GetMatchOfferFromBuyer API CALL
     */
    func initGetMatchOfferFromBuyer(Id: Int,completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
        {
            if(Utility.customObject(forKey: "user") == nil) {
                return
            }
            let apiService = APIService()
            apiService.makeApiRequest(.get, url: APIS.GetMatchOfferFromBuyer+"/\(Id)", parameters: nil , requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
                print("json", json as Any)
                guard error == nil else {
                    //SVProgressHUD.dismiss()
                    completion(false,nil,error)
                    return
                }
                //SVProgressHUD.dismiss()
                completion(status!,json,error)
            })
        }
    
    
    /**
     * GetMatchOfferFromSeller API CALL
     */
    func initGetMatchOfferFromSeller(Id: Int, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
        {
            if(Utility.customObject(forKey: "user") == nil) {
                return
            }
            let apiService = APIService()
            apiService.makeApiRequest(.get, url: APIS.GetMatchOfferFromSeller+"/\(Id)", parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
                print("json", json as Any)
                guard error == nil else {
                    //SVProgressHUD.dismiss()
                    completion(false,nil,error)
                    return
                }
                //SVProgressHUD.dismiss()
                completion(status!,json,error)
            })
        }
    
    
    /**
     * GetPlatforms API CALL
     */
    func initGetPlatforms(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: APIS.GetPlatforms, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * GameSetting API CALL
     */
    func initGameSetting(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: APIS.GetGameSetting, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            print("json", json as Any)
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * UpdatePlateform API CALL
     */
    func initUpdatePlateform(password:String, plateformID: String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let parameters = ["password":password] as [String : Any]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.UserUpdatePlatform+"/\(plateformID)", parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * GetUserGameTransfeHistory API CALL
     */
    func initGetUserGameTransferHistory(page : Int, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var url = APIS.GetUserTransferHistory
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: url, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * GetUserGameTransfeHistory API CALL
     */
    func initGetUserGameTransferCancelHistory(page : Int, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var url = APIS.getUserTransferHistoryCancel
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: url, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    func firebaseSignUp(email: String, password: String, userCreationComplete: @escaping(Bool,Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil{
                userCreationComplete(false, error)
            }else{
                userCreationComplete(true, nil)
            }
        }
    }
       
    func firebaseSignIn(email: String, password: String, logincomplete: @escaping(Bool,Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                logincomplete(false, error)
            }else{
                logincomplete(true, nil)
            }
        }
    }
    
    
    /**
     * Audio API CALL
     */
    func initGetAudio(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let url = APIS.GetAudious
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: url, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * Tutorials API CALL
     */
    func initGetTutorials(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let url = APIS.GetAllTutorials
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: url, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    
    /**
     * Announcement API CALL
     */
    func initGetAnnouncementUser(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let url = APIS.GetAnnouncement
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: url, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    /**
     * PaymentMethod API CALL
     */
    func initGetPaymentMethod(completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        let url = APIS.GetPaymentMethods
        let apiService = APIService()
        apiService.makeApiRequest(.get, url: url, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                //SVProgressHUD.dismiss()
                completion(false,nil,error)
                return
            }
            //SVProgressHUD.dismiss()
            completion(status!,json,error)
        })
    }
    
    func initTransactionHistory(type: String, completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
       {
           if(Utility.customObject(forKey: "user") == nil) {
               return
           }
           
           let url = APIS.GatTransactionHistory+"?type=\(type)"
           let apiService = APIService()
           apiService.makeApiRequest(.get, url: url, parameters: nil, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
               
               guard error == nil else {
                   //SVProgressHUD.dismiss()
                   completion(false,nil,error)
                   return
               }
               completion(status!,json,error)
           })
       }
    
    /**
     * UpdateGameTransfer API CALL
     */
    func initUpdateGameTransfer(Id : Int,amount: Int ,completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var parameters:[String: Any]
        parameters = ["id" : Id, "amount" : amount]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.UpdateGameTransfer, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                completion(false,nil,error)
                return
            }
            completion(status!,json,error)
        })
    }
    
    /**
     * RemoveGameTransfer API CALL
     */
    func initRemoveGameTransfer(Id : Int,completion: @escaping(Bool,NSDictionary?,Error?) -> Void)
    {
        if(Utility.customObject(forKey: "user") == nil) {
            return
        }
        var parameters:[String: Any]
        parameters = ["id" : Id]
        print("Params==",parameters as Any)
        let apiService = APIService()
        apiService.makeApiRequest(.post, url: APIS.RemoveGameTransfer, parameters: parameters as [String : AnyObject]?, requestSerialization: .JSON, responseSerialization: .JSON, apiServiceType: .DEFAULT, responseFormat: .JSON, internet: .CHECK, errorState: .PASSTOPARENT, loader: .SHOW, loaderText: "", success_block: { (status, json, error) in
            
            guard error == nil else {
                completion(false,nil,error)
                return
            }
            completion(status!,json,error)
        })
    }
    
}
 
