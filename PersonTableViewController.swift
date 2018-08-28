//
//  ViewController.swift
//  PipedriveTask
//
//  Created by Maryam Alimohammadi on 8/16/18.
//  Copyright © 2018 Maryam Alimohammadi. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import SDWebImage

class PersonsTableViewController: UITableViewController {
    
    let cellIdentifier = "PersonTableViewCell"
    var viewModel: PersonViewModel!
    var selectedContact = ContactObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        viewModel = PersonViewModel(personArray: [])
        viewModel.personArray?.bindAndFire(listener: {  _ in
            self.tableView.reloadData()
        })
        viewModel.getPersons()
    }
    
    func configTable(){
        self.title = "Persons"
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    

    //MARK: - Navigator
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier{
        case "ShowDetail":
            if let vc = segue.destination as? PersonDetailViewController{
                vc.contact = selectedContact
            }
        default:
            break
        }
    }
}

extension PersonsTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedContact = viewModel.selectedModel(row: indexPath.row)
        self.performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PersonTableViewCell
        cell.nameLabel.text = viewModel.titleOfRow(row: indexPath.row)
        cell.personImageView.sd_setImage(with: URL(string: viewModel.imageOfRow(row: indexPath.row)), placeholderImage: nil)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
}




