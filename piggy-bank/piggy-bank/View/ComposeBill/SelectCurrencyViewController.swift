//
//  SelectCurrencyViewController.swift
//  piggy-bank
//
//  Created by Никита Гайко on 04/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit
import CoreData

class SelectCurrencyViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ComposeBillViewModel!
    
    private let collectionTopInset: CGFloat = 10.0
    private let collectionBottomInset: CGFloat = 10.0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerCell(CurrencyCollectionViewCell.self)
        
        viewModel.availableCurrencies.bind(to: collectionView) { (currencies, indexPath, collectionView) -> UICollectionViewCell in
            let cell: CurrencyCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(currencies[indexPath.row])
            return cell
        }
    }
}

extension SelectCurrencyViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let cell: CurrencyCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        cell.isHighlighted = true
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell: CurrencyCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        cell.isHighlighted = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCurrency.next(indexPath)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let cellSize = self.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: IndexPath(row: 0, section: 0))
//        let emptySpace = (collectionView.frame.width / cellSize.width).truncatingRemainder(dividingBy: 1.0) * cellSize.width
//        let inset = emptySpace / 2
//        return UIEdgeInsets(top: collectionTopInset, left: inset, bottom: collectionBottomInset, right: inset)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellHeight = collectionView.frame.height - collectionTopInset - collectionBottomInset
//        let cellWidth = cellHeight / CurrencyCollectionViewCell.aspectRation()
//
//        return CGSize(width: cellHeight, height: cellWidth)
//    }
}
