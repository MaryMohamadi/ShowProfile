//
//  PersonDetailViewModel.swift
//  PipedriveTask
//
//  Created by Maryam Alimohammadi on 8/18/18.
//  Copyright © 2018 Maryam Alimohammadi. All rights reserved.
//

import UIKit

class PersonDetailViewModel: NSObject {
    var contact = ContactObject()
    
    init(contact:ContactObject) {
        self.contact = contact
    }
    
    enum SectionTypes: Int{
        case phone = 0
        case email = 1
        case company = 2
        case deals = 3
        
    }
    
    func numberOfSections() -> Int{
        return 4
    }
    
    func nameOfContact() -> String{
        return contact.name
    }
    
    func imageOfContact() -> String{
        return contact.larg_picture
    }
    
    func titleOfSection(section:Int) -> String{
        switch section{
        case SectionTypes.phone.rawValue:
            return "Phones"
        case SectionTypes.email.rawValue:
            return "Emails"
        case SectionTypes.company.rawValue:
            return "Company"
        case SectionTypes.deals.rawValue:
            return "Deals"
        default:
            return ""
        }
    }
    
    func numberOfRow(section:Int) -> Int{
        switch section{
        case SectionTypes.phone.rawValue:
            return contact.phone.count
        case SectionTypes.email.rawValue:
            return contact.email.count
        default:
            return 1
        }
    }
    
    func configCell(cell:UITableViewCell, indexPath:IndexPath) {
        switch indexPath.section {
        case SectionTypes.phone.rawValue:
            let model = contact.phone[indexPath.row]
            cell.textLabel?.text = model.label
            cell.detailTextLabel?.text = model.value
        case SectionTypes.email.rawValue:
            let model = contact.email[indexPath.row]
            cell.textLabel?.text = model.label
            cell.detailTextLabel?.text = model.value
        case SectionTypes.company.rawValue:
            cell.textLabel?.text = contact.company_name
        case SectionTypes.deals.rawValue:
            cell.textLabel?.text = "\(contact.open_deal_number)"
        default:
            break
        }
    }
    
}
