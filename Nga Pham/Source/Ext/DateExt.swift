//
//  DateExt.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

enum FormatType {
    static let fullDate: String = "yyyy/MM/dd"
    static let yearMonthDay: String = "yyyy/MM/dd"
    static let yearMonthDayDayOfWeek: String = "yyyy/MM/dd(EE)"
    static let fullDateProfile: String = "yyyy-MM-dd"
    static let fullTime: String = "yyyy-MM-dd HH:mm:ss"
    static let yearMonth: String = "yyyy-MM"
    static let hourMinutes: String = "HH:mm"
    static let oneHourMinutes: String = "H:mm"
    static let monthDay: String = "MM/dd"
    static let singleMonthDay: String = "M/d"
    static let day: String = " d"
    static let month: String = " M"
    static let year: String = "yyyy"
    static let dateTimeSlash: String = "yyyy/MM/dd HH:mm"
    static let fullTimeSecond: String = "yyyyMMddHHmmss"
    static let dateTimeDash: String = "yyyy-MM-dd HH:mm"
}

enum DaysOfWeek: Int, CaseIterable {
    /// Days of the week.
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday

    func symbols() -> String {
        var calendar = App.gregorianCalendar
        calendar.locale = App.enUSLocale
        let symbols = calendar.shortWeekdaySymbols
        return symbols[self.rawValue - 1]
    }
}

extension Date {
    static let dateFormatter: DateFormatter = {
        let formater: DateFormatter = DateFormatter()
        formater.calendar = App.gregorianCalendar
        return formater
    }()

    static func dateFormatter(withFormat format: String) -> DateFormatter {
        let dateFormatter: DateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = format
        return dateFormatter
    }

    static func fullDateFormatter() -> DateFormatter {
        return Date.dateFormatter(withFormat: FormatType.fullDateProfile)
    }

    static func fullTimeFormatter() -> DateFormatter {
        return Date.dateFormatter(withFormat: FormatType.fullTime)
    }

    func string(withFormat format: String) -> String {
        let dateFormatter: DateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func beginning(of component: Calendar.Component) -> Date {
        if component == .day {
            return App.gregorianCalendar.startOfDay(for: self)
        }

        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]

            case .minute:
                return [.year, .month, .day, .hour, .minute]

            case .hour:
                return [.year, .month, .day, .hour]

            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]

            case .month:
                return [.year, .month]

            case .year:
                return [.year]

