//
//  APIService.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

/// frameworks import
import UIKit
import Foundation


/// classes import
// MARK: - classes import
import Alamofire
import SwiftyJSON
import SVProgressHUD
import XMLReader


//-----------------------------------------------------------------------

//-----------------------------------------------------------------------

public enum APIServiceType: String
{
    case DEFAULT, REST, SOAP
}

// MARK: - UrlEncoding
public enum UrlEncoding: String
{
    case DEFAULT, PERCENT
}

// MARK: - RequestMethod
public enum RequestMethod: String
{
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

// MARK: - RequestSerialization
public enum RequestSerialization: String
{
    case DEFAULT, JSON, XML
}

// MARK: - ResponseSerialization
public enum ResponseSerialization: String
{
    case DEFAULT, DATA, STRING, JSON, PROPERTYLIST, XML
}

// MARK: - ResponseFormat
public enum ResponseFormat: String
{
    case DEFAULT, JSON, XML
}

// MARK: - Internet
public enum Internet: String
{
    case DEFAULT, CHECK, DONTCHECK
}

// MARK: - Loader
public enum Loader: String
{
    case DEFAULT, SHOW, DONTSHOW, HIDE, ANIMATING, CUSTOM
}

// MARK: - ErrorState
public enum ErrorState: String
{
    case DEFAULT, PASSTOPARENT, DONTPASS
}

//-----------------------------------------------------------------------

//-----------------------------------------------------------------------

/**
 *
 */
public typealias ResultSuccess = (_ status: Bool?, _ json:NSDictionary? , _ error:Error?) -> Void


/**
 *
 */
//public typealias ResultFail = (_ status: Bool?, _ json:NSDictionary?, _ error:Error?) -> Void

//-----------------------------------------------------------------------

//-----------------------------------------------------------------------

// MARK: API Service Class
// MARK:
class APIService
{
    
    var resultSuccess : ResultSuccess!
    //    var resultFail : ResultFail!
    var apiRequest : Request!
    //    var constantSender : AnyObject!
    
    //***********************************************************************
    
    static var apiService: APIService? = nil
    
    /// sharedService
    // MARK: - sharedService
    class func sharedService() -> APIService
    {
        if apiService == nil
        {
            apiService = APIService()
        }
        return apiService!
    }
    
    //***********************************************************************
    
    func uploadImageWithMultiPart(api : String,parameters : [String:AnyObject],imageParam : String, files : [UIImage],completion:@escaping(JSON?,Error?)->())
    {
        
        //        showLoader("")
        
        Alamofire.upload(multipartFormData:{multipartFormData in
            
            for i in 0..<files.count
            {
                let imgToUpload = files[i].jpegData(compressionQuality: 0.5)
                multipartFormData.append(imgToUpload!, withName: imageParam, fileName: "image_" + "\(i).jpeg", mimeType: "image/jpeg")
            }
            
            for (key, value) in parameters {
                
                multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                
            }}, to : api, method: .post, headers:Authentication())
        { (result) in
            //
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    
                })
                
                upload.responseJSON { response in
                    //print response.result
                    if response.result.value != nil
                    {
                        let json = JSON(response.result.value!)
                        completion(json,nil)
                    }
                    else
                    {
                        completion(nil,response.error)
                        //                                    Utility.showMsgWithOkButton(strMSg: Utility.showError(error: response.error! as NSError))
                    }
                    
                } 
                
            case .failure(let encodingError):
                
