//
//  SelectBill.swift
//  piggy-bank
//
//  Created by Никита Гайко on 09/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit
class SelectBillViewController: UIViewController {
    
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var billsTableView: UITableView!
    @IBOutlet weak var completeButton: UIButton!
    
    var viewModel: GroupViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billsTableView.registerCell(BillTableViewCell.self)
        billsTableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0) // Inset for triangle

        do {
            try viewModel.fetchedResultController.performFetch()
        } catch {
            debugPrint("Failed to fetch \(error)")
        }
        
        completeButton.reactive.tap.bind(to: viewModel.complete).dispose(in: reactive.bag)
    }
    
}

extension SelectBillViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchedResultController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BillTableViewCell = tableView.dequeueCell(for: indexPath)
        let bill = viewModel.fetchedResultController.object(at: indexPath)
        cell.configure(bill: bill)
        cell.selectionMode = true
        cell.itemSelected = viewModel.isBillSelected(bill)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard
            let cell = tableView.cellForRow(at: indexPath) as? BillTableViewCell else {
                return
        }
        
        let itemSelected = !cell.itemSelected
        cell.itemSelected = itemSelected
        if itemSelected {
            viewModel.addBill.next(indexPath)
        } else {
            viewModel.removeBill.next(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