            default:
                return []
            }
        }

        guard !components.isEmpty else { return self }
        return App.gregorianCalendar.date(from: App.gregorianCalendar.dateComponents(components, from: self)).unwrapped(or: self)
    }

    func end(of component: Calendar.Component) -> Date {
        switch component {
        case .second:
            var date: Date = adding(.second, value: 1)
            date = App.gregorianCalendar.date(from:
                App.gregorianCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)).unwrapped(or: self)
            date.add(.second, value: -1)
            return date

        case .minute:
            var date: Date = adding(.minute, value: 1)
            let after: Date = App.gregorianCalendar.date(from:
                App.gregorianCalendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)).unwrapped(or: self)
            date = after.adding(.second, value: -1)
            return date

        case .hour:
            var date: Date = adding(.hour, value: 1)
            let after: Date = App.gregorianCalendar.date(from:
                App.gregorianCalendar.dateComponents([.year, .month, .day, .hour], from: date)).unwrapped(or: self)
            date = after.adding(.second, value: -1)
            return date

        case .day:
            var date: Date = adding(.day, value: 1)
            date = App.gregorianCalendar.startOfDay(for: date)
            date.add(.second, value: -1)
            return date

        case .weekday:
            var date: Date = App.gregorianCalendar.date(from: App.gregorianCalendar.dateComponents([.yearForWeekOfYear, .weekOfYear],
                                                                                                   from: self)).unwrapped(or: self)
            date.add(.day, value: 7)
            date.add(.second, value: -1)
            return date

        case .weekOfYear, .weekOfMonth:
            var date: Date = self
            let beginningOfWeek: Date = App.gregorianCalendar.date(from:
                App.gregorianCalendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)).unwrapped(or: self)
            date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
            return date

        case .month:
            var date: Date = adding(.month, value: 1)
            let after: Date = App.gregorianCalendar.date(from:
                App.gregorianCalendar.dateComponents([.year, .month], from: date)).unwrapped(or: self)
            date = after.adding(.second, value: -1)
            return date

        case .year:
            var date: Date = adding(.year, value: 1)
            let after: Date = App.gregorianCalendar.date(from:
                App.gregorianCalendar.dateComponents([.year], from: date)).unwrapped(or: self)
            date = after.adding(.second, value: -1)
            return date

        default:
            return self
        }
    }

    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return App.gregorianCalendar.date(byAdding: component, value: value, to: self).unwrapped(or: self)
    }

    mutating func add(_ component: Calendar.Component, value: Int) {
        if let date: Date = App.gregorianCalendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }

    func isInSameOf(to date: Date, granularity: Calendar.Component = .day) -> Bool {
        return App.gregorianCalendar.compare(self, to: date, toGranularity: granularity) == .orderedSame
    }

    func isLessOrEqual(to date: Date, granularity: Calendar.Component = .day) -> Bool {
        return App.gregorianCalendar.compare(self, to: date, toGranularity: granularity) == .orderedAscending ||
            App.gregorianCalendar.compare(self, to: date, toGranularity: granularity) == .orderedSame
    }

    func isLess(to date: Date, granularity: Calendar.Component = .day) -> Bool {
        return App.gregorianCalendar.compare(self, to: date, toGranularity: granularity) == .orderedAscending
    }

    func isBeforeDate(_ date: Date, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
        let result: ComparisonResult = Calendar.current.compare(self, to: date, toGranularity: granularity)
        return (orEqual ? (result == .orderedSame || result == .orderedAscending) : result == .orderedAscending)
    }

    func isAfterDate(_ refDate: Date, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
        let result: ComparisonResult = Calendar.current.compare(self, to: refDate, toGranularity: granularity)
        return (orEqual ? (result == .orderedSame || result == .orderedDescending) : result == .orderedDescending)
    }

    func isInRange(date startDate: Date, and endDate: Date, orEqual: Bool = true, granularity: Calendar.Component = .day) -> Bool {
        return isAfterDate(startDate, orEqual: orEqual, granularity: granularity) && isBeforeDate(endDate, orEqual: orEqual, granularity: granularity)
    }

    func nextMonth() -> Date {
        return adding(.month, value: 1)
    }

    func previousMonth() -> Date {
        return adding(.month, value: -1)
    }

    func dateComponents(_ components: Set<Calendar.Component>, to end: Date) -> DateComponents {
        return App.gregorianCalendar.dateComponents(components, from: self, to: end)
    }

    var isToday: Bool {
        return App.gregorianCalendar.isDateInToday(self)
    }

    var month: Int {
        get {
            return App.gregorianCalendar.component(.month, from: self)
        }
        set {
            guard let allowedRange: Range<Int> = App.gregorianCalendar.range(of: .month, in: .year, for: self),
                allowedRange.contains(newValue) else { return }
            let currentMonth: Int = App.gregorianCalendar.component(.month, from: self)
            let monthsToAdd: Int = newValue - currentMonth
            if let date: Date = App.gregorianCalendar.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }

    static func minutesConvertToDate(minute: Int) -> Date {
        let hour: Int = minute / 60
        let min: Int = minute % 60
        return Date(hour: hour, minute: min)
    }

    static func secondsConvertToString(seconds: Int, format: String) -> String {
        let minutes: Int = seconds / 60
        let seconds: Int = seconds % 60
        return String(format: format, minutes, seconds)
    }

    static func dateConvertToMinutes(date: Date) -> Int {
        return date.hour * 60 + date.minute
    }

    /**
        Detect the left range side and the right range side of the given date. Ignore all the date in the feature
        `rangeSize`: A mount of date you can get around the given date
        `ignoreFuture`: ignore the date in future
    */
    func createDateRound(rangeSize: Int, ignoreDateInFuture ignoreFuture: Bool) -> [Date] {
        let calendar: Calendar = Calendar.current
        var result: [Date] = [self]

        var buffer: Int = rangeSize
        var leftUnit: Int = 0
        var rightUnit: Int = 0

        while buffer > 0 {
            // Left side
            leftUnit -= 1
            if let newDate = calendar.date(byAdding: .day, value: leftUnit, to: self) {
                result.insert(newDate, at: 0)
            }

            // Right side
            rightUnit += 1
            if let newDate = calendar.date(byAdding: .day, value: rightUnit, to: self) {
                let dateInPass = newDate <= Date()
                let allowAppend = (ignoreFuture && dateInPass) || !ignoreFuture
                if allowAppend {
                    result.append(newDate)
                }
            }

            buffer -= 1
        }

        return result
    }
}

