//
//  ViewController.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class BillsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createBillButton: UIButton!
    
    var viewModel: BillsListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCell(BillTableViewCell.self)
        
        viewModel.dataSource.bind(to: tableView, cellType: BillTableViewCell.self) { (cell, bill) in
            
        }.dispose(in: reactive.bag)
        
        viewModel.isSourceEmpty.map { !$0 }.bind(to: createBillButton.reactive.isHidden).dispose(in: reactive.bag)
        viewModel.isSourceEmpty.bind(to: tableView.reactive.isHidden).dispose(in: reactive.bag)
        
        createBillButton.reactive.tap.bind(to: viewModel.createBill).dispose(in: reactive.bag)
    }

}
