//
//  ViewModel.swift
//  mvvmDemo
//
//  Created by Ankush on 11/01/23.
//

import Foundation

class PlacesViewModel: NSObject {
    
    
    init(delegate: APICallProtocol) {
        super.init()
        self.getAPIData(delegate: delegate)
    }
    
    func getAPIData(delegate: APICallProtocol) {
        
        DispatchQueue.global().async {
            let url = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
            
            delegate.genericApiCall(urlStr: url, type: APICallType.GET) { [weak self] modelData in
                self?.placesData = modelData
            }
        }
    }
    
    private(set) var placesData : PlacesModel? {
        didSet {
            self.bindPlacesViewModelViewModelToController()
        }
    }
    
    var bindPlacesViewModelViewModelToController : (() -> ()) = {}
}