// MARK: - Get components by date
extension Date {

    init(year: Int = Date().year,
         month: Int = Date().month,
         day: Int = Date().day,
         hour: Int = Date().hour,
         minute: Int = Date().minute,
         second: Int = Date().second) {
        var components: DateComponents = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        self = App.gregorianCalendar.date(from: components).unwrapped(or: Date())
    }

    #if os(iOS)
        var daysOfWeek: DaysOfWeek {
            return DaysOfWeek(rawValue: App.gregorianCalendar.component(.weekday, from: self)).unwrapped(or: .sunday)
        }
    #endif

    var weekOfYear: Int {
        return App.gregorianCalendar.component(.weekOfYear, from: self)
    }

    var weekOfMonth: Int {
        return App.gregorianCalendar.component(.weekOfMonth, from: self)
    }

    var year: Int {
        get {
            return App.gregorianCalendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear: Int = App.gregorianCalendar.component(.year, from: self)
            let yearsToAdd: Int = newValue - currentYear
            if let date: Date = App.gregorianCalendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }

    var day: Int {
        get {
            return App.gregorianCalendar.component(.day, from: self)
        }
        set {
            guard let allowedRange: Range<Int> = App.gregorianCalendar.range(of: .day, in: .month, for: self),
                allowedRange.contains(newValue) else { return }
            let currentDay: Int = App.gregorianCalendar.component(.day, from: self)
            let daysToAdd: Int = newValue - currentDay
            if let date: Date = App.gregorianCalendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }
    var hour: Int {
        get {
            return App.gregorianCalendar.component(.hour, from: self)
        }
        set {
            guard let allowedRange: Range<Int> = App.gregorianCalendar.range(of: .hour, in: .day, for: self),
                allowedRange.contains(newValue) else { return }
            let currentHour: Int = App.gregorianCalendar.component(.hour, from: self)
            let hoursToAdd: Int = newValue - currentHour
            if let date: Date = App.gregorianCalendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }
    var minute: Int {
        get {
            return App.gregorianCalendar.component(.minute, from: self)
        }
        set {
            guard let allowedRange: Range<Int> = App.gregorianCalendar.range(of: .minute, in: .hour, for: self),
                allowedRange.contains(newValue) else { return }
            let currentMinutes: Int = App.gregorianCalendar.component(.minute, from: self)
            let minutesToAdd: Int = newValue - currentMinutes
            if let date: Date = App.gregorianCalendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }
    var second: Int {
        get {
            return App.gregorianCalendar.component(.second, from: self)
        }
        set {
            guard let allowedRange: Range<Int> = App.gregorianCalendar.range(of: .second, in: .minute, for: self),
                allowedRange.contains(newValue) else { return }
            let currentSeconds: Int = App.gregorianCalendar.component(.second, from: self)
            let secondsToAdd: Int = newValue - currentSeconds
            if let date: Date = App.gregorianCalendar.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }
}
