//
//  DetailsViewController.swift
//  DırectoryApp
//
//  Created by Ebubekir Aykut on 17.11.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var selectedPerson:Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = selectedPerson{
            nameLabel.text = p.kisi_ad!
            phoneLabel.text = p.kisi_tel!
        }
    }
    
}
