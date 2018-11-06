//
//  Date.swift
//  Capital Social
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import Foundation


public extension Date {
    
    //MARK:- Computing static variables
    static var now: Date {
        let now = Date()
        let dateFormatter = DateFormatter()
        let dateFormat = "yyyy.MM.dd HH:mm:ss"
        
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = dateFormat
        let dateStr = dateFormatter.string(from: now)
        
        // UTC is the default time zone
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: dateStr)!
    }
    
    //MARK:- Computing variables
    var year: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        return calendar.component(.year, from: self)
    }
    
    var month: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        return calendar.component(.month, from: self)
    }
    
    var day: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        return calendar.component(.day, from: self)
    }
    
    var hours: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        return calendar.component(.hour, from: self)
    }
    
    var minutes: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        return calendar.component(.minute, from: self)
    }
    
    //MARK:- Static methdos
    static func newDate(fromYear year: Int, month: Int, day: Int) -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        return calendar.date(from: dateComponents)
    }
    
    static func fromDateFormat(date: String, format: String, andTimeZone timeZone: String = "UTC") -> Date? {
        let formatter = DateFormatter()
        let timezone = TimeZone(abbreviation: timeZone)
        formatter.timeZone = timezone
        formatter.dateFormat = format
        
        if let date = formatter.date(from: date) {
            return date
        }
        
        return nil
    }
    
    
    //MARK:- Instance methods
    func getDateComponents() -> (year: Int, month: Int, day: Int) {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return (year, month, day)
    }
    
    /// Returns the corresponding **Date representation** in milliseconds
    public var toMillisAsStr: String {
        return String(Int64(timeIntervalSince1970 * 1000))
    }
    
    func toFormat(_ format: String, withTimeZoneID id: String? = nil) -> String{
        let dateFormatter = DateFormatter()
        
        if let ab = id {
            let timeZone = TimeZone(abbreviation: ab)
            dateFormatter.timeZone = timeZone
        } else {
            let timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.timeZone = timeZone
        }
        
        dateFormatter.dateFormat = format
        
        return String(dateFormatter.string(from: self))
    }
    
    /// Compares two dates by day
    func isGreaterThan(date: Date) -> Bool{
        return self.compare(date) == .orderedDescending
    }
    
    /// Compares two dates by day
    func isGreaterOrEqualThan(date: Date) -> Bool{
        return self.compare(date) == .orderedDescending || self.compare(date) == .orderedSame
    }
    
    /// Compares two dates by day
    func isLessOrEqualThan(date: Date) -> Bool{
        return  self.compare(date) == .orderedAscending || self.compare(date) == .orderedSame
    }
    
    /// Compares two dates by day
    func isLessThan(date: Date) -> Bool{
        return  self.compare(date) == .orderedAscending
    }
    
    /// Modifies the hours, minutes and seconds of this Date
    /// - return: A new NSDate with the hours, minutes & seconds specified
    func dateWith(hour: Int, minute: Int, seconds: Int) -> Date{
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        var components: DateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = hour
        components.minute = minute
        components.second = seconds
        
        return calendar.date(from: components)!
        
    }
    
    func addDays(daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func add(minutes: Int) -> Date {
        let secondsInMinutes: TimeInterval = Double(minutes) * 60
        let dateWithMinutesAdded: Date = self.addingTimeInterval(secondsInMinutes)
        return dateWithMinutesAdded
    }
    
    func add(hours: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hours) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        return dateWithHoursAdded
    }
    
    
    //MARK:- Date formats
    struct CSFormat {
        static let standard = "yyyy-MM-dd HH:mm:ss"
        static let custom = "dd/MM/yyyy / HH:mm"
    }
}
