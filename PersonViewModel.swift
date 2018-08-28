//
//  PersonViewModel.swift
//  PipedriveTask
//
//  Created by Maryam Alimohammadi on 8/18/18.
//  Copyright © 2018 Maryam Alimohammadi. All rights reserved.
//

import UIKit
import Realm

class PersonViewModel: NSObject,PersonServiceProtocol {

    let realm = DBOperations.getInstance()
    var clientModel : PersonClientModel!
    var personArray : Dynamic<[ContactObject]>?
    
    init(personArray:[ContactObject]) {
        clientModel = PersonClientModel()
        self.personArray = Dynamic(personArray)
    }
    
    func getPersons(){
        guard let clientModel = clientModel else{
            return
        }
        clientModel.personDelegate = self
        clientModel.getPerosns()
    }
    
    
    func loadPersonsList(userArray: [PersonModel]?, hasError: Bool?) {
        guard hasError == nil else{
            getDataFromDB()
            return
        }
        addToDB(personArray: userArray!)
        getDataFromDB()
    }
    
    //MARK: - Add data to db
    
    func addToDB(personArray:[PersonModel]){
        for item in personArray{
            let contact = ContactObject()
            contact.id = item.id ?? 0
            contact.name = item.name ?? ""
            contact.company_id = item.companyId ?? 0
            contact.company_name = item.orgIdModel.name ?? ""
            contact.open_deal_number = item.openDealsCount ?? 0
            contact.small_picture = item.picture?.pictures?.smallSize ?? ""
            contact.larg_picture = item.picture?.pictures?.largSize ?? ""
            
            for model in item.phone {
                let phone = PhoneObject()
                phone.label = model.label
                phone.value = model.value
                phone.Primary = model.primary
                contact.phone.append(phone)
            }
            
            for model in item.email {
                let email = EmailObject()
                email.label = model.label
                email.value = model.value
                email.Primary = model.primary
                contact.email.append(email)
            }
            
            
            realm.insertOrUpdateObject(object: contact)
        }
    }
    
     //MARK: - Get data from db
    
    func getDataFromDB(){
        personArray?.value = Array(realm.getAllObjects(type: ContactObject.self))
    }
    //MARK: - Tableview
    func numberOfRows()->Int{
        return personArray?.value.count ?? 0
    }
    
    func titleOfRow(row:Int) -> String {
        return personArray?.value[row].name ?? ""
    }
    
    func imageOfRow(row:Int)-> String {
        return personArray?.value[row].small_picture ?? ""
    }
    
    func selectedModel(row:Int)-> ContactObject {
        return personArray?.value[row] ?? ContactObject()
    }
    

    
}

