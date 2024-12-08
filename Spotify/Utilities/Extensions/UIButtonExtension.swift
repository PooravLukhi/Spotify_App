//
//  UIButtonExtension.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import Foundation
import UIKit

public extension UIButton {
    
    func underline(text : String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    func shadowOnButtonWithCornerRadius() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 2.0
        self.layer.shadowRadius  = 2.0
        self.layer.shadowOffset  = CGSize(width :1, height :1)
        self.layer.masksToBounds = false
        self.layer.cornerRadius  =  3.0
        self.layer.borderWidth   = 0
    }
    
    func setButton(title:String, size: CGFloat, color: UIColor, bgColor: UIColor) {
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont(name: Font.AppRegular, size: size)
        self.backgroundColor = bgColor
        self.setTitle(title, for: .normal)
    }
    
    func setMediumBoldButton(title: String, size: CGFloat, color: UIColor, bgColor: UIColor) {
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont(name: Font.AppMedium, size: size)
        self.backgroundColor = bgColor
        self.setTitle(title, for: .normal)
    }
    
    func setSemiBoldButton(title: String, size: CGFloat, color: UIColor, bgColor: UIColor) {
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont(name: Font.AppSemiBold, size: size)
        self.backgroundColor = bgColor
        self.setTitle(title, for: .normal)
    }
    
    func setBoldButton(title: String, size: CGFloat, color: UIColor, bgColor: UIColor) {
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont(name: Font.AppBold, size: size)
        self.backgroundColor = bgColor
        self.setTitle(title, for: .normal)
    }
    
    func favAnimation() {
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: {
            [weak self] in
            self!.transform = .identity
        }, completion: nil)
    }
    
    func roundButton(borderWidth:CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func roundButtonWithShadow(bgColor : UIColor) {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
        self.layer.backgroundColor = bgColor.cgColor
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 2.0
        self.layer.shadowRadius  = 2.0
        self.layer.shadowOffset  = CGSize(width :1, height :1)
        self.layer.masksToBounds = false
    }
    
    func ShadowWithCornerRadiusButton(cornerRadius: CGFloat, offset: CGSize, opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shouldRasterize = true
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.masksToBounds = false
    }
}
