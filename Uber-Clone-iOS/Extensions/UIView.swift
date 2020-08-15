//
//  UIView.swift
//  Uber-Clone-iOS
//
//  Created by rs on 13.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                topPadding: CGFloat = 0,
                rightPadding: CGFloat = 0,
                bottomPadding: CGFloat = 0,
                leftPadding: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func inputContainerView(image: UIImage, textField: UITextField? = nil, segmentedControl: UISegmentedControl? = nil) -> UIView {
        let view = UIView()
        let imageView = UIImageView(image: image)
        let spacer = UIView()
        
        view.addSubview(imageView)
        
        view.addSubview(spacer)
        
        imageView.anchor(left: view.leftAnchor, leftPadding: 8, width: 25, height: 25)
        
        if let textField = textField {
            view.addSubview(textField)
            textField.anchor(right: view.rightAnchor, left: imageView.rightAnchor, leftPadding: 8)
            textField.centerY(inView: view)
            
            imageView.centerY(inView: view)
        }
        
        if let segmentedControl = segmentedControl {
            view.addSubview(segmentedControl)
            segmentedControl.anchor(top: imageView.bottomAnchor, right: view.rightAnchor, left: view.leftAnchor, topPadding: 8)
            
        }
        
        spacer.backgroundColor = .white
        spacer.anchor(right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, topPadding: 8, height: 0.75)
        return view
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.7
    }
}
