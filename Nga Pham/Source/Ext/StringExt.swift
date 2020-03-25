//
//  StringExt.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/17/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

extension String {

    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

    func toData(using endcoding: String.Encoding = .utf8) -> Data {
        guard let data: Data = self.data(using: endcoding) else {
            fatalError("\(self) has not converted to data")
        }
        return data
    }

    func convertFileToData() -> Data {
        guard let path = Bundle.main.path(forResource: self, ofType: "json") else {
            fatalError("Can not convert to path for \(self).json")
        }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Can not get data from \(self).json")
        }
        return data
    }

    func readFileJSON() -> Data? {
        guard let path = Bundle.main.path(forResource: self, ofType: "json") else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        let data = try? Data(contentsOf: url)
        return data
    }

    func fullDate(format: String = FormatType.fullDate) -> String {
        let dateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = format
        guard let date: Date = dateFormatter.date(from: self) else { return "" }
        return date.string(withFormat: format)
    }

    func date(format: String) -> Date? {
        let dateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

    func firstCharacterUppercased() -> String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}

extension String {

    init(double: Double?) {
        var text = ""
        if let double = double {
            text = "\(double)"
        }
        self = text
    }

    var int: Int? {
        return Int(self)
    }

    func float(locale: Locale = .current) -> Float? {
        let formatter = NumberFormatter.formatter
        formatter.locale = locale
        return formatter.number(from: self)?.floatValue
    }

    func double(locale: Locale = .current) -> Double? {
        let formatter = NumberFormatter.formatter
        formatter.locale = locale
        return formatter.number(from: self)?.doubleValue
    }

    func cgFloat(locale: Locale = .current) -> CGFloat? {
        let formatter = NumberFormatter.formatter
        formatter.locale = locale
        return formatter.number(from: self) as? CGFloat
    }

    var bool: Bool {
        switch self {
        case "0":
            return false
        case "1":
            return true
        default: return false
        }
    }

    var url: URL? {
        return URL(string: self)
    }
}

extension String {

    func substring(from: Int?, to: Int?) -> String {
        guard let start = from, start < self.count,
            let end = to, end >= 0,
            end - start >= 0
            else {
                return ""
        }

        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }

        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }

        return String(self[startIndex ..< endIndex])
    }

    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }

        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }

        return self.substring(from: from, to: end)
    }

    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }

        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }

        return self.substring(from: start, to: to)
    }
}

extension String {

    func replace(regex: String, with char: String) -> String {
        do {
            var result = self
            let regex = try NSRegularExpression(pattern: regex)
            let matches = regex.matches(in: result,
                                        range: NSRange(result.startIndex..., in: result))
            let replaceStrings = matches.map { (match) -> String in
                guard let range = Range(match.range, in: result) else {
                    return ""
                }
                return String(result[range])
            }
            for replaceString in replaceStrings {
                if let range = result.range(of: replaceString) {
                    result.replaceSubrange(range, with: char)
                }
            }
            return result
        } catch {
            return ""
        }
    }

    func replace(pattern: String, withTemplate template: String) -> String? {
        if let regex: NSRegularExpression = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            let range: NSRange = NSRange(location: 0, length: count)
            return regex.stringByReplacingMatches(in: self, options: .reportProgress, range: range, withTemplate: template)
        }
        return nil
    }

    // https://stackoverflow.com/a/54900097/4488252
    func matches(for regex: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: [.caseInsensitive]) else { return [] }
        let matches = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
        return matches.compactMap { match in
            guard let range = Range(match.range, in: self) else { return nil }
            return String(self[range])
        }
    }
}

extension String {

    func index(of string: Self) -> Int? {
        guard let index = range(of: string)?.lowerBound else { return nil }
        return distance(from: startIndex, to: index)
    }

    func indices(of string: Self) -> [Int] {
        var indices: [Int] = []
        var searchIndex: Index = startIndex
        while searchIndex < endIndex, let range: Range = range(of: string, range: searchIndex..<endIndex), !range.isEmpty {
            let index: Int = distance(from: startIndex, to: range.lowerBound)
            indices.append(index)
            searchIndex = range.upperBound
        }
        return indices
    }

}

extension String {

    func contentWidth(font: UIFont) -> CGFloat {
        let size = (self as NSString).size(withAttributes: [.font: font])
        return size.width
    }
}

extension String {
    func replacingWithHtmlTags() -> String {
        var string: String = self.replacingOccurrences(of: "<font color=\"", with: "<span style=\"color:")
        string = string.replacingOccurrences(of: "</font>", with: "</span>")
        string = string.replacingOccurrences(of: "\n", with: "<br>")
        return string
    }

    func htmlAttributed(fontName: String? = nil, size: CGFloat, color: UIColor = .black) -> NSAttributedString? {
        let this: String = replacingWithHtmlTags()
        var family: String = "HiraginoSans-W3"
        if let fontName: String = fontName {
            family = fontName
        }
        var htmlCSSString: String = "<style>html *{"
        htmlCSSString += "font-size: \(size)pt !important;"
        htmlCSSString += "color: #\(color.hexString);"
        htmlCSSString += "font-family: \(family), \(family) !important;"
        htmlCSSString += "}</style> \(this)"
        guard let data: Data = htmlCSSString.data(using: String.Encoding.utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        let attributed: NSAttributedString? = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        return attributed
    }
}
