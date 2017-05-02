//
//  UserModel.swift
//  login
//
//  Created by mac on 27/04/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation

class UserModel {

    private var  login : String = ""
    private var password: String = ""
    private var nom: String = ""
    private var prenom: String = ""
    private var dateNaissance : Date = Date()
    private var codePostal: String = ""
    
    init(login: String, password:String, nom: String, prenom: String, dateNaissance: Date, codePostal: String){
        //super.init()
        self.login = login
        self.password = password.md5()
        self.nom = nom
        self.prenom = prenom
        self.dateNaissance = dateNaissance
        self.codePostal = codePostal
    }
    init(){
        
    }
    //Les Guetteurs
    func getNom ()->String {
        return self.nom
    }
    
    func getPrenom ()->String {
        return self.prenom
    }
    
    func getdateNaissance ()->Date {
        return self.dateNaissance
    }
    
    func getcodePostal ()->String {
        return self.codePostal
    }
    
    func getlogin ()->String {
        return self.login
    }
    
    func getPWD ()->String {
        return self.password
    }
    
    // Les setteurs
    func setNom(nom:String){
        self.nom = nom
    }
    
    func setPrenom(prenom:String){
        self.prenom = prenom
    }
    
    func setdateNaissance ( datenaissance:Date){
        self.dateNaissance = datenaissance
    }
    
    func setcodePostal( codePostal: String){
        self.codePostal = codePostal
    }
    
    func setPassword ( password : String){
        self.password = password.md5()
    }
    
    func setLogin ( login:String){
        self.login = login
    }
    
}
func == (user01: UserModel, user02: UserModel) -> Bool {
    return user01.getNom() == user02.getNom() && user01.getPrenom() == user02.getPrenom() && user01.getcodePostal() == user02.getcodePostal() && user01.getdateNaissance() == user02.getdateNaissance()
}
