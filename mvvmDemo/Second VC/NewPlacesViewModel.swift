//
//  ViewModel.swift
//  mvvmDemo
//
//  Created by Ankush on 11/01/23.
//

import Foundation

class NewPlacesViewModel: NSObject {
    
    init(request: APICallProtocol) {
        super.init()
        
        self.getAPIData(request: request)
    }
    
    func getAPIData(request: APICallProtocol) {
        DispatchQueue.global().async {
            let url = "https://api.zippopotam.us/us/33162"
            
            request.genericApiCall(urlStr: url, type: APICallType.GET) { [weak self] modelData in
                self?.placesData = modelData
            }
        }
    }
    
    private(set) var placesData : NewPlacesModel? {
        didSet {
            self.bindNewPlacesViewModelViewModelToController()
        }
    }
    
    var bindNewPlacesViewModelViewModelToController : (() -> ()) = {}
}

