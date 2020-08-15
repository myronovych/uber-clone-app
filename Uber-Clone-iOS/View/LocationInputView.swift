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
    
    let fromPoint: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let toPoint: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let currentLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Current location"
        textField.backgroundColor = .systemGroupedBackground
        textField.isEnabled = false
        return textField
    }()
    
    let destinationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Destination"
        textField.backgroundColor = .lightGray
        return textField
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
        
        addSubview(currentLocationTextField)
        currentLocationTextField.anchor(top: backButton.bottomAnchor, right: rightAnchor, left: leftAnchor, rightPadding: 30, leftPadding: 40, height: 30)
        
        addSubview(destinationTextField)
        destinationTextField.anchor(top: currentLocationTextField.bottomAnchor, right: rightAnchor, left: leftAnchor, topPadding: 12, rightPadding: 30, leftPadding: 40, height: 30)
        
        addSubview(fromPoint)
        fromPoint.centerY(inView: currentLocationTextField)
        fromPoint.anchor(right: currentLocationTextField.leftAnchor, rightPadding: 10, width: 7, height: 7)
        fromPoint.layer.cornerRadius = 5
        
        addSubview(toPoint)
        toPoint.centerY(inView: destinationTextField)
        toPoint.anchor(width: 8, height: 8)
        toPoint.centerX(inView: fromPoint)
        
        addSubview(line)
        line.anchor(top: fromPoint.bottomAnchor, bottom: toPoint.topAnchor,topPadding: 3, bottomPadding: 3, width: 0.5)
        line.centerX(inView: fromPoint)
        
    }
    
    @objc func dismissLocationInput() {
        delegate?.hideInputView()
    }

}
