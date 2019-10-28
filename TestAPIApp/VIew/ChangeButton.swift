//
//  ChangeButton.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 17.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit


@IBDesignable
class ChangeButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    @IBInspectable var backgroundColorr: UIColor = UIColor() {
        didSet{
            self.backgroundColor = backgroundColorr
        }
    }
    
    
    private func setup(){
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 19)
        
        layer.cornerRadius = 15
        
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.masksToBounds = false
    }
    // Mark: анимация нажатия
    func pressButton(){
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
}
