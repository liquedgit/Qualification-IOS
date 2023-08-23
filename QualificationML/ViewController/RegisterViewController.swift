//
//  RegisterViewController.swift
//  QualificationML
//
//  Created by prk on 23/08/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    var context : NSManagedObjectContext!
    
    @IBOutlet weak var UsernameTxt: UITextField!
    
    
    @IBOutlet weak var PasswordTxt: UITextField!
    
    @IBOutlet weak var ConfirmPasswordTxt: UITextField!
    
    @IBOutlet weak var LastnameTxt: UITextField!
    
    @IBOutlet weak var FirstnameTxt: UITextField!
    
    
    @IBAction func RegisterBtnOnclick(_ sender: Any) {
        let username = UsernameTxt.text!
        let password = PasswordTxt.text!
        let confirmPassword = ConfirmPasswordTxt.text!
        let firstName = FirstnameTxt.text!
        let lastname = LastnameTxt.text!
        
        if(username == "" || firstName == "" || lastname == "" || password == "" || confirmPassword == ""){
            let alert = UIAlertController(title: "Error", message: "All fields must be fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert,animated: true, completion: nil)
            return
        }
        
        if(password != confirmPassword){
            let alert = UIAlertController(title: "Error", message: "Password not matched", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert,animated: true, completion: nil)
            return
        }
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(username, forKey: "username")
        newUser.setValue(password, forKey: "password")
        newUser.setValue(firstName, forKey: "firstname")
        newUser.setValue(lastname, forKey: "lastname")
        
        do{
            try context.save()
            if let nextView = storyboard?.instantiateViewController(withIdentifier: "LoginViewController"){
                
                navigationController?.setViewControllers([nextView], animated: true)
            }
        }catch{
            let alert = UIAlertController(title: "Error", message: "Error occured", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert,animated: true, completion: nil)
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
