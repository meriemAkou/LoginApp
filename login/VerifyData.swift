//
//  chargementData.swift
//  login
//
//  Created by mac on 31/03/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation

/*protocol chargementData: class {
 func itemsDownloaded(items: NSArray)
 }*/


class VerifyData: NSObject{
    
    func insertinDB(User: UserModel) {
        
        let URL_SAVE_TEAM = "http://laurentjutier.com/Meriem/login.php?create=1&&new_name="+User.getNom() + "&&new_password="+User.getPWD() + "&&nom="+User.getNom()+"&&prenom="+User.getPrenom()+"&&dateNaissance="+User.getcodePostal()+"&&codePostal="+User.getcodePostal()
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "GET"
        //adding the parameters to request body
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print(error ?? "")
                return;
            }
                //parsing the response
            else{
                //Cette partie sera exécuter après la fin de la requête en effet elle le remet à la tête
                
                return;
            }
        }
        //executing the task
        task.resume()
        
    }
    func VerifyEmailDBB(controller: connection?, email:String) {
        let URL_SAVE_TEAM = "http://laurentjutier.com/Meriem/login.php?verify=1&&username="+email
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print(error ?? "")
                return;
            }
                
            else{
                
                // controller.information.isHidden=false
                // Cette fonction ne sera lancer qu'à la fin de l'exécution de la requête
                DispatchQueue.main.async {
                    let dataString = String(data: data!, encoding: String.Encoding.utf8)
                    connection.information = dataString!
                    controller?.stopActivityIndicator()
                }
            }
        }
        //executing the task
        task.resume()
        
        
        
    }
    func VerifyDBCount(controller: connection?, User:UserModel) {
        let URL_SAVE_TEAM = "http://laurentjutier.com/Meriem/login.php?connect=1&&username="+User.getlogin() + "&&password="+User.getPWD()
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print(error ?? "")
                return;
            }
                
            else{
                
                // controller.information.isHidden=false
                // Cette fonction ne sera lancer qu'à la fin de l'exécution de la requête
                DispatchQueue.main.async {
                    let dataString = String(data: data!, encoding: String.Encoding.utf8)
                    connection.information = dataString!
                    controller?.stopActivityIndicator()
                }
            }
        }
        //executing the task
        task.resume()
    }
    //Création d'une fonctions qui verifie les données entréer par l'utiliateur et retourne booleen avec un message d'erreur dans le cas d'erreur
    func validateDonnee (mail:String, password:String, confirmPassword:String,nom:String,prenom:String,dateNaissance:String, codePostal:String)->(Bool,String){
        //Transform la date de naissance de String vers Date
        
        
        //Verifier que tout les champs sont renseigner
        if(mail == "" || password == "" || confirmPassword == "" || nom == "" || prenom == "" || dateNaissance == "" || codePostal == "" ){
            return ( false, " Veuillez remplir tout les champs")
        }else {
            //Verifier si le mail respecte la REGEX des mails
            if !isValidEmail(testStr: mail) {
                return (false,"Ladresse mail est invalide!")
            }
            else {
                if (password != confirmPassword){
                    return (false,"Vous devez renseigner le même mot de passe!")
                }
                else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    let dataDate = dateFormatter.date(from: dateNaissance)!
                    if (dataDate > Date()){
                        return (false,"Date de naissance invalide!")
                    }
                    else {
                        if (Int(codePostal)==nil){
                            return (false,"Code Postale invalide!")
                        }
                    }
                    
                }
                
            }
        }
        return ( true,"")
        
    }
    //Récupérer les informations de l'utilisateur est construire l'objet UserModel
    func getUser (controller: MyAccountViewController, User:UserModel ){
        var result : UserModel = UserModel()
        let URL_SAVE_TEAM = "http://laurentjutier.com/Meriem/login.php?informationUser=1&&username="+User.getlogin() + "&&password="+User.getPWD()
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print(error ?? "")
                return;
            }
                
            else{
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:String]
                    result = self.createUserModel(dictionnary: parsedData)
                }
                catch let error as NSError {
                    print(error)
                }
                // Cette fonction ne sera lancer qu'à la fin de l'exécution de la requête
                DispatchQueue.main.async {
                    let dataString = String(data: data!, encoding: String.Encoding.utf8)
                    print(dataString ?? "");
                    connection.information = dataString!
                        controller.user = result
                        controller.stopActivityIndicator()
                }
                //executing the task
            }
        }
        task.resume()
    }
    // Pour valider le format du mail
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    // Mettre à jour les informations de l'utilisateur
    func updateuser (controller: MyAccountViewController,User:UserModel){
        let URL_SAVE_TEAM = "http://laurentjutier.com/Meriem/login.php?updateUser=1&&username="+User.getlogin()+"&&nom="+User.getNom()+"&&prenom="+User.getPrenom()+"&&dateNaissance="+User.getcodePostal()+"&&codePostal="+User.getcodePostal()
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print(error ?? "")
                return;
            }
                
            else{
                
                // controller.information.isHidden=false
                // Cette fonction ne sera lancer qu'à la fin de l'exécution de la requête
                DispatchQueue.main.async {
                    let dataString = String(data: data!, encoding: String.Encoding.utf8)
                    controller.user = User
                    controller?.stopActivityIndicator()
                }
            }
        }
        //executing the task
        task.resume()

        
    }
    func createUserModel(dictionnary:[String:String])->UserModel{
        let result: UserModel = UserModel()
        result.setNom(nom: dictionnary["nom"]!)
        result.setPrenom(prenom: dictionnary["prenom"]!)
        result.setcodePostal(codePostal: dictionnary["codePostal"]!)
        let inputFormatter01 = DateFormatter()
        inputFormatter01.dateFormat = "yyyy-MM-dd"
        let myDate = inputFormatter01.date(from: dictionnary["dateNaissance"]!)
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"
        let dateNaissanceString  = inputFormatter.string(from: myDate!)
        let BearthDate: Date = inputFormatter.date(from: dateNaissanceString)!
        result.setdateNaissance(datenaissance: BearthDate as Date)
        result.setLogin(login: dictionnary["login"]!)
        
        return result
    }
}
