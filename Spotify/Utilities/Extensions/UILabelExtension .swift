//
//  UILabelExtension .swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import Foundation
import UIKit

extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        
        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    func startBlink() {
        UIView.animate(withDuration: 0.7, delay:0.0, options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat], animations: { self.alpha = 0 }, completion: nil)
    }
    
    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
    
    func setLabel(title:String,size:CGFloat,color:UIColor) {
        self.text = title
        self.textColor = color
        self.font = UIFont(name: Font.AppRegular, size: size)
    }
    
    func setMediumBoldLabel(title:String,size:CGFloat,color:UIColor) {
        self.text = title
        self.textColor = color
        self.font = UIFont(name: Font.AppMedium, size: size)
    }
    
    func setSemiboldLabel(title:String,size:CGFloat,color:UIColor) {
        self.text = title
        self.textColor = color
        self.font = UIFont(name: Font.AppSemiBold, size: size)
    }
    
    func setBoldLabel(title:String,size:CGFloat,color:UIColor) {
        self.text = title
        self.textColor = color
        self.font = UIFont(name: Font.AppBold, size: size)
    }

    func setAttributeBoldLabel(title:NSMutableAttributedString,size:CGFloat,color:UIColor) {
        self.attributedText = title
        self.textColor = color
    }
    
}
