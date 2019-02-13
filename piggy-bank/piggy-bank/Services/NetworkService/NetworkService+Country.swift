////
////  NetworkService+Country.swift
////  piggy-bank
////
////  Created by Никита Гайко on 04/02/2019.
////  Copyright © 2019 Nikita Gayko. All rights reserved.
////
//
//import Foundation
//import ReactiveKit
//
//extension NetworkService {
//    
//    func fetchCountries() -> Signal<Void, NoError> {
//        let listPath = "https://restcountries.eu/rest/v2/all?fields=name;currencies;alpha2Code"
//        
//        return requestJSON(url: listPath, method: .get)
//            .map { json -> [Country] in
//                var countryList = [Country]()
//                
//                for countryJSON in json.array ?? [] {
//                    let country = Country(context: self.coreDataManager.context)
//                    country.alpha2Code = countryJSON.alpha2Code.string
//                    country.name = countryJSON.name.string
//                    
//                    let currency = Currency(context: self.coreDataManager.context)
//                    let currencyJSON = countryJSON.currencies.array?.first
//                    currency.code = currencyJSON?.code.string
//                    currency.name = currencyJSON?.name.string
//                    currency.symbol = currencyJSON?.symbol.string
//                    
//                    country.currency = currency
//                    countryList.append(country)
//                }
//                
//                return countryList
//            }
//            .suppressError(logging: true)
//            .flatMapConcat { [weak self] countries -> Signal<Void, NoError> in
//                guard let `self` = self else { return .completed() }
//                
//                var loadFlags: Signal<Void, NoError> = .completed()
//                
//                for country in countries {
//                    loadFlags = loadFlags.concat(with: self.fetchCountryFlag(country: country))
//                }
//                
//                return loadFlags
//        }
//    }
//    
//    private func fetchCountryFlag(country: Country) -> Signal<Void, NoError> {
//        guard let alpha2Code = country.alpha2Code else {
//            return .completed()
//        }
//        let path = "https://www.countryflags.io/\(alpha2Code)/flat/64.png"
//        
//        return requestData(url: path, method: .get)
//            .doOn(next: { (data) in
//                country.flag = data
//            })
//            .suppressError(logging: true)
//            .map { _ in }
//    }
//}
