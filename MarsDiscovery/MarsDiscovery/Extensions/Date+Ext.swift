//
//  Date+Ext.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 12.07.2024.
//

import Foundation

extension Date {
    func toString(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        
        switch format {
        case .short:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        case .long:
            dateFormatter.dateFormat = "MMMM d, yyyy"
        }
        
        return dateFormatter.string(from: self)
    }
    
    enum DateFormat {
        case short
        case long
    }
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
    
}
