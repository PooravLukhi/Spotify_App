//
//  StringExtension .swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import Foundation

extension String {
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func blank() -> Bool {
        let trimmed = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    
    public var isBackSpaceKeyPressed: Bool {
        // Check for Backspace key pressed
        let  char = self.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {
            return true
        }
        return false
    }
}
