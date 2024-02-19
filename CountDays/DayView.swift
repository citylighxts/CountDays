//
//  DayView.swift
//  CountDays
//
//  Created by Hana Azizah on 20/02/24.
//

import SwiftUI

struct DayView: View {
    @State private var showingNewDayView: Bool = false
    @State private var selectedDate: Date?
    
    var body: some View {
        
        NavigationView {
            VStack {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 80, height: 70)
                    .foregroundStyle(.tint)
                    .tint(.red)
                    .padding(.bottom)
                
                let formattedCurrentDate: String = {
                    let currentDate = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .short
                    dateFormatter.timeStyle = .none
                    return dateFormatter.string(from: currentDate)
                }()
                
                let formattedDate: String? = selectedDate.map {
                    DateFormatter.localizedString(from: $0, dateStyle: .short, timeStyle: .none)
                }
                
                let daysFromSelected: Int = {
                    guard let selectedDate = selectedDate else {
                        return 0
                    }
                    let currentDate = Date()
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.day], from: selectedDate, to: currentDate)
                    return components.day ?? 0
                }()
                
                Text("\(daysFromSelected) days from " + (formattedDate ?? formattedCurrentDate))
                    .font(.system(size: 25))
                    .bold()
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingNewDayView = true
                    }) {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.tint)
                            .tint(.brown)
                    }
                }
            }
            .sheet(isPresented: $showingNewDayView,
                   content: {
                NewDayView(newDayPresented: $showingNewDayView, selectedDate: $selectedDate)
            })
        }
        
    }
}

#Preview {
    DayView()
}
