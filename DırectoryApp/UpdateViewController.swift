//
//  UpdateViewController.swift
//  DırectoryApp
//
//  Created by Ebubekir Aykut on 17.11.2021.
//

import UIKit

class UpdateViewController: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    var selectedPerson:Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let s = selectedPerson{
            nameText.text = s.kisi_ad
            phoneText.text = s.kisi_tel
        }
    }
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        Persondao().updatePerson(kisi_id: (selectedPerson?.kisi_id!)!, kisi_ad: nameText.text!, kisi_tel: phoneText.text!)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
  

}
