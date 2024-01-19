//
//  Utility.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import SwiftToast
//import AKSide
import Foundation
import UIKit

/**
 * Currnet Location details
 */
struct LocationDetails
{
    static var latitude = ""
    static var longitude = ""
}

typealias UTILITY = (_ status:Int) -> Void
class Utility : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    static var util: Utility? = nil
 
    class func shared() -> Utility
    {
        /*!
         *sharedModel of LaunchModel class.
         */
        if util == nil
        {
            util = Utility()
        }
        return util!
    }
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    static func customObject(forKey key: String) -> User? {
        var decodedObject: User? = nil
        if let data = uDefaults.data(forKey: key) {
            do {
                // Create JSON Decoder
//                let decoder = JSONDecoder()

                // Decode Note
                let data = try Utility.shared().decoder.decode(User.self, from: data)
                decodedObject = data

            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return decodedObject
    }
   
//    static func customObject(forKey key: String) -> Any?? {
//        var decodedObject: Any? = nil
//        if let data = uDefaults.value(forKey: key!) as? Data, key == "user" {
//            if let decoded = try? decoder.decode(User.self, from: decodedObject) {
//                decodedObject = decoded
//            }
//        }
//        return decodedObject
//    }
//
    
    static func setCustomObject(_ object: Any?, forKey key: String?) {
        var encodedObject: Data? = nil
        
        if let encoded = try? Utility.shared().encoder.encode(object as? User), key == "user" {
            encodedObject = encoded
        }
        uDefaults.set(encodedObject, forKey: key!)
        uDefaults.synchronize()
    }
   
    /**
     * get Birthdate & seperatorBy in String type and return age in String type
     */
    class func calculateAge(birthdate: String, separatedBy: String) -> String {
        // CALCULATE AGE FROM BIRTHDATE
        let ageComponents = birthdate.components(separatedBy: separatedBy)
        let dateDOB = Calendar.current.date(from: DateComponents(year:
            Int(ageComponents[0]), month: Int(ageComponents[1]), day:
            Int(ageComponents[2])))!
        let calculatedAge = dateDOB.age
        return String(calculatedAge)
    }
   
    
}

public extension UserDefaults {
    
    private struct UserDefaultsError: Error {
        private let message: String
        init(_ message: String) {
            self.message = message
        }
        public var localizedDescription: String {
            return message
        }
    }
    
    func setCustomObject<T: Encodable>(_ object: T?, forKey key: String) throws {
        guard let object = object else {
        removeObject(forKey: key)
            return
        }
        do {
            let encoded = try PropertyListEncoder().encode(object)
            set(encoded , forKey:key)
        } catch {
            throw error
        }

    }

    func customObject<T: Decodable>(forKey key: String) throws -> T? {
        guard let data = data(forKey: key) else {
            return nil
        }
        return try PropertyListDecoder().decode(T.self, from: data)
    }
    
}
