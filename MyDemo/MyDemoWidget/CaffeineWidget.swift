//
//  CaffeineWidget.swift
//  MyDemoWidget
//
//  Created by MIsono on 2020/07/03.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: ConfigurationIntent
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct CaffeineWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        CaffeineWidgetView(data: .previewData)
    }
}

@main
struct CaffeineWidget: Widget {
    private let kind: String = "CaffeineWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            CaffeineWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}




struct CaffeineWidget_Previews: PreviewProvider {
    static var previews: some View {
        CaffeineWidgetView(data: .previewData)
    }
}
