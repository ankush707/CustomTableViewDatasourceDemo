//
//  FirstVC.swift
//  mvvmDemo
//
//  Created by Ankush on 11/01/23.
//

import UIKit

class FirstVC: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    private var placesViewModel = PlacesViewModel(delegate: GenericAPIService())
    
    private var tableDelegate: TableViewDelegate<CustomView, Source>!
    private var tableDataSource : TableViewDataSource<TableCell, Datum,Source >!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        placesViewModel.bindPlacesViewModelViewModelToController = { [weak self] in
            DispatchQueue.main.async {
                self?.updateDataSource()
            }
        }
        
    }
    
    @IBAction func moveToNextAction(_ sender: Any) {
        
        let vc: SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension FirstVC {
    
    func updateDataSource() {
        let cellIdentifier = "TableCell"
        
        
        self.tableDelegate = TableViewDelegate(cellIdentifier: cellIdentifier, heightForCell: nil, sectionItems: self.placesViewModel.placesData?.source, heightForSection: 76.0 , configureHeader: { viewX, dataObj in
            viewX.source = dataObj
        }, didSelect: { dataObj in
            
            let alert = UIAlertController.init(title: nil, message: dataObj.name, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        })
        
        self.tableDataSource = TableViewDataSource(cellIdentifier: cellIdentifier, cellItems: self.placesViewModel.placesData?.data, sectionItems: self.placesViewModel.placesData?.source ,configureCell: { (tblCell, viewModelData) in
            
            tblCell.source = viewModelData
        })
        
        DispatchQueue.main.async {
            self.tblVw.dataSource = self.tableDataSource
            self.tblVw.delegate = self.tableDelegate
            self.tblVw.reloadData()
        }
    }
}

