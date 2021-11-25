//
//  ViewController.swift
//  DırectoryApp
//
//  Created by Ebubekir Aykut on 17.11.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var liste = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        copyDataBase()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        liste = Persondao().takeAllPerson()
        searchBar.text = ""
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        if segue.identifier == "toUpdate"{
            let destinationVC = segue.destination as! UpdateViewController
            destinationVC.selectedPerson = liste[indeks!]
        }
        if segue.identifier == "toDetail"{
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.selectedPerson = liste[indeks!]
        }
    }
    
    func copyDataBase(){
        
        let bundleWay = Bundle.main.path(forResource: "kisiler", ofType: ".sqlite")
        
        let targetWay = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let targetToCopy = URL(fileURLWithPath: targetWay).appendingPathComponent("kisiler.sqlite")
        
        if fileManager.fileExists(atPath: targetToCopy.path){
            print("Don't need to copy Database")
        }else{
            do {
                try fileManager.copyItem(atPath: bundleWay!, toPath: targetToCopy.path)
            } catch  {
                print(error)
            }
        }
    }
    
  
}

//              TABLE VİEW
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liste.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! HomeTableViewCell
        cell.nameLabel.text =  liste[indexPath.row].kisi_ad!
        cell.telLabel.text = liste[indexPath.row].kisi_tel!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (contextualAction,view,boolValue) in
            let person = self.liste[indexPath.row]
            Persondao().deletePerson(kisi_id: person.kisi_id!)
            
            self.liste = Persondao().takeAllPerson()
            self.tableView.reloadData()
            
            
        }
        let updateAction = UIContextualAction(style: .normal, title: "Update"){
            (contextualAction,view,boolValue) in
            print("Güncelle Tıklandı \(self.liste[indexPath.row])")
            
            self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
    }
}


//                  SEARCH BAR
extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            liste =  Persondao().searchPerson(kisi_ad: searchText)
            self.tableView.reloadData()
        }else{
            liste = Persondao().takeAllPerson()
            self.tableView.reloadData()
        }
        
    }
}

