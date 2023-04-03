//
//  Date+Ext.swift
//  github-followers
//
//  Created by Sanket Pimple on 4/2/23.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"        
        return dateFormatter.string(from: self)
    }
}
