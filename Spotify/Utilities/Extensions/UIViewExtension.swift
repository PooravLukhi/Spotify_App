//
//  UIViewExtension.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import Foundation
import UIKit

extension UIView {
    
    func setBorderOnly(_ borderWidth: CGFloat, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    func setRoundedView() {
        self.layer.cornerRadius = (self.frame.height / 2)
        //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
    
    func setRoundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func setCornerRadiusOnly(_ cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
    }
    
    func setCornerRadiusWithBorder(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    func removeShadowWithCornerRadius() {
        layer.sublayers?.first { $0.name == "shadowWithCornerRadius" }?.removeFromSuperlayer()
    }
    
    /**
     Returns a UINib object initialized with the nib file that has the same name as the class.

     - Returns: A UINib object if the nib file exists, otherwise `nil`.

     - Note: This method assumes that the nib file is named the same as the class name.
     */
    class var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    /**
     Loads and returns a UIView object from the nib file that has the same name as the class.

     - Returns: The UIView object if the nib file is loaded successfully, otherwise `nil`.

     - Note: This method assumes that the nib file contains only one top-level view.
     */
    class var viewFromNib: UIView? {
        guard let views = Bundle.main.loadNibNamed(String(describing: self), owner: self, options: nil),
              let view = views.first as? UIView else {
            return nil
        }
        return view
    }
}



protocol ReuseIdentifier {
  static var reuseIdentifier: String { get }
}

extension ReuseIdentifier {
  /// Return a suggested name that can be used as an cellIdentifier.
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UICollectionViewCell: ReuseIdentifier {}
extension UITableViewCell: ReuseIdentifier {}
extension UITableViewHeaderFooterView: ReuseIdentifier {}
