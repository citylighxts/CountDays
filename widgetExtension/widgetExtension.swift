//
//  widgetExtension.swift
//  widgetExtension
//
//  Created by Hana Azizah on 21/02/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(formattedDate: getSelectedDate(), date: Date(), years: getMyYears(), months: getMyMonths(), days: getMyDays())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(formattedDate: getSelectedDate(), date: Date(), years: getMyYears(), months: getMyMonths(), days: getMyDays())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(formattedDate: getSelectedDate(), date: entryDate, years: getMyYears(), months: getMyMonths(), days: getMyDays())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func getSelectedDate() -> String {
        let defaults = UserDefaults(suiteName: "group.com.hana.CountDays")
        return defaults?.string(forKey: "formattedDate") ?? "No input date"
    }
    
    private func getMyYears() -> Int {
        let defaults = UserDefaults(suiteName: "group.com.hana.CountDays")
        return defaults?.integer(forKey: "years") ?? 0
    }
    
    private func getMyMonths() -> Int {
        let defaults = UserDefaults(suiteName: "group.com.hana.CountDays")
        return defaults?.integer(forKey: "months") ?? 0
    }
    
    private func getMyDays() -> Int {
        let defaults = UserDefaults(suiteName: "group.com.hana.CountDays")
        return defaults?.integer(forKey: "days") ?? 0
    }
    
}

struct SimpleEntry: TimelineEntry {
    let formattedDate: String
    let date: Date
    let years: Int
    let months: Int
    let days: Int
}

struct widgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
//            Text("Current Date:")
//            Text(entry.date, style: .date)
//                .multilineTextAlignment(.center)
            
            Text("**\(entry.years)** *years* **\(entry.months)** *months* **\(entry.days)** *days*")
                .multilineTextAlignment(.center)
                .foregroundStyle(.tint)
                .tint(.pink)
            
            Text("from: **\(entry.formattedDate)**")
                .multilineTextAlignment(.center)
                .foregroundStyle(.tint)
                .tint(.pink)
        }
    }
}

struct widgetExtension: Widget {
    let kind: String = "widgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                widgetExtensionEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                widgetExtensionEntryView(entry: entry)
                    .padding()
                    .background(.white)
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    widgetExtension()
} timeline: {
    SimpleEntry(formattedDate: "", date: .now, years: 1, months: 1, days: 21)
    SimpleEntry(formattedDate: "", date: .now, years: 0, months: 1, days: 21)
}
