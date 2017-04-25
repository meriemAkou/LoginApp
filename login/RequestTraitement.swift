//
//  RequestTraitement.swift
//  login
//
//  Created by mac on 30/03/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
class RequestTraitement{
    
    var login:String;
    var passeword:String;
    var url: URL?;
    var UrlRequest:URLRequest!;
    private var loginString:String;
    private var loginData: Data;
    private var base64LoginString : String;
    var labelText: String;
    
    init(urlString:String?, login:String?, passeword:String?){
        
        self.login=login!;
        self.passeword=passeword!;
        self.labelText=""
        if (urlString != nil && urlString != ""){
            self.url = URL(string: urlString!)
        }
        // Construction d'un String avec le login et le mot de passe
        self.loginString = String(format: "%@:%@", login!, passeword!)
        //Transformer le String en format Data avec un encodage Utf8
        self.loginData = loginString.data(using: String.Encoding.utf8)!
        // mettre le data avec un encodage base 64 pour s'assurer de l'intégrité du message
        self.base64LoginString = loginData.base64EncodedString()
        if url != nil {
            self.UrlRequest = URLRequest(url: url!)
            // self.UrlRequest.httpMethod="POST"
        }
        self.UrlRequest.setValue("Basic \(self.base64LoginString)", forHTTPHeaderField: "Authorization")
    }
    func sendRequest(controller:ViewController?)
    {
        let session = URLSession.shared
        let task = session.dataTask(with: self.UrlRequest){
            (data, response, error) in
            if (response != nil)
            {
                _ = response as! HTTPURLResponse
                if (controller != nil){
                    //controller?.Donnee.text = String(data:data!,encoding:String.Encoding.isoLatin1)
                }
                //print(String(describing: data))
            }else{
                print(String(describing: error))
                if (controller != nil){
                    //controller?.Donnee.text = "On n'arrive pas à récupérer les données ! "
                }
            }
        }
        task.resume()
        
    }
    
}

