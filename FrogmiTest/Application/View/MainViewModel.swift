//
//  MainViewModel.swift
//  FrogmiTest
//
//  Created by Jimmy Hernandez on 23-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate {
    func reloadData()
    func endData()
}


class MainViewModel {
    
    var delegate: MainViewModelDelegate?
    var arrStore = [Store]()
    
    var numberOfitems: Int {
        return arrStore.count
    }
    
    func getListStore(per_page: Int){
        NetworkManager.shared.getListStore(per_page: per_page).then({
//            print("STORE")
//            print($0)
            self.arrStore = $0
            self.delegate?.reloadData()
        }).catch({
            self.delegate?.endData()
            print("STORE")
            print($0)
        })
    }
    
    
}
