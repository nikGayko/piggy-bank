//
//  SelectGroupViewController.swift
//  piggy-bank
//
//  Created by Никита Гайко on 09/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit
class SelectGroupViewController: UIViewController {
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ComposeBillViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        completeButton.reactive.tap.bind(to: viewModel.completeComposing).dispose(in: reactive.bag)
    }
}

extension SelectGroupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groupFetchResultController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GroupTableViewCell = tableView.dequeueCell(for: indexPath)
        let item = viewModel.groupFetchResultController.object(at: indexPath)
        cell.group = item
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.groupFetchResultController.object(at: indexPath)
        viewModel.selectedGroup.next(item)
    }
}
