import Foundation
import SwiftUI
import WidgetKit

class DayViewModel: ObservableObject {
    @AppStorage ("years", store: UserDefaults(suiteName: "group.com.hana.CountDays")) var years: Int = 0
    @AppStorage ("months", store: UserDefaults(suiteName: "group.com.hana.CountDays")) var months: Int = 0
    @AppStorage ("days", store: UserDefaults(suiteName: "group.com.hana.CountDays")) var days: Int = 0
    @AppStorage ("formattedDate", store: UserDefaults(suiteName: "group.com.hana.CountDays")) var formattedDate: String = ""
    
    @Published var selectedDate: Date = Date() {
        didSet {
            formattedDate = formatDate(selectedDate)
            integers = calculateIntegers(selectedDate)
            years = integers[0]
            months = integers[1]
            days = integers[2]
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    var selectedDateBinding: Binding<Date> {
        Binding(get: { self.selectedDate }, set: { self.selectedDate = $0 })
    }
    
    init() {
        formattedDate = formatDate(currentDate)
        print(selectedDate)
    }

    @Published var integers: [Int] = [0, 0]

    let currentDate = Date()
    let calendar = Calendar.current

    private func formatDate(_ date: Date) -> String {
        DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
    
    private func calculateIntegers(_ selectedDate: Date) -> [Int] {
        let components = calendar.dateComponents([.year, .month, .day], from: selectedDate, to: currentDate)
        return [components.year ?? 0, components.month ?? 0, components.day ?? 0]
    }
    
}
