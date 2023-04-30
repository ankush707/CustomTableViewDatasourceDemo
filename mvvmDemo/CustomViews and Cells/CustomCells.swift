//
//  CustomCells.swift
//  mvvmDemo
//
//  Created by Ankush on 21/03/23.
//

import Foundation
import UIKit


class CustomView: UIView {

    public var myLabel: UILabel?
    
    var source: Source? {
        didSet {
            if let topic = source?.annotations?.topic {
                if let subTopic = source?.annotations?.subtopic {
                    self.myLabel?.text = "\("Topic".uppercased()): \(topic) \n\("SubTopic".uppercased()): \(subTopic)"
                }
            }
        }
    }
    
    var place: NewPlacesModel? {
        didSet {
            if let country = place?.country {
                self.myLabel?.text = "\("Country".uppercased()) : \(country)"
            }
        }
    }
    
    override init(frame: CGRect) {

        super.init(frame:frame)

        myLabel = UILabel()
        myLabel?.frame = CGRect.init(x: 20, y: 5, width: self.frame.width-10, height: 60)
        myLabel?.text = "Notification Times"
        myLabel?.font = UIFont(name: "Impact", size: 20.0)
        myLabel?.textColor = .black
        myLabel?.numberOfLines = 2
        addSubview(myLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TableCell : UITableViewCell {
    @IBOutlet private var txtLbl: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var source:Datum? {
        didSet {
            if let pop = source?.population {
                if let nation = source?.nation {
                    if let year = source?.year {
                        self.txtLbl.text = "\(nation) has population of \(pop) in year \(year)."
                    }
                }
            }
        }
    }
    
    var viewModelData:Place? {
        didSet {
            if let state = viewModelData?.state {
                if let place = viewModelData?.placeName {
                    if let long = viewModelData?.longitude {
                        if let lat = viewModelData?.latitude {
                            self.txtLbl.text = "\(place) of state(\(state)) has longitude of : \(long) and latitude of \(lat)"
                        }
                    }
                }
            }
        }
    }
    
}
