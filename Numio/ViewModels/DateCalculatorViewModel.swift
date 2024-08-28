//
//  DateCalculatorViewModel.swift
//  Numio
//
//  Created by Sasha Jaroshevskii on 29.08.2024.
//

import Combine
import SwiftUI

final class DateCalculatorViewModel: ObservableObject {
    private static let calendar = Calendar.current
    private static let dateComponents: Set<Calendar.Component> = [.minute, .hour, .day]
    
    @Published var dateRange: DateRange
    @Published var difference: DateComponents
    @Published var formatedDifference: String
    
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        let curentDataRange = DateRange(beginDate: Date(), endDate: Date())
        let curentDifference = Self.calculateDifference(for: curentDataRange)
        let curentFormatedDifference = Self.formatDifference(for: curentDifference)
        
        self.dateRange = curentDataRange
        self.difference = curentDifference
        self.formatedDifference = curentFormatedDifference
        
        attachSubscriber()
    }
    
    func setCurentDateForBeginDate() {
        dateRange.beginDate = Date()
    }
    
    func setCurentDateForEndDate() {
        dateRange.endDate = Date()
    }
    
    func setZeroDateForBeginDate() {
        dateRange.beginDate = zeroDate(for: dateRange.beginDate)
    }
    
    func setZeroDateForEndDate() {
        dateRange.endDate = zeroDate(for: dateRange.endDate)
    }
}

// MARK: - Init
extension DateCalculatorViewModel {
    private func attachSubscriber() {
        $dateRange.sink(receiveValue: handleDateRange).store(in: &cancelables)
        $difference.sink(receiveValue: handleDifference).store(in: &cancelables)
    }
}

// MARK: - Handlers
extension DateCalculatorViewModel {
    private func handleDateRange(_ dateRange: DateRange) {
        difference = Self.calculateDifference(for: dateRange)
    }
    
    private func handleDifference(_ difference: DateComponents) {
        formatedDifference = Self.formatDifference(for: difference)
    }
}

// MARK: - Helpers
extension DateCalculatorViewModel {
    private static func calculateDifference(for dateRange: DateRange) -> DateComponents {
        return calendar.dateComponents(dateComponents, from: dateRange.beginDate, to: dateRange.endDate)
    }
    
    private static func formatDifference(for dateComponents: DateComponents) -> String {
        let days = dateComponents.day ?? 0
        let hours = dateComponents.hour ?? 0
        let minutes = dateComponents.minute ?? 0
        
        var components: [String] = []
        if days > 0 { components.append("\(days) day\(days > 1 ? "s" : "")") }
        if hours > 0 { components.append("\(hours) hour\(hours > 1 ? "s" : "")") }
        components.append("\(minutes) minute\(minutes > 1 ? "s" : "")")
        
        return components.joined(separator: " ")
    }
    
    private func zeroDate(for date: Date) -> Date {
        let components = Self.calendar.dateComponents([.year, .month, .day], from: date)
        return Self.calendar.date(from: components) ?? date
    }
}
