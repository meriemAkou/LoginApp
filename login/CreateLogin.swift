
import UIKit
import CryptoSwift

class CreateLogin: UIViewController, UITextFieldDelegate {
    
    var loginPassword : String=""
    let datePicker = UIDatePicker()
    var message : String=""
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var EmailCreate: UITextField!
    @IBOutlet weak var passwordCreate: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    @IBOutlet weak var dateNaissance: UITextField!
    @IBOutlet weak var codePostal: UITextField!
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var Nom: UITextField!
    
    @IBAction func connexion(_ sender: UIButton) {
        
       // var identifiant = loginPassword.components(separatedBy: "/")
        //let request :RequestTraitement = RequestTraitement(urlString: "http://laurentjutier.com/7mFDw5q/", login: identifiant[0], passeword: identifiant[1])
        //request.sendRequest(controller:nil)
        //On est dans la connexion
        
                // Avant d'instancier la classe on verifie les données pour afficher les messages d'erreur au cas ou 
                let createLogin :VerifyData = VerifyData()
                let (correct,message)=createLogin.validateDonnee(mail: EmailCreate.text!, password: passwordCreate.text!, confirmPassword: ConfirmPassword.text!, nom: Nom.text!, prenom: prenom.text!, dateNaissance: dateNaissance.text!, codePostal: codePostal.text!)
                if (correct == false)
                {
                    self.message = message
                    //print(message)
        
                }else {
                   // createLogin = VerifyData(mail: EmailCreate.text!, password: passwordCreate.text!.md5(), confirmPassword: ConfirmPassword.text!.md5(), nom: Nom.text!, prenom: prenom.text!, dateNaissance: dateNaissance.text!, codePostal: codePostal.text!)
                    //Transformer la date de naissance 
                
                        let inputFormatter01 = DateFormatter()
                        inputFormatter01.dateFormat = "dd-MM-yyyy"
                        let myDate = inputFormatter01.date(from: String(dateNaissance.text!))
                        let inputFormatter = DateFormatter()
                        inputFormatter.dateFormat = "yyyy-MM-dd"
                        let dateNaissanceString  = inputFormatter.string(from: myDate!)
                        let BearthDate: Date = inputFormatter.date(from: dateNaissanceString)!

                        let user: UserModel = UserModel(login: EmailCreate.text!, password: passwordCreate.text!, nom: Nom.text!, prenom: prenom.text!, dateNaissance: BearthDate, codePostal: codePostal.text!)
                        createLogin.insertinDB(User: user)
                    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        createDatePicker()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let point01 = CGPoint(x: 0,y :0)
        scrollView.setContentOffset(point01, animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let point = CGPoint(x: 0,y :textField.tag*50)
        switch textField.tag {
        case 0...1:
            print ("Je ne fais rien")
        default:
            scrollView.setContentOffset(point, animated: true)
        }
 
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 0:
            prenom.becomeFirstResponder()
        case 1:
            dateNaissance.becomeFirstResponder()
        case 2:
            codePostal.becomeFirstResponder()
        case 3:
            EmailCreate.becomeFirstResponder()
        case 4:
            passwordCreate.becomeFirstResponder()
        case 5 :
            ConfirmPassword.becomeFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    // Configurer le text field pour ouvrire le DatePicker et choisir une date
    func createDatePicker(){
       //Format Date pour picker
        datePicker.datePickerMode = .date
        
    //Create toolbar to add a Datepicker qui sera dans le bas de l'écran
      let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //Le boutton dans la toolBar qui sera Done pour permettre de copier la date dans le text field et fermer le Date picker 
       let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        dateNaissance.inputAccessoryView = toolbar
        // rattacher le Date picker au text field 
        //Dans le cas ou on aimerait forcer l'affichage de la date en Français
        //datePicker.locale = NSLocale.init(localeIdentifier: "fr_FR") as Locale
        dateNaissance.inputView=datePicker
    
    }
    
    //Fonction qui sera appeler quand on cliquera sur le bouton Done dans la toolbar du DatePicker 
    func donePressed(){
        // Formatter la date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateNaissance.text=dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }

     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == "Label" {
           // let nextScene = segue.destination as? PopUpViewController
            //nextScene?.label = self.message
            
        }
    }
    
    
}
