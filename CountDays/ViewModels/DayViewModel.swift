import Foundation
import SwiftUI

class DayViewModel: ObservableObject {
    @Published var selectedDate: Date = Date() {
        didSet {
            print(selectedDate)
            formattedDate = formatDate(selectedDate)
            daysFromSelected = calculateDaysFromSelected(selectedDate)
            monthsFromSelected = calculateMonthsFromSelected(selectedDate)
        }
    }
    
    var selectedDateBinding: Binding<Date> {
            Binding(get: { self.selectedDate }, set: { self.selectedDate = $0 })
        }
    
    init() {
        formattedDate = formatDate(currentDate)
        print(selectedDate)
    }

    @Published var formattedDate: String = ""
    @Published var daysFromSelected: Int = 0
    @Published var monthsFromSelected: Int = 0

    let currentDate = Date()
    let calendar = Calendar.current

    private func formatDate(_ date: Date) -> String {
        DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }

    private func calculateDaysFromSelected(_ selectedDate: Date) -> Int {
        let components = calendar.dateComponents([.day], from: selectedDate, to: currentDate)
        return components.day ?? 0
    }

    private func calculateMonthsFromSelected(_ selectedDate: Date) -> Int {
        let components = calendar.dateComponents([.month], from: selectedDate, to: currentDate)
        return components.month ?? 0
    }
}
