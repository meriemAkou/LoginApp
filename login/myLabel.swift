//
//  myLabel.swift
//  login
//
//  Created by mac on 10/04/2017.
//  Copyright © 2017 mac. All rights reserved.
///Volumes/Mehdi/login copie/login/myLabel.swift

import UIKit


class myLabel: UILabel {

    override var text: String? {
        didSet {           
            //Detecter si le label est un label de bienvenue c'est àce moment là qu'on enregistre le login et le password dans le keychain
            /*if oldValue == text {
                print("Text not changed.")
            } else {
                print("Text changed.")
            }*/
            if text?.range(of:"bienvenue") != nil {
                //enregistrement dans le keychain 
                
            }
        }
    }
}
