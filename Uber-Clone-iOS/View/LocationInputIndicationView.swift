//
//  LocationInputIndicationView.swift
//  Uber-Clone-iOS
//
//  Created by rs on 14.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

protocol LocationInputIndicationViewDelegate: class {
    func presentLocationInputView()
}

class LocationInputIndicationView: UIView {
    
    weak var delegate: LocationInputIndicationViewDelegate?
    
    let indicatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let whereToLabel: UILabel = {
        let label = UILabel()
        label.text  = "Where to?"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addShadow()
        
        
        addSubview(indicatorView)
        addSubview(whereToLabel)
        
        indicatorView.anchor(left: leftAnchor, leftPadding: 8, width: 6, height: 6)
        indicatorView.centerY(inView: self)
        
        whereToLabel.anchor(left: indicatorView.rightAnchor, leftPadding: 16)
        whereToLabel.centerY(inView: self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentLocationInputView))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func presentLocationInputView() {
        delegate?.presentLocationInputView()
    }
    
}
