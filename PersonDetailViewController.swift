//
//  ContactDetailViewController.swift
//  PipedriveTask
//
//  Created by Maryam Alimohammadi on 8/17/18.
//  Copyright © 2018 Maryam Alimohammadi. All rights reserved.
//

import UIKit
import SDWebImage

class PersonDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var contact  = ContactObject()
    var viewModel:PersonDetailViewModel!
    let headerView = DetailHeaderView.instanceFromNib() as! DetailHeaderView
    let cellIdentifier = "Cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PersonDetailViewModel(contact: contact)
        configTable()
    }
    
    func configTable(){
        
        tableView.separatorStyle = .none
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        tableView.tableHeaderView = headerView
        headerView.nameLabel.text = viewModel.nameOfContact()
        headerView.imageview.sd_setImage(with: URL(string: viewModel.imageOfContact()), placeholderImage: nil)
    }

}

extension PersonDetailViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else{
            return 0
        }
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleOfSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
       viewModel.configCell(cell: cell, indexPath: indexPath)
        return cell
    }
}
