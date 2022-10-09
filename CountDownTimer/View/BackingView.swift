//
//  BackingView.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/10/09.
//

import UIKit
class BackingView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = 6
        layer.borderWidth = 1
    }
}
