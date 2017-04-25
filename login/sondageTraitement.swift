//
//  sondageTraitement.swift
//  login
//
//  Created by mac on 12/04/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation

class sondageViewController {
    
    func getAllSondageBDD(){
             let URL_SAVE_TEAM = "http://laurentjutier.com/Meriem/login.php?sondage=1"
        
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print(error ?? "")
                return;
            }
            else{
                //Cette partie sera exécuter après la fin de la requête en effet elle le remet à la tête
                return;
            }
        }
        //executing the task
        task.resume()
    }

    

}
