//
//  SecondVC.swift
//  mvvmDemo
//
//  Created by Ankush on 11/01/23.
//

import UIKit

class SecondVC: UIViewController {
    var counter = 0
    var timer = Timer()
    
    @IBOutlet weak var tblVw: UITableView!
    private var newPlacesViewModel = NewPlacesViewModel(request: GenericAPIService())
    
    private var tableDelegate: TableViewDelegate<CustomView, NewPlacesModel>!
    private var tableDataSource : TableViewDataSource<TableCell, Place, NewPlacesModel >!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newPlacesViewModel.bindNewPlacesViewModelViewModelToController = { [weak self] in
            DispatchQueue.main.async {
                self?.updateDataSource()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    @IBAction func backButton(_ sender: Any) {
        timer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        counter += 1
        print(counter)
    }
    
    deinit {
        
        print("SecondVC is deinitialized")
    }
    
    func updateDataSource() {
        let cellIdentifier = "TableCell"
        
        var arrSections : [NewPlacesModel] = []
        arrSections.append(self.newPlacesViewModel.placesData!)
        
        self.tableDelegate = TableViewDelegate(cellIdentifier: cellIdentifier, heightForCell: nil, sectionItems: arrSections, heightForSection: 56.0 , configureHeader: { viewX, data in
            
            viewX.place = data
            
        }, didSelect: { data in
            let alert = UIAlertController.init(title: nil, message: data.postCode, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        })
        
        self.tableDataSource = TableViewDataSource(cellIdentifier: cellIdentifier, cellItems: self.newPlacesViewModel.placesData?.places, sectionItems: arrSections ,configureCell: { (tblCell, viewModelData) in
            
            tblCell.viewModelData = viewModelData
            
        })
        
        
        DispatchQueue.main.async {
            self.tblVw.dataSource = self.tableDataSource
            self.tblVw.delegate = self.tableDelegate
            self.tblVw.reloadData()
        }
    }
    
}


