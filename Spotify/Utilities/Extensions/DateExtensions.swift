//
//  DateExtensions.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import Foundation

public extension Date {
    //Returns if a date is over 18 years ago
    func isOver18Years() -> Bool {
        var comp = (Calendar.current as NSCalendar).components(NSCalendar.Unit.month.union(.day).union(.year), from: Date())
        guard comp.year != nil && comp.day != nil else { return false }
        comp.year! -= 18
        comp.day! += 1
        if let date = Calendar.current.date(from: comp) {
            if self.compare(date) != ComparisonResult.orderedAscending {
                return false
            }
        }
        return true
    }
    
    func toString(format: String = "dd-MM-yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
