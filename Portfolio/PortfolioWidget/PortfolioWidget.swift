//
//  PortfolioWidget.swift
//  PortfolioWidget
//
//  Created by MIsono on 2020/07/05.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    public typealias Entry = SimpleEntry

    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), portfolioDetail: .alphabetName, relevance: nil)
        completion(entry)
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let selectedPortfolio = PortfolioDetail.find(from: configuration.portfolioName?.identifier)
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let relevance = TimelineEntryRelevance(score: Float(selectedPortfolio.fundProfitLoss))
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, portfolioDetail: selectedPortfolio, relevance: relevance)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    let portfolioDetail: PortfolioDetail
    let relevance: TimelineEntryRelevance?
}

struct PlaceholderView : View {
    var body: some View {
        PortfolioWidgetEntryView(entry: SimpleEntry(date: Date(), portfolioDetail: .alphabetName, relevance: nil))
        /// - Attention: This is not available yet.
        /// - seeAlso: https://developer.apple.com/forums/thrzead/650564
//            .isPlaceholder(true)
    }
}

struct PortfolioWidgetEntryView : View {
    let entry: Provider.Entry
    
    @ViewBuilder
    var body: some View {
        PortfolioView(portfolioDetail: entry.portfolioDetail, updateDate: entry.date)
    }
}

@main
struct PortfolioWidget: Widget {
    
    private let kind: String = "PortfolioWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            PortfolioWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("ポートフォリオを変更")
        .description("ウィジットに表示するポートフォリオを選んでください")
        .supportedFamilies([.systemSmall, .systemMedium])

    }
}

struct PortfolioWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PortfolioWidgetEntryView(entry: SimpleEntry(date: Date(), portfolioDetail: .alphabetName, relevance: nil))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            PlaceholderView()
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
