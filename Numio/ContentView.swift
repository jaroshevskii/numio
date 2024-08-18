//
//  ContentView.swift
//  Numio
//
//  Created by Sasha Jaroshevskii on 18.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        VStack {
            Text("Difference: \(calculateDifference()) minutes")
                .padding()
            
            HStack {
                VStack {
                    DatePicker(
                        "Start Time",
                        selection: $startDate,
                        displayedComponents: [.hourAndMinute]
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                    
                    HStack {
                        Button(action: { adjustStartDate(by: 15) }) {
                            Text("+15 min")
                        }
                        .padding()
                        
                        Button(action: { adjustStartDate(by: -15) }) {
                            Text("-15 min")
                        }
                        .padding()
                    }
                }
                
                VStack {
                    DatePicker(
                        "End Time",
                        selection: $endDate,
                        displayedComponents: [.hourAndMinute]
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                    
                    HStack {
                        Button(action: { adjustEndDate(by: 15) }) {
                            Text("+15 min")
                        }
                        .padding()
                        
                        Button(action: { adjustEndDate(by: -15) }) {
                            Text("-15 min")
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    // Function to format date for display
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // Function to calculate the difference between the two times
    func calculateDifference() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: startDate, to: endDate)
        return components.minute ?? 0
    }
    
    // Function to adjust the start time
    func adjustStartDate(by minutes: Int) {
        startDate = Calendar.current.date(byAdding: .minute, value: minutes, to: startDate) ?? startDate
    }
    
    // Function to adjust the end time
    func adjustEndDate(by minutes: Int) {
        endDate = Calendar.current.date(byAdding: .minute, value: minutes, to: endDate) ?? endDate
    }
}


#Preview {
    ContentView()
}