                //                hideLoader()
                let errorText = (encodingError.localizedDescription) as String
                //                Utility.showMsgWithOkButton(strMSg:errorText)
                //                completion(nil,encodingError)
                break
                //print encodingError.description
            }
        }
    }
    
    /// makeApiRequest
    // MARK: - makeApiRequest
    /**
     *
     */
    func makeApiRequest(_ method: Alamofire.HTTPMethod = .get, url: String, parameters: [String: AnyObject]? = nil, urlEncoding: UrlEncoding = .DEFAULT, requestHeaders: [String: String]? = nil, requestSerialization: RequestSerialization = .DEFAULT, responseSerialization: ResponseSerialization = .DEFAULT, apiServiceType: APIServiceType = .DEFAULT, responseFormat: ResponseFormat = .DEFAULT, internet: Internet = .DEFAULT, errorState: ErrorState = .DEFAULT, loader: Loader = .DEFAULT, loaderText: String = "", success_block: @escaping ResultSuccess) -> Void
    {
        // debugPrint("url : %@",url)
        // log for request params
        /*var encodingError: Error? = nil
         do {
         if parameters != nil {
         let data = try JSONSerialization.data(withJSONObject: parameters!, options:  JSONSerialization.WritingOptions())
         let dataString = String(data: data, encoding: String.Encoding.utf8)! as String
         debugPrint("PARAMS:",dataString)
         }
         }
         catch {
         encodingError = error
         debugPrint(encodingError!)
         }*/
        debugPrint("PARAMS:",parameters as Any)
        
        // MARK: internet
        self.checkInternetForAPIService(internet: internet)
        
        // MARK: loader
        //self.show_APIService_Loader(loader: loader, loadingText: loaderText)
        //        if(url==APIS.GetOrderHistory || url==APIS.TradeInProcess || url==APIS.GetOffers || url==APIS.HideCancelHistory)
        //        {
        //            print("Do not show ProgressHUD")
        //        }
        //        else
        //        {
        //            SVProgressHUD.show()
        //
        //        }
        
        // MARK: assign values to class objects
        //        self.constantSender = sender
        
        // MARK: assign values to success and fail blocks
        self.resultSuccess = success_block
        //        self.resultFail = fail_block
        
        // MARK: urlEncoding
        let requestUrl = self.encodedRequestUrl(url: url, urlEncoding: urlEncoding)
        
        
        //// MARK: assign request to class object
        //self.apiRequest = Alamofire.request(method, requestUrl, parameters: parameters)
        
        
        // MARK: apiServiceType
        self.useAPIServiceType(apiServiceType: apiServiceType)
        
        
        // MARK: requestSerialization
        self.serializeRequest(requestSerialization: requestSerialization)
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
        print("Header==",headers as Any)
        // MARK: startAPIRequestWithResponseSerialization
        self.startAPIRequestWithResponseSerialization(responseSerialization: responseSerialization, method: method, requestUrl: requestUrl, parameters: parameters, urlEncoding: urlEncoding, requestHeaders: headers, responseFormat: responseFormat, errorState: errorState, loader: loader)
        
    }
    
    //***********************************************************************
    
    /// checkInternetForAPIService
    // MARK: - checkInternetForAPIService
    func checkInternetForAPIService(internet: Internet)
    {
        
        // MARK: internet : DEFAULT, CHECK, DONTCHECK
        switch internet
        {
            
        case .DEFAULT:
            // No Internet Alert here
            break
            
            
        case .CHECK:
            // No Internet Alert here
            break
            
            
        case .DONTCHECK:
            break
            
            
            //default: break
            
        }
        
    }
    
    //***********************************************************************
    
    /// show_APIService_Loader
    // MARK: - show_APIService_Loader
    func show_APIService_Loader(loader: Loader, loadingText: String)
    {
        
        // MARK: Loder : DEFAULT, SHOW, DONTSHOW, HIDE, ANIMATING, CUSTOM
        switch loader
        {
            
        case .DEFAULT:
            
            
            //let loadingText = (AppMethod.isNullString(AppString.Loading)) ? AppString.Loading : AppString.Loading
            //             showLoader("")
            
            break
            
            
        case .SHOW:
            
            //let loadingText = (AppMethod.isNullString(AppString.Loading)) ? AppString.Loading : AppString.Loading
            //             showLoader("")
            
            break
            
            
        case .DONTSHOW:
            
            break
            
            
        case .HIDE:
            
            break
            
            
        case .ANIMATING:
            
            break
            
            
        case .CUSTOM:
            
            break
            
            
            //default: break
            
        }
        
    }
    
    /// hide_APIService_Loader
    // MARK: - hide_APIService_Loader
    func hide_APIService_Loader(loader: Loader)
    {
        
        // MARK: Loder : DEFAULT, SHOW, DONTSHOW, HIDE, ANIMATING, CUSTOM
        switch loader
        {
            
        case .DEFAULT:
            
            //           hideLoader()
            
            break
            
            
        case .SHOW:
            
            //           hideLoader()
            
            break
            
            
        case .DONTSHOW:
            
            break
            
            
        case .HIDE:
            
            break
            
            
        case .ANIMATING:
            
            break
            
            
        case .CUSTOM:
            
            break
            
            
            //default: break
            
        }
        
    }
    
    //***********************************************************************
    
    /// encodedRequestUrl
    // MARK: - encodedRequestUrl
    func encodedRequestUrl(url: String, urlEncoding: UrlEncoding) -> String
    {
        
        var requestUrl = url
        
        // MARK: UrlEncoding : DEFAULT, PERCENT
        switch urlEncoding
        {
            
            // MARK: - DEFAULT
        case .DEFAULT:
            
            break
            
            
            // MARK: - PERCENT
        case .PERCENT:
            
            requestUrl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
            break
            
            
            //default: break
            
        }
        
        return requestUrl
        
    }
    
    //***********************************************************************
    
    /// useAPIServiceType
    // MARK: - useAPIServiceType
    func useAPIServiceType(apiServiceType: APIServiceType)
    {
        
        // MARK: apiServiceType : DEFAULT, REST, SOAP
        switch apiServiceType
        {
            
        case .DEFAULT:
            
            break
            
            
            // MARK: - REST
        case .REST:
            
            break
            
            
            // MARK: - SOAP
        case .SOAP:
            
            break
            
            
            //default: break
            
        }
        
    }
    
    //***********************************************************************
    
    /// serializeRequest
    // MARK: - serializeRequest
    func serializeRequest(requestSerialization: RequestSerialization)
    {
        
        // MARK: requestSerialization : DEFAULT, JSON, XML
        switch requestSerialization
        {
            
        case .DEFAULT:
            
            break
            
            
            // MARK: - JSON
        case .JSON:
            
            break
            
            
            // MARK: - XML
        case .XML:
            
            break
            
        }
        
    }
    
    //***********************************************************************
    
    /// startAPIRequestWithResponseSerialization
    // MARK: - startAPIRequestWithResponseSerialization
    func startAPIRequestWithResponseSerialization(responseSerialization: ResponseSerialization, method: Alamofire.HTTPMethod = .get, requestUrl: String, parameters: [String: AnyObject]? = nil, urlEncoding: UrlEncoding = .DEFAULT, requestHeaders: [String: String]? = nil, responseFormat: ResponseFormat = .DEFAULT, errorState: ErrorState = .DEFAULT, loader: Loader = .DEFAULT)
    {
        
        // MARK: responseSerialization : DEFAULT, DATA, STRING, JSON, PROPERTYLIST, XML
        switch responseSerialization
        {
            
            // MARK: - JSON
        case .DEFAULT, .JSON:
            
            self.requestForJsonResponse(method, requestUrl: requestUrl, parameters: parameters, urlEncoding: urlEncoding, requestHeaders: requestHeaders, responseFormat: responseFormat, errorState: errorState, loader: loader)
            
            break
            
            
            // MARK: - DATA
        case .DATA, .XML:
            
            self.requestForXmlOrDataResponse(method, requestUrl: requestUrl, parameters: parameters, urlEncoding: urlEncoding, requestHeaders: requestHeaders, responseFormat: responseFormat, errorState: errorState, loader: loader)
            
            break
            
            
            // MARK: - STRING
        case .STRING:
            
            self.requestForStringResponse(method, requestUrl: requestUrl, parameters: parameters, urlEncoding: urlEncoding, requestHeaders: requestHeaders, responseFormat: responseFormat, errorState: errorState, loader: loader)
            
            break
            
            
            // MARK: - PROPERTYLIST
        case .PROPERTYLIST:
            
            self.requestForPlistResponse(method, requestUrl: requestUrl, parameters: parameters, urlEncoding: urlEncoding, requestHeaders: requestHeaders, responseFormat: responseFormat, errorState: errorState, loader: loader)
            
            break
            
            
            //default: break
            
        }
        
    }
    
    /// requestForJsonResponse
    // MARK: - requestForJsonResponse
    func requestForJsonResponse(_ method: Alamofire.HTTPMethod = .get, requestUrl: String, parameters: [String: AnyObject]? = nil, urlEncoding: UrlEncoding = .DEFAULT, requestHeaders: [String: String]? = nil, responseFormat: ResponseFormat = .DEFAULT, errorState: ErrorState = .DEFAULT, loader: Loader = .DEFAULT)
    {
        
        Alamofire.request(requestUrl, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: requestHeaders).responseJSON(completionHandler: { response in
            //Alamofire.request(requestUrl, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: requestHeaders).authenticate(user: "admin", password: "1234").responseJSON(completionHandler: { response in
            
            //  debugPrint(response)
            
            var json : NSDictionary? = nil
            if response.result.value != nil {
                json = (response.result.value as! NSDictionary)
            }
            
            var error : Error? = nil
            if response.result.error != nil {
                error = response.result.error
            }
            
            //            hideLoader()
            
            // MARK: response.result : Success, Failure
            switch response.result
            {
                
                //success
            case .success:
                self.successResponse(json, error: error, responseFormat: responseFormat, errorState: errorState, loader: loader)
                
                //failure error
            case .failure(let error):
                //print("error", error)
                self.successResponse(nil, error: error, responseFormat: responseFormat, errorState: errorState, loader: loader)
                //self.failError(json, error: error, errorState: errorState, loader: loader)
            }
        })
        
    }
    
    /// requestForXmlOrDataResponse
    // MARK: - requestForXmlOrDataResponse
    func requestForXmlOrDataResponse(_ method: Alamofire.HTTPMethod = .get, requestUrl: String, parameters: [String: AnyObject]? = nil, urlEncoding: UrlEncoding = .DEFAULT, requestHeaders: [String: String]? = nil, responseFormat: ResponseFormat = .DEFAULT, errorState: ErrorState = .DEFAULT, loader: Loader = .DEFAULT)
    {
        
        Alamofire.request(requestUrl, parameters: parameters, encoding: JSONEncoding.default, headers: requestHeaders)
            .responseData(completionHandler: { response in
                
                //       debugPrint(response)
                let dict = try? XMLReader.dictionary(forXMLData: response.data) as NSDictionary
                
                var json : NSDictionary? = nil
                if dict != nil
                {
                    json = (dict!)
                }
                
                var error : Error? = nil
                if response.result.error != nil
                {
                    error = response.result.error
                }
                
                // MARK: response.result : Success, Failure
                switch response.result
                {
                    
                    //success
                case .success:
                    
                    self.successResponse(json, error: error, responseFormat: responseFormat, errorState: errorState, loader: loader)
                    
                    //failure error
                case .failure(let error):
                    self.successResponse(nil, error: error, responseFormat: responseFormat, errorState: errorState, loader: loader)
                    //                    self.failError(json, error: error, errorState: errorState, loader: loader)
                    print(error)
                    
                }
                
            })
        
    }
    
    /// requestForStringResponse
    // MARK: - requestForStringResponse
    func requestForStringResponse(_ method: Alamofire.HTTPMethod = .get, requestUrl: String, parameters: [String: AnyObject]? = nil, urlEncoding: UrlEncoding = .DEFAULT, requestHeaders: [String: String]? = nil, responseFormat: ResponseFormat = .DEFAULT, errorState: ErrorState = .DEFAULT, loader: Loader = .DEFAULT)
    {
        
        Alamofire.request(requestUrl, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: requestHeaders).responseString(completionHandler: { response in
            
            //debugPrint(response)
            
            var json : NSDictionary? = nil
            if response.result.value != nil
            {
                json = (response.result.value as! NSDictionary?)
            }
            
            var error : Error? = nil
            if response.result.error != nil
            {
                error = response.result.error
            }
            
            // MARK: response.result : Success, Failure
            switch response.result
            {
                
                //success
            case .success:
                
                self.successResponse(json, error: error, responseFormat: responseFormat, errorState: errorState, loader: loader)
                
                //failure error
            case .failure(let error):
                print(error)
                self.successResponse(nil, error: error, responseFormat: responseFormat, errorState: errorState, loader: loader)
                //                self.failError(json, error: error, errorState: errorState, loader: loader)
                
            }
            
        })
        
    }
    
    /// requestForPlistResponse
    // MARK: - requestForPlistResponse
    func requestForPlistResponse(_ method: Alamofire.HTTPMethod = .get, requestUrl: String, parameters: [String: AnyObject]? = nil, urlEncoding: UrlEncoding = .DEFAULT, requestHeaders: [String: String]? = nil, responseFormat: ResponseFormat = .DEFAULT, errorState: ErrorState = .DEFAULT, loader: Loader = .DEFAULT)
    {
        
        Alamofire.request(requestUrl, parameters: parameters, encoding: JSONEncoding.default, headers: requestHeaders).responsePropertyList(completionHandler: { response in
            
            //    debugPrint(response)
            
            var json : NSDictionary? = nil
            if response.result.value != nil
            {
                json = (response.result.value as! NSDictionary)
                
            }
            
            var error : Error? = nil
            if response.result.error != nil
            {
                error = response.result.error
                
            }
            
            // MARK: response.result : Success, Failure
            switch response.result
            {
                
                //success
            case .success:
                
                self.successResponse(json, error: error, responseFormat: responseFormat, errorState: errorState, loader: loader)
                
                //failure error
            case .failure(let error):
                self.successResponse(nil, error: error, responseFormat: responseFormat, errorState: errorState, loader: loader)
                //                self.failError(json, error: error, errorState: errorState, loader: loader)
                print(error)
                
            }
            
        })
        
    }
    
    //***********************************************************************
    
    
    /// successResponse
    // MARK: - successResponse
    /**
     *
     */
    func successResponse(_ json:NSDictionary? ,error:Error?, responseFormat: ResponseFormat, errorState: ErrorState, loader: Loader) -> Void {
        
        //self.hide_APIService_Loader(loader: loader)
        //SVProgressHUD.dismiss()
        if json != nil {
            if (self.resultSuccess != nil) {
                //var result = response.result.value!
                self.resultSuccess?(true, json ,error)
            }
            else {
                self.resultSuccess?(false, nil ,error)
                
            }
//            else {
//                self.resultSuccess?(false, nil ,error)
//                //self.failResponse(json, error: error, errorState: errorState)
//            }
        }
        
        
        /// failResponse
        // MARK: - failResponse
        /**
         *
         */
        //    func failResponse(_ json:NSDictionary? , error:Error?, errorState: ErrorState) -> Void
        //    {
        //
        //        if (self.resultFail != nil)
        //        {
        //            self.failResponseByErrorState(errorState: errorState, json, error: error)
        //        }
        //        else
        //        {
        //            //debugPrint("fail_block is nil")
        //        }
        //    }
        /// failError
        // MARK: - failError
        /**
         *
         */
        //    func failError(_ json:NSDictionary?, error : Error?, errorState: ErrorState, loader: Loader) -> Void
        //    {
        //
        //        self.hide_APIService_Loader(loader: loader)
        //
        //        if (self.resultFail != nil)
        //        {
        //            self.failResponseByErrorState(errorState: errorState, json, error: error)
        //        }
        //        else
        //        {
        //           // debugPrint("fail_block is nil")
        //        }
        //
        //    }
        
        func failResponseByErrorState(errorState: ErrorState, _ json:NSDictionary?, error : Error?)
        {
            
            // MARK: errorState : DEFAULT, PASSTOPARENT, DONTPASS
            switch errorState
            {
                
            case .DEFAULT:
                self.resultSuccess?(false, nil ,error)
                //            self.resultFail?(false, nil, error)
                print(error?.localizedDescription ?? "")
                break
                
                
            case .PASSTOPARENT:
                self.resultSuccess?(false, nil ,error)
                //            self.resultFail?(true, json, error)
                
                break
                
                
            case .DONTPASS:
                
                break
                
                
                //default: break
                
            }
            
        }
        
        //***********************************************************************
        
    }
}
