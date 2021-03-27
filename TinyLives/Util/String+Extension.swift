//
//  String+Extension.swift
//  TinyLives
//
//  Created by Jacky Wong on 27/3/21.
//

import Foundation

extension String {
    
    static let toLocalDate: DateFormatter = {        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter
    }()
    
    var toLocalDate: Date? {
        return String.toLocalDate.date(from: self)
    }

}
