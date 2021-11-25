//
//  Persondao.swift
//  DırectoryApp
//
//  Created by Ebubekir Aykut on 25.11.2021.
//

import Foundation

class Persondao{
    let db:FMDatabase?
    
    init(){
        let targetWay = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseUrl = URL(fileURLWithPath: targetWay).appendingPathComponent("kisiler.sqlite")
        
        db = FMDatabase(path: databaseUrl.path)
    }
    
    func addPerson(kisi_ad:String,kisi_tel:String){
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO kisiler (kisi_ad,kisi_tel) VALUES (?,?)", values: [kisi_ad,kisi_tel])
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func takeAllPerson() -> [Person]{
        var list = [Person]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM kisiler", values: nil)
            
            while rs.next() {
                let person = Person(kisi_id: Int(rs.string(forColumn: "kisi_id")!)!,
                                    kisi_ad: rs.string(forColumn: "kisi_ad")!,
                                    kisi_tel: rs.string(forColumn: "kisi_tel")!)
                
                list.append(person)
            }
        } catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    func deletePerson(kisi_id:Int){
        
        db?.open()
        
        do{
            try db?.executeUpdate("DELETE FROM kisiler WHERE kisi_id = ?", values: [kisi_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func updatePerson(kisi_id:Int,kisi_ad:String,kisi_tel:String){
        
        db?.open()
        
        do{
            try db?.executeUpdate("UPDATE kisiler SET kisi_ad = ?,kisi_tel = ? WHERE kisi_id = ?", values: [kisi_ad,kisi_tel,kisi_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func searchPerson(kisi_ad:String) -> [Person]{
        var list = [Person]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM kisiler WHERE kisi_ad like '%\(kisi_ad)%'", values: nil)
            
            while rs.next(){
                let person = Person(kisi_id: Int(rs.string(forColumn: "kisi_id")!)!,
                                    kisi_ad: rs.string(forColumn: "kisi_ad")!,
                                    kisi_tel: rs.string(forColumn: "kisi_tel")!)
                list.append(person)
            }
            
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        return list
    }
    
}
