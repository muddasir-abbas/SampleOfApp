//
//  CheckStatusModel.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import Foundation
import Alamofire
import SwiftyJSON

public struct User: Decodable, Encodable {
    public var username: String
    public var email: String
    public var phone: String
    public var is_email_verified: Int
    public var is_phone_verified: Int
    public var unverified_email: String
    public var unverified_phone: String
    public var token: String
    public var id: Int
    public var image: String
    public var facebookusername: String
    public enum CodingKeys: String, CodingKey {
        case  username, email, phone, is_email_verified, is_phone_verified, token, id, image, unverified_email, unverified_phone, facebookusername
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
        self.email = try container.decode(String.self, forKey: .email)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.is_email_verified = try container.decode(Int.self, forKey: .is_email_verified)
        self.is_phone_verified = try container.decode(Int.self, forKey: .is_phone_verified)
        self.token = try container.decode(String.self, forKey: .token)
        self.id = try container.decode(Int.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.unverified_email = try container.decode(String.self, forKey: .unverified_email)
        self.unverified_phone = try container.decode(String.self, forKey: .unverified_phone)
        self.facebookusername = try container.decode(String.self, forKey: .facebookusername)
    }
}


