//
//  Person.swift
//  DırectoryApp
//
//  Created by Ebubekir Aykut on 25.11.2021.
//

import Foundation
class Person{
    var kisi_id:Int?
    var kisi_ad:String?
    var kisi_tel:String?
    
    init(){
        
    }
    
    init(kisi_id:Int,kisi_ad:String,kisi_tel:String){
        self.kisi_id = kisi_id
        self.kisi_ad = kisi_ad
        self.kisi_tel = kisi_tel
    }
}
