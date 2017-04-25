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
    
    var mail:String=""
    var password:String=""
    var confirmPassword:String=""
    var nom:String=""
    var prenom:String=""
    var dateNaissance:String=""
    var codePostal:String=""
    
    //instanciation de la classe avec les bons paramètres
    init(mail:String, password:String, confirmPassword:String, nom:String, prenom:String, dateNaissance:String, codePostal:String){
        self.mail=mail
        self.password=password
        self.confirmPassword=confirmPassword
        self.codePostal=codePostal
        //Formatage de la date sous forme de YYYYMMdd
        if(dateNaissance != ""){
            let inputFormatter01 = DateFormatter()
            inputFormatter01.dateFormat = "dd-MM-yyyy"
            let myDate = inputFormatter01.date(from:dateNaissance)
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            self.dateNaissance  = inputFormatter.string(from: myDate!)
        }else {
            self.dateNaissance = ""
        }
        self.nom = nom
        self.prenom = prenom
    }
    override init(){
        
    }
    
    func insertinDB() {
        
        let URL_SAVE_TEAM = "http://laurentjutier.com/Meriem/login.php?create=1&&new_name="+self.mail + "&&new_password="+self.password + "&&nom="+self.nom+"&&prenom="+self.prenom+"&&dateNaissance="+self.dateNaissance+"&&codePostal="+self.codePostal
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
    
    func VerifyDBCount(controller: connection?) {
        let URL_SAVE_TEAM = "http://laurentjutier.com/Meriem/login.php?connect=1&&username="+self.mail + "&&password="+self.password.md5()
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
    // Pour valider le format du mail
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}
