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
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Khreschatyk 1"
        label.font.withSize(14)
        return label
    }()

    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Khreschatyk 1, Kyiv, Ukraine"
        label.font.withSize(14)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let stack = UIStackView(arrangedSubviews: [mainLabel, secondaryLabel])
        stack.axis = .vertical
        stack.spacing = 4
        addSubview(stack)
        stack.anchor(left: leftAnchor, leftPadding: 12)
        stack.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
