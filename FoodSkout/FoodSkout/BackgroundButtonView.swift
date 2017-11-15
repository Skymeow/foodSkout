//
//  RevealViewController.swift
//  FoodSkout
//
//  Created by Sky Xu on 11/14/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

var backgroundButtonView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red:0.09, green:0.15, blue:0.22, alpha:1.0)
    return view
}()

extension UIView {
    func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
    func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.pin(to: stackView)
    }
    

