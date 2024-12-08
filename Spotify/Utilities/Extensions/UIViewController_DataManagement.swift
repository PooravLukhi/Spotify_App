//
//  UIViewController_DataManagement.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import Foundation
import UIKit
import KRProgressHUD

extension UIViewController {
    public func loadViewController(Storyboard:String,ViewController:String) -> UIViewController {
        let storyBoard = UIStoryboard(name: Storyboard, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: ViewController)
        return vc
    }
    
    func showLoader(withStatus status: String) {
        KRProgressHUD
            .showOn(self)
            .show(withMessage: status)
    }
    
    func hideLoader() {
        KRProgressHUD.dismiss()
    }
    
    func showError(withStatus status: String, title: String? = Localization.Common.Message.error) {
        let action = UIAlertAction(title: Localization.Common.Action.ok, style: .default, handler: { _ in })
        presentAlert(title: title, message: status, actionBtns: [action])
    }
    
    func showSuccess(withStatus status: String) {
        //KRProgressHUD.showSuccess(withMessage: status)
        let delay = DispatchTime.now() + (1/4)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            KRProgressHUD
                .showOn(self)
                .set(duration: 1.5)
                .showSuccess(withMessage: status)
        }
    }
    
    //MARK: - Alert Functions
    func presentAlert(title: String? = "", message: String?, preferredStyle: UIAlertController.Style = .alert, actionBtns: [UIAlertAction], dismissOnTap: Bool = false) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for btn in actionBtns {
            alert.addAction(btn)
        }
        
        if (dismissOnTap) {
            self.present(alert, animated: true) {
                alert.view.superview?.isUserInteractionEnabled = true
                alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapOutsideAlertController)))
            }
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func tapOutsideAlertController() {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
