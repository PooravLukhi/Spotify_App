//
//  UITextFieldExtension.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import Foundation
import UIKit


var maxLengthKey: UInt8 = 0
var originalDelegateKey: UInt8 = 1
var indexPathKey: UInt8 = 0
var isUpdatingText: Bool = false


//MARK: - UITEXTFIELD
extension UITextField {
    
    func setTextfield(placeholder:String,size:CGFloat,color:UIColor) {
        self.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.placeholder = placeholder
        self.textColor = color
        self.font = UIFont(name: Font.AppRegular, size: size)
    }
    
    func setMediumTextfield(placeholder:String,size:CGFloat,color:UIColor) {
        self.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.placeholder = placeholder
        self.textColor = color
        self.font = UIFont(name: Font.AppMedium, size: size)
    }
    
    func setSemiboldTextfield(placeholder:String,size:CGFloat,color:UIColor) {
        self.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.placeholder = placeholder
        self.textColor = color
        self.font = UIFont(name: Font.AppSemiBold, size: size)
    }
    
    func setBoldTextfield(placeholder:String,size:CGFloat,color:UIColor) {
        self.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        self.placeholder = placeholder
        self.textColor = color
        self.font = UIFont(name: Font.AppBold, size: size)
    }
}
