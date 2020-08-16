//
//  DestinationTableViewCell.swift
//  Uber-Clone-iOS
//
//  Created by rs on 16.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class DestinationTableViewCell: UITableViewCell {
    
    static let reuseId = "destinationCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
