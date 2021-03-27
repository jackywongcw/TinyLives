//
//  TimeInterval+extension.swift
//  TinyLives
//
//  Created by Jacky Wong on 27/3/21.
//

import Foundation

extension TimeInterval {
    func toLocalDDMMYYYYString() -> String {
        
        let date = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func toLocalDate() -> Date {
        let date = Date(timeIntervalSince1970: self)
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: date))
        let localDate = Date(timeInterval: seconds, since: date)
        return localDate
    }
}

