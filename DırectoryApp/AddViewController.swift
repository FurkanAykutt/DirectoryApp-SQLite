//
//  AddViewController.swift
//  DırectoryApp
//
//  Created by Ebubekir Aykut on 17.11.2021.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        Persondao().addPerson(kisi_ad: nameText.text!, kisi_tel: phoneText.text!)
        navigationController?.popToRootViewController(animated: true)
    }
    
    

}
