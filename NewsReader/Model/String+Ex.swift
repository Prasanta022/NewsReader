//
//  String+Ex.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import Foundation

extension String {

    func getStringFormattedDate(inputFormat: String = "yyyy-MM-dd", outputFormat: String = "E, dd MMM yyyy") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = inputFormat
        guard let date = formatter.date(from: self) else { return "" }
        formatter.dateFormat = outputFormat
        let string = formatter.string(from: date)
        return string
    }
}
