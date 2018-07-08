//
//  HistoryViewModel.swift
//  Shop
//
//  Created by Anton Filipović on 08/07/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation

class HistoryViewModel {
    let restAPI: CombinedMovieAPI
    var items : [Purchase]!
    
    init(service: CombinedMovieAPI) {
        self.restAPI = service
        self.items = [Purchase]()
    }
    
    func fetchItems(){
        restAPI.fetchHistory(completion:{ [weak self] (items) in
            self?.items = items
        })
    }
    
    func getItem(at index: Int) -> Purchase? {
        return items?[index]
    }
    
    func numberOfItems() -> Int {
        return items?.count ?? 0
    }
}
