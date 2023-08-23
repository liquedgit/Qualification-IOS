//
//  UpdateEmployeeViewController.swift
//  QualificationML
//
//  Created by prk on 23/08/23.
//

import UIKit
import CoreData



class UpdateEmployeeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        nameTxt.text = name
        divisionTxt.text = division
        wageTxt.text = wage
        // Do any additional setup after loading the view.
    }
    var name : String = ""
    var division : String = ""
    var wage : String = ""
    var userName : String = ""
    var context : NSManagedObjectContext!
    
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var divisionTxt: UITextField!
    
    @IBOutlet weak var wageTxt: UITextField!
    
    
    @IBAction func UpdateBtnOnClick(_ sender: Any) {
        let newName = nameTxt.text
        let newDivision = divisionTxt.text
        let newWage = wageTxt.text
        if(newName == "" || newDivision == "" || newWage == ""){
            let alert = UIAlertController(title: "Error", message: "All fields must be fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert,animated: true, completion: nil)
            return
        }
        
        if(newWage?.isNumber == false){
            let alert = UIAlertController(title: "Error", message: "Wage must be numeric", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert,animated: true, completion: nil)
            return
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        
        request.predicate = NSPredicate(format: "name == %@ AND division == %@ AND wage == %@", name,division, String(wage))
        
        do{
            let result = try context.fetch(request) as! [NSManagedObject]
            for data in result{
                data.setValue(newName, forKey: "name")
                data.setValue(newDivision, forKey: "division")
                data.setValue((newWage! as NSString).intValue,  forKey: "wage")
            }
            try context.save()
            let nextView = storyboard?.instantiateViewController(withIdentifier: "HomeViewControllers") as! HomeViewController
            nextView.name = userName
            
            UIView.transition(with: view.window!, duration: 1, options: .curveLinear, animations: {self.navigationController?.setViewControllers([nextView], animated: true)} )
        }catch{
            print("ERROR")
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
