//
//  EmojiRangerWidget.swift
//  EmojiRangerWidget
//
//  Created by MIsono on 2020/06/28.
//  Copyright © 2020 Apple. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: IntentTimelineProvider {
    public typealias Entry = SimpleEntry
    
    func timeline(for configuration: DynamicCharacterSelectionIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let selectedCharactor = CharacterDetail.characterFromName(name: configuration.hero?.identifier)
        let endDate = selectedCharactor.fullHealthDate
        let oneMinute: TimeInterval = 60
        var currentDate = Date()

        var entries: [Entry] = []
        while currentDate < endDate {
            let relevance = TimelineEntryRelevance(score: Float(selectedCharactor.healthLevel))
            let entry = SimpleEntry(date: currentDate, charactor: selectedCharactor, relevance: relevance)
            currentDate += oneMinute
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    typealias Intent = DynamicCharacterSelectionIntent

//    func caracter(for configuration: DynamicCharacterSelectionIntent) -> CharacterDetail {
//        switch configuration.hero {
//        case .panda:
//            return .panda
//        case .egghead:
//            return .egghead
//        case .spouty:
//            return .spouty
//        default:
//            return .panda
//        }
//    }

    public func snapshot(for configuration: DynamicCharacterSelectionIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), charactor: .panda, relevance: nil)
        completion(entry)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let charactor: CharacterDetail
    let relevance: TimelineEntryRelevance?
}

struct PlaceholderView : View {
    var body: some View {
        EmojiRangerWidgetEntryView(entry: SimpleEntry(date: Date(), charactor: .panda, relevance: nil))
        /// - Attention: This is not available yet.
        /// - seeAlso: https://developer.apple.com/forums/thrzead/650564
//            .isPlaceholder(true)
    }
}

struct EmojiRangerWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            ZStack {
                AvatarView(entry.charactor)
                    .foregroundColor(.white)
            }.background(Color.gameBackground)
        default:
            ZStack {
                HStack {
                    AvatarView(entry.charactor)
                    Text(entry.charactor.bio)
                        .padding()
                        .foregroundColor(.white)
                }
                .padding()
                .widgetURL(entry.charactor.url)
            }
            .background(Color.gameBackground)
        }
        
    }
}

struct EmojiRangerWidget: Widget {
    private let kind: String = "EmojiRangerWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: DynamicCharacterSelectionIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            EmojiRangerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Emoji Ranger Detail")
        .description("Keep track of your favorite emoji ranger.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

/// - Attention: Check this demo on the「+Add Widget」view is a real Device ONLY. (simulator doesn't show)
/// - seeAlso: https://developer.apple.com/forums/thread/650640?answerId=614999022#614999022
struct EmojiRangerWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmojiRangerWidgetEntryView(entry: SimpleEntry(date: Date(), charactor: .panda, relevance: nil))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            PlaceholderView()
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
