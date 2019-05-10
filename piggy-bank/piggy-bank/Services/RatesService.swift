//
//  RatesService.swift
//  piggy-bank
//
//  Created by Никита Гайко on 09/05/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import ReactiveKit
import Bond

class RatesService {
    
    var networkService: NetworkService!
    
    var rates = MutableObservableSet<Rate>([])
    
    private let accessKey = "ef59ff3b32864499d42d9b86a2325f71"
    private let cacheKey = "com.piggy-bank.currency.cache"
    
    private let disposeBag = DisposeBag()
    
    init() {
        restoreCache()
        rates.skip(first: 1).observe { [weak self] (event) in
            switch event {
            case .next(_):
                self?.cacheRates()
            default:
                break
            }
        }.dispose(in: disposeBag)
    }
    
    deinit {
        disposeBag.dispose()
    }
    
    func updateRates() -> Signal<Void, NetworkError> {
        let endpoint = "http://data.fixer.io/api/latest?access_key=\(accessKey)"
        return networkService.requestJSON(url: endpoint, method: .get)
            .take(first: 1)
            .map({ [weak self] (json) -> Void in
                guard let base = CurrencyType(rawValue: json.base.string?.lowercased() ?? "") else {
                    return
                }

                var result = Set<Rate>()
                for (currencyTitle, rateJSON) in json.rates.dictionary ?? [:] {
                    guard let cource = rateJSON.double else { continue }

                    let rate = Rate(base: base, currencyTitle: currencyTitle, rate: cource)
                    result.insert(rate)
                }

                self?.rates.replace(with: result)
            })
    }
    
    func rate(currency: String) -> Double? {
        let normCurrency = currency.lowercased()
        let rates = self.rates.value.collection
        guard var rate = rates.first(where: { $0.currencyTitle.lowercased() == normCurrency })?.rate else {
            return nil
        }
        
        let normUSD = CurrencyType.usd.rawValue.lowercased()
        if normCurrency != normUSD {
            let usdRate = rates.first(where: { $0.currencyTitle.lowercased() == normUSD })?.rate ?? 1.0
            rate /= usdRate
        }
        return rate
    }
    
    private func restoreCache() {
        do {
            if let encodedValue = UserDefaults.standard.data(forKey: cacheKey) {
                let rates = try JSONDecoder().decode(Set<Rate>.self, from: encodedValue)
                self.rates.replace(with: rates)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    private func cacheRates() {
        do {
            let array = Array(rates.value.collection)
            let data = try JSONEncoder().encode(array)
            UserDefaults.standard.setValue(data, forKey: cacheKey)
        } catch {
            debugPrint(error)
        }
    }
}
