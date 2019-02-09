//
//  ViewController.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit
import CoreData
import ReactiveKit

class BillsListViewController: UIViewController {

    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var statusBarBackground: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createBillButton: UIButton!
    @IBOutlet weak var placeholderContainer: UIStackView!
    @IBOutlet weak var contentContainer: UIView!
    
    @IBOutlet weak var createButtonContainer: UIView!
    @IBOutlet weak var coinButton: UIButton!
    @IBOutlet weak var coinGroupButton: UIButton!
    
    var viewModel: BillsListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCell(BillTableViewCell.self)
        tableView.registerView(BillsListSectionHeader.self)
        
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: createButtonContainer.bounds.height, right: 0)
        viewModel.fetchResultController.delegate = self
        
        viewModel.mainTitle.bind(to: mainTitleLabel.reactive.text).dispose(in: reactive.bag)
        
        viewModel.isSourceEmpty.observeNext(with: {[weak self] (isEmpty) in
            self?.contentContainer.isHidden = isEmpty
            self?.statusBarBackground.isHidden = isEmpty
            self?.placeholderContainer.isHidden = !isEmpty
        }).dispose(in: reactive.bag)
        
        merge(createBillButton.reactive.tap, coinButton.reactive.tap)
            .bind(to: viewModel.createBill)
            .dispose(in: reactive.bag)
        
        coinGroupButton.reactive.tap.bind(to: viewModel.createGroup).dispose(in: reactive.bag)
    }
    
}

extension BillsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.fetchResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BillTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.configure(bill: viewModel.fetchResultController.object(at: indexPath))
        return cell
    }
}

extension BillsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: BillsListSectionHeader = tableView.dequeueView()
        view.titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        return view
    }
}

extension BillsListViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
