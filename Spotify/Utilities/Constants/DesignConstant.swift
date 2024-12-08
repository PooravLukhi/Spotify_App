//
//  DesignConstant.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import UIKit
import Foundation

struct Font {
    /// Use this font in app everywhere
    static let AppRegular = CircularStdRegular
    static let AppMedium = CircularStdMedium
    static let AppSemiBold = CircularStdSemiBold
    static let AppBold = CircularStdBold

    ///Circular Std Fonts
    static let CircularStdRegular = "CircularStd-Black"
    static let CircularStdMedium = "CircularStd-Medium"
    static let CircularStdSemiBold = "CircularStd-Book"
    static let CircularStdBold = "CircularStd-Bold"
}


struct Colors {
    static let CustomGray = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
    static let White = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let Black = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let Clear = UIColor.clear
    
    static let GrayText = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.00)
    
    static let CustomGreen = UIColor(red: 0.12, green: 0.84, blue: 0.38, alpha: 1.00)
    
    static let CustomBackgroundGray = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.00)

}


struct AppImageName {
    ///Dashboard Screen
    static let ic_home_selected = UIImage(named: "ic_home_selected")
    static let ic_home = UIImage(named: "ic_home")

    static let ic_library_selected = UIImage(named: "ic_library_selected")
    static let ic_library = UIImage(named: "ic_library")

    static let ic_search_selected = UIImage(named: "ic_search_selected")
    static let ic_search = UIImage(named: "ic_search")
    
    ///Library Screen
    static let ic_user_profile = UIImage(named: "ic_user_profile")
    static let ic_add = UIImage(named: "ic_add")
    static let ic_grid = UIImage(named: "ic_grid")
    static let ic_list = UIImage(named: "ic_list")
    static let ic_loader = UIImage(named: "ic_loader")
    static let ic_music_album = UIImage(named: "ic_music_album")
    
    static let ic_back = UIImage(named: "ic_back")
}

struct FontSize {
    /// Font sizes used throughout the app
    static let extraSmall: Double = 5.0
    static let verySmall: Double = 6.0
    static let smaller: Double = 7.0
    static let small: Double = 8.0
    static let mediumSmall: Double = 9.0
    static let medium: Double = 10.0
    static let mediumLarge: Double = 11.0
    static let large: Double = 12.0
    static let larger: Double = 13.0
    static let extraLarge: Double = 14.0
    static let headline: Double = 15.0
    static let subtitle: Double = 16.0
    static let body: Double = 17.0
    static let title: Double = 18.0
    static let displaySmall: Double = 19.0
    static let displayMedium: Double = 20.0
    static let displayLarge: Double = 21.0
    static let huge: Double = 22.0
    static let extraHuge: Double = 23.0
    static let massive: Double = 24.0
    static let extraMassive: Double = 25.0
}

struct CornerRadiusSize {
    static let C05 = 5.0
    static let C10 = 10.0
    static let C15 = 15.0
    static let C20 = 20.0
}

struct BorderSize {
    static let B00 = 0.0
    static let B01 = 1.0
    static let B02 = 2.0
    static let B03 = 3.0
    static let B04 = 4.0
    static let B05 = 5.0
}

extension UIFont {
    
    // General method to return a theme font with a fallback to system font if the custom font isn't available
    static func themeFont(named fontName: String, size: CGFloat) -> UIFont {
        if let font = UIFont(name: fontName, size: size) {
            return font
        } else {
            // Log an error or return the system font as a fallback
            print("Font \(fontName) not found. Falling back to system font.")
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    // Specific theme fonts with named font constants
    static func themeRegularFont(of size: CGFloat) -> UIFont {
        return themeFont(named: Font.AppRegular, size: size)
    }
    
    static func themeMediumFont(of size: CGFloat) -> UIFont {
        return themeFont(named: Font.AppMedium, size: size)
    }
    
    static func themeSemiboldFont(of size: CGFloat) -> UIFont {
        return themeFont(named: Font.AppSemiBold, size: size)
    }
    
    static func themeBoldFont(of size: CGFloat) -> UIFont {
        return themeFont(named: Font.AppBold, size: size)
    }
}
