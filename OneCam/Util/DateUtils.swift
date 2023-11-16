//
//  DateUtils.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import Foundation

extension Date {
    func timestamp() -> Int {
        return Int(self.timeIntervalSince1970)
    }
    
    func toISO8601(withTime: Bool = true) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale.current
        formatter.timeZone = Locale.current.timeZone
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
