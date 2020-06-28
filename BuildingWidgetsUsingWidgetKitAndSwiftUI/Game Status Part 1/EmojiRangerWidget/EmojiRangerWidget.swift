//
//  EmojiRangerWidget.swift
//  EmojiRangerWidget
//
//  Created by MIsono on 2020/06/28.
//  Copyright © 2020 Apple. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry
    
    public func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), charactor: .panda)
        completion(entry)
    }

    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), charactor: .panda)]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let charactor: CharacterDetail
}

struct PlaceholderView : View {
    var body: some View {
        AvatarView(.panda)
        /// - Attention: This is not available yet.
        /// - seeAlso: https://developer.apple.com/forums/thrzead/650564
//            .isPlaceholder(true)
    }
}

struct EmojiRangerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        AvatarView(entry.charactor)
    }
}

@main
struct EmojiRangerWidget: Widget {
    private let kind: String = "EmojiRangerWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            EmojiRangerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Emoji Ranger Detail")
        .description("Keep track of your favorite emoji ranger.")
        .supportedFamilies([.systemSmall])
    }
}

/// - Attention: Check this demo on the「+Add Widget」view is a real Device ONLY. (simulator doesn't show)
/// - seeAlso: https://developer.apple.com/forums/thread/650640?answerId=614999022#614999022
struct EmojiRangerWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AvatarView(.panda)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            PlaceholderView()
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
