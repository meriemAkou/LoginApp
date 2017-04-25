//
//  UserModel.swift
//  login
//
//  Created by mac on 31/03/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation

class UserModel:NSObject{

    var login:String
    var password:String
    
    func md5(_ string: String) -> String {
        
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        
        return hexString
    }

    
    
    init(login:String,password:String){
        self.login = login
        self.password = password
    }
    
    override var description: String {
        return "login: \(self.login), password: \(self.password)"
    }
    
    

}
