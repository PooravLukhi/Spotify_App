//
//  AppConstant.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import UIKit
import Foundation


struct GlobalVariables {
    
    static let UserDefault = UserDefaults.standard
    
    enum UserDefaultsKeys: String {
        case userPlayListKey = "userPlayListKey"
    }
    
    static let searchTimeTimeInterval = 0.5
    
    static var SCREEN_WIDTH:CGFloat {
        return GlobalFunctions.fixedScreenSize().width
    }

    static var SCREEN_HEIGHT:CGFloat {
        return GlobalFunctions.fixedScreenSize().height
    }
}


struct GlobalFunctions {
    // MARK: - Get full screen size
    static func fixedScreenSize() -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        
        if #available(iOS 13.0, *) {
            // Use windowScene for iOS 13 and later
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let orientation = windowScene.interfaceOrientation
                if orientation.isLandscape {
                    return CGSize(width: screenSize.width, height: screenSize.height)
                }
            }
        } else {
            // Fallback for iOS versions before 13.0
            if UIApplication.shared.statusBarOrientation.isLandscape {
                return CGSize(width: screenSize.width, height: screenSize.height)
            }
        }
        
        return screenSize
    }
    
    // This function converts a string to a URL, returning an optional URL.
    // It returns nil if the string is not a valid URL.
    static func convertStringToUrl(_ stringUrl: String) -> URL? {
        // Ensure the string is a valid URL by creating a URL object
        guard let url = URL(string: stringUrl), UIApplication.shared.canOpenURL(url) else {
            // If the string can't be converted into a URL or it's not a valid URL, return nil
            print("Invalid URL: \(stringUrl)")
            return nil
        }
        
        // Return the valid URL
        return url
    }
    
    static func createAttributedString(string1: String, string2: String, color1: UIColor, color2: UIColor, font1: UIFont, font2: UIFont, includeSpace: Bool = false) -> NSMutableAttributedString {

        // Define attributes for the first string
        let attrs1: [NSAttributedString.Key: Any] = [
            .font: font1,
            .foregroundColor: color1
        ]
        
        // Define attributes for the second string
        let attrs2: [NSAttributedString.Key: Any] = [
            .font: font2,
            .foregroundColor: color2
        ]
        
        // Create the attributed string for the first part
        let attributedString1 = NSMutableAttributedString(string: string1, attributes: attrs1)
        
        // Optionally add a space if the includeSpace parameter is true
        let space = includeSpace ? " " : ""
        
        // Create the attributed string for the second part
        let attributedString2 = NSMutableAttributedString(string: "\(space)\(string2)", attributes: attrs2)
        
        // Append the second string to the first one
        attributedString1.append(attributedString2)

        return attributedString1
    }
    
    static func removeAllUserPlaylistData() {
        // Remove the user playlist data from UserDefaults
        UserDefaults.standard.removeObject(forKey: GlobalVariables.UserDefaultsKeys.userPlayListKey.rawValue)
    }
}
