//
//  AddButton.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 17.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit




@IBDesignable
class AddButton: UIButton {

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
    
    
    @IBInspectable var size: CGFloat = 0{
        didSet{
            self.frame.size = CGSize(width: size * 2.5, height: size)
            self.layer.cornerRadius = size / 2
        }
    }
    
    
    private func setup(){
        setTitleColor(.white, for: .normal)
        setTitle("Добавить", for: .normal)
        titleLabel?.font = UIFont(name: "ArialMT", size: 22)
        
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
    
    //Mark: анимация возвращения кнопки
    func openButton(){
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
            self.frame.origin.y = self.frame.origin.y - 150
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    // Mark: Анимация свертывания кнопки
    func closeButton(){
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0.5
            self.frame.origin.y = self.frame.origin.y + 150
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
    }

}
