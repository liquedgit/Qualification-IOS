//
//  HomeViewController.swift
//  QualificationML
//
//  Created by prk on 23/08/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfNames = [String]()
    var arrayOfWage = [Int]()
    var arrayOfDivision = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currName = arrayOfNames[indexPath.row]
        let currDivision = arrayOfDivision[indexPath.row]
        let currWageM = arrayOfWage[indexPath.row]
        let currWageY = currWageM * 12
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as! EmployeeCellTableViewCell
        
        cell.DivisionLabel.text = currDivision
        cell.NameLabel.text = currName
        cell.WageYLabel.text = (currWageY as NSNumber).stringValue
        cell.deleteHandler = {
            self.deleteHandler(cell: cell, indexPath: indexPath)
        }
        cell.updateHandler = {
            self.updateHandler(cell: cell, indexPath: indexPath)
        }
        return cell
    }
    
    
    @IBOutlet weak var tableTv: UITableView!
    var name : String = ""
    var context : NSManagedObjectContext!
    
    
    func updateHandler (cell: EmployeeCellTableViewCell, indexPath : IndexPath){
        let oldName = arrayOfNames[indexPath.row]
        let oldDivision = arrayOfDivision[indexPath.row]
        let oldWage = arrayOfWage[indexPath.row]
        let nextView = storyboard?.instantiateViewController(withIdentifier: "UpdateEmployeeViewController") as! UpdateEmployeeViewController
        
        nextView.name = oldName
        nextView.division = oldDivision
        nextView.wage = String(oldWage)
        nextView.userName = name
        
        UIView.transition(with: view.window!, duration: 1, options: .transitionCurlUp, animations: {self.navigationController?.pushViewController(nextView, animated: true)} )
    }
    
    func deleteHandler (cell: EmployeeCellTableViewCell, indexPath : IndexPath){
        let oldName = arrayOfNames[indexPath.row]
        let oldDivision = arrayOfDivision[indexPath.row]
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        
        
        
        
        do{
            request.predicate = NSPredicate(format: "name == %@ AND division == %@", oldName, oldDivision)
            let result = try context.fetch(request) as! [NSManagedObject]
            for data in result{
                context.delete(data)
            }
            loadData()
        }catch{
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTxt.text = name
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        tableTv.delegate = self
        tableTv.dataSource = self
        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    func loadData()
    {
        arrayOfWage.removeAll()
        arrayOfNames.removeAll()
        arrayOfDivision.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        
        do{
            let result = try context.fetch(request) as! [NSManagedObject]
            
            for data in result{
                arrayOfNames.append(data.value(forKey: "name") as! String)
                arrayOfWage.append(data.value(forKey: "wage") as! Int)
                arrayOfDivision.append(data.value(forKey: "division") as! String)
                
            }
            tableTv.reloadData()
            
        }catch{
            print("Error")
        }
    }
    
    @IBAction func RegisteEmployeeOnClick(_ sender: Any) {
        
        let nextView = storyboard?.instantiateViewController(withIdentifier: "RegisterEmployeeViewController") as! RegisterEmployeeViewController
            nextView.name = name
            UIView.transition(with: view.window!, duration: 1, options: .transitionCrossDissolve, animations: {self.navigationController?.pushViewController(nextView, animated: true)} )
            
        
    }
    
    @IBOutlet weak var nameTxt: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
