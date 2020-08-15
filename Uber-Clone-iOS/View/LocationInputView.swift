//
//  LocationInputView.swift
//  Uber-Clone-iOS
//
//  Created by rs on 15.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

protocol LocationInpuViewDelegate: class {
    func hideInputView()
}

class LocationInputView: UIView {
    
    weak var delegate: LocationInpuViewDelegate?
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal) , for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        addShadow()
        
        addSubview(backButton)
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, topPadding: 12, leftPadding: 12, width: 25, height: 25)
        backButton.addTarget(self, action: #selector(dismissLocationInput), for: .touchUpInside)
        }
    
    @objc func dismissLocationInput() {
        delegate?.hideInputView()
    }

}
