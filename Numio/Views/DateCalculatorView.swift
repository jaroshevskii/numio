//
//  DateCalculatorView.swift
//  Numio
//
//  Created by Sasha Jaroshevskii on 29.08.2024.
//

import SwiftUI

struct DateCalculatorView: View {
    @StateObject private var dateCalculator = DateCalculatorViewModel()
    
    var body: some View {
        VStack {
            Text(dateCalculator.formatedDifference)
                .font(.headline)
            
            HStack {
                GeometryReader { geometry in
                    VStack {
                        DatePicker(
                            "Begin Date",
                            selection: Binding(
                                get: { dateCalculator.dateRange.beginDate },
                                set: { dateCalculator.dateRange.beginDate = $0 }
                            ),
                            displayedComponents: [.hourAndMinute]
                        )
                        .frame(height: geometry.size.height / 2)
                        
                        Spacer()
                        
                        HStack {
                            Button("Zero", action: dateCalculator.setZeroDateForBeginDate)
                            
                            Button("Now", action: dateCalculator.setCurentDateForBeginDate)
                        }
                    }
                }
                
                GeometryReader { geometry in
                    VStack {
                        DatePicker(
                            "End Date",
                            selection: Binding(
                                get: { dateCalculator.dateRange.endDate },
                                set: { dateCalculator.dateRange.endDate = $0 }
                            ),
                            displayedComponents: [.hourAndMinute]
                        )
                        .frame(height: geometry.size.height / 2)
                        
                        Spacer()
                        
                        HStack {
                            Button("Zero", action: dateCalculator.setZeroDateForEndDate)
                            
                            Button("Now", action: dateCalculator.setCurentDateForEndDate)
                        }
                    }
                }
            }
            .datePickerStyle(WheelDatePickerStyle())
            .buttonStyle(.bordered)
            .padding()
            .frame(height: 250)
        }
    }
}

#Preview {
    DateCalculatorView()
}
